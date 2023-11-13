cask "logga-daemon" do
    version "1.0.3"
    sha256 "d8b65b0252b88d305739f3bd76695a648504f7978ae91e18619e617c5c87516e"
  
    url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-daemon-#{version}.pkg",
      verified: "github.com/logga-app/logga-public/releases/download/"
    name "logga daemon"
    desc "Audit logging on modern macOS"
    homepage "https://getlogga.com/"
  
    depends_on macos: ">= :ventura"
  
    daemon_path = "/Library/LaunchDaemons/com.logga.client.daemon.plist"

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
   
    caveats do
      license "BSD 3-Clause"
    end
  end