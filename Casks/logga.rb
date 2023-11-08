cask "logga" do
  version "1.0.0"
  sha256 "hash"

  url "https://github.com/logga-app/logga-public/releases/download/#{version}/logga.pkg",
  name "logga"
  desc "Audit logging on modern macOS"
  homepage "https://getlogga.com/"

  depends_on macos: ">= :ventura"

  pkg "logga.pkg"
  uninstall pkgutil: "com.logga.*"

  zap trash: [
    "/Library/Application Support/Logga",
  ],
  rmdir: [
    "/Library/Application Support/Logga",
  ]

  caveats do
    license "BSD 3-Clause"
  end
end