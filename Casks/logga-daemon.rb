cask "logga-daemon" do
  version "1.1.2"
  sha256 "fb6317cf63aeab7cb9452f133a67e5387b84ae5c87a74ec64cc299a84c2690d8"

  url "https://storage.getlogga.com/logga-daemon-#{version}.pkg",
    verified: "storage.getlogga.com"
  name "logga daemon"
  desc "Audit logging on modern macOS"
  homepage "https://getlogga.com/"

  depends_on macos: ">= :ventura"

  daemon_path = "/Library/LaunchDaemons/com.logga.client.daemon.service.plist"
  pkg "logga-daemon-#{version}.pkg"
  uninstall pkgutil: "com.logga.daemon.*",
            delete: [
              "/Library/Application Support/Logga",
              daemon_path
            ],
            launchctl: [
              "com.logga.client.daemon.service"
            ]
  uninstall_preflight do
      system_command "/bin/launchctl", args: ["unload", "-w", daemon_path], sudo: true
  end
  
  zap trash: [
    "/Library/Application Support/Logga",
  ]

  caveats "To be able to use EndpointSecurity, "   "#{token} must be granted Full Disk Access under System Preferences → Security & Privacy → Privacy.\n\n"   "Starting the daemon: sudo launchctl load -w /Library/LaunchDaemons/com.logga.client.daemon.service.plist\n"   "Stopping the daemon: sudo launchctl load -w /Library/LaunchDaemons/com.logga.client.daemon.service.plist"
end
