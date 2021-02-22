class Drip < Formula
  desc "A utility for discovering internet address properties"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/drip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/drip.tgz"
  version "1.1"
  sha256 "1e5b535d926518b109ea5eb26f5deec4712f3482e65242e00041ad5a64db75c9"

  bottle :unneeded
  depends_on :macos => :catalina

  def install
    bin.install "bin/drip"
    man.mkpath
    man1.install "man/drip.1"
  end

end
