cask "logga" do
  version "1.0.3"
  sha256 "0ddc7fc1f3871e46d1d9a994e5bd589fa161c5de6added4fe68f6dd444262726"

  url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga-client-#{version}.pkg",
    verified: "github.com/logga-app/logga-public/releases/download/"
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
 
  caveats "To be able to use EndpointSecurity, " \
  "#{token} must be granted Full Disk Access under System Preferences → Security & Privacy → Privacy"
end