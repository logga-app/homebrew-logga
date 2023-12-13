cask "logga" do
  version "1.0.6"
  sha256 "8d63ce7a88a13d44e5b1f685f6ee3ca269c6552f2351aa9d20f44b0dc451a867  logga-client-1.0.6.pkg"

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
