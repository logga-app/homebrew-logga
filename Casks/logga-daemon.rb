cask "logga-daemon" do
    version "1.0.0"
    sha256 "89e408b6f53a16461889aa3741157720c435a1f104379a09e4e002035e9b819e"
  
    url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-daemon.pkg",
      verified: "github.com/logga-app/logga-public/releases/download/"
    name "logga daemon"
    desc "Audit logging on modern macOS"
    homepage "https://getlogga.com/"
  
    depends_on macos: ">= :ventura"
  
    pkg "logga-daemon.pkg"
    uninstall pkgutil: "com.logga-daemon.*",
              delete: "/Library/Application Support/Logga",
              launchctl: [
                "com.logga.client.daemon.plist"
              ]
    
    zap trash: [
      "/Library/Application Support/Logga",
    ]
   
    caveats do
      license "BSD 3-Clause"
    end
  end