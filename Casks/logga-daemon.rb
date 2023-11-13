cask "logga-daemon" do
    version "1.0.3"
    sha256 "dfe1dad17febcc879e1f60f7b578c497184907034f02c05eda349a701c910742"
  
    url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-daemon-#{version}.pkg",
      verified: "github.com/logga-app/logga-public/releases/download/"
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
                "com.logga.client.daemon"
              ]

    uninstall_preflight do
        system_command "/bin/launchctl", args: ["unload", "-w", daemon_path], sudo: true
    end
    
    zap trash: [
      "/Library/Application Support/Logga",
    ]
   
    caveats "To be able to use EndpointSecurity, " \
    "#{token} must be granted Full Disk Access under System Preferences → Security & Privacy → Privacy.\n\n" \
    "Starting the daemon: sudo launchctl load -w /Library/LaunchDaemons/com.logga.client.daemon.service.plist\n" \
    "Stopping the daemon: sudo launchctl load -w /Library/LaunchDaemons/com.logga.client.daemon.service.plist"
  end