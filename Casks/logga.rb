cask "logga" do
  version "1.0.0"
  sha256 "d4bf7bd79d49eebc2b2cd9672f83902362b36c630e7ed4ce4978fad5685f059c"

  url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga.pkg",
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