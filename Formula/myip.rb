class Myip < Formula
  desc "A tool to discovery your current public & private IP"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/myip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/myip.tgz"
  version "2.1"
  sha256 "1e5b535d926518b109ea5eb26f5deec4712f3482e65242e00041ad5a64db75c9"

  bottle :unneeded
  depends_on :macos => :catalina

  def install
    bin.install "bin/myip"
    man.mkpath
    man1.install "man/myip.1"
  end

end
