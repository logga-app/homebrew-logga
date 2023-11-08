cask "logga-daemon" do
    version "1.0.0"
    sha256 "f0a67ef4be65ff645db6fbcccafb5c734cbbbbc98b2aa1c98b7aa1b64135a579"
  
    url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-daemon.pkg",
      verified: "github.com/logga-app/logga-public/releases/download/"
    name "logga daemon"
    desc "Audit logging on modern macOS"
    homepage "https://getlogga.com/"
  
    depends_on macos: ">= :ventura"
  
    daemon_path = "/Library/LaunchDaemons/com.logga.client.daemon.plist"

    pkg "logga-daemon.pkg"
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