cask "logga-daemon" do
  version "1.1.1"
  sha256 "f4fcf86e5ad5790907f1f7cad512e4ae812506582960eed1186aeccd36c79888"

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
