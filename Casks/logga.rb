cask "logga" do
  version "1.1.0"
  sha256 "74d07f0cad4d999808510bf34c0c548ed5284fb12ef9847d3bb71fb35ac3f7c7"

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
