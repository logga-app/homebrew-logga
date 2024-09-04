cask "logga" do
  version "1.1.2"
  sha256 "a79aa4949886d232ad0ed41c167c492aed19d3fc017909f52179c38d629eeeba"
  url "https://storage.getlogga.com/logga-client-#{version}.pkg",
    verified: "storage.getlogga.com"
  name "logga app"
  desc "Audit logging on modern macOS"
  homepage "https://getlogga.com/"
  depends_on macos: ">= :ventura"
  pkg "logga-client-#{version}.pkg"
  uninstall pkgutil: "com.logga.client.*",
            delete: "/Library/Application Support/Logga"
  uninstall_preflight do
    system_command "/Applications/logga.app/Contents/MacOS/logga", args: ["unload"], sudo: false
  end
  zap trash: [
    "/Library/Application Support/Logga",
  ]

  caveats "To be able to use EndpointSecurity, "   "#{token} must be granted Full Disk Access under System Preferences → Security & Privacy → Privacy"
end
