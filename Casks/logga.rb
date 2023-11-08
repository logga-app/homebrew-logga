cask "logga" do
  version "1.0.0"
  sha256 "326a78e6ef17a1c260620dcb9013e6f961e219ff22db41e40143c25f97c7cdfc"

  url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga.pkg",
    verified: "github.com/logga-app/logga-public/releases/download/"
  name "logga app"
  desc "Audit logging on modern macOS"
  homepage "https://getlogga.com/"

  depends_on macos: ">= :ventura"

  pkg "logga.pkg"
  uninstall pkgutil: "com.logga.*",
            delete: "/Library/Application Support/Logga"

  uninstall_preflight do
    system_command "/Applications/logga.app/Contents/MacOS/logga", args: ["unload"], sudo: false
  end

  zap trash: [
    "/Library/Application Support/Logga",
  ]
 
  caveats do
    license "BSD 3-Clause"
  end
end