class Myip < Formula
  desc "A tool to discovery your current public & private IP"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/myip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/myip.tgz"
  version "1.7"
  sha256 "0b50b1d0067cd4714935c2141cd5cfb60325bfe21a838945979488073a8d9aed"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/myip"
    man.mkpath
    man1.install "man/myip.1"
  end

end
