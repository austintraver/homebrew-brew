class Netme < Formula
  desc "A discovery utility for network address information"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/netme"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/netme.tgz"
  version "2.1"
  sha256 "1e5b535d926518b109ea5eb26f5deec4712f3482e65242e00041ad5a64db75c9"

  bottle :unneeded
  depends_on :macos => :catalina

  def install
    bin.install "bin/netme"
    man.mkpath
    man1.install "man/netme.1"
  end

end
