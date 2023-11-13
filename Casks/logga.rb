cask "logga" do
  version "1.0.3"
  sha256 "46030f61a0078502b11785f3e8fc4fcf529d66fe9b58aef9cfda4241e9ceacbc"

  url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-client-#{version}.pkg",
    verified: "github.com/logga-app/logga-public/releases/download/"
  name "logga app"
  desc "Audit logging on modern macOS"
  homepage "https://getlogga.com/"

  depends_on macos: ">= :ventura"

  pkg "logga.pkg"
  uninstall pkgutil: "com.logga.client.*",
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