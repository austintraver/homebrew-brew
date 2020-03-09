class Myip < Formula
  desc "A tool to discovery your current public & private IP"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/myip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/myip.tgz"
  version "1.9"
  sha256 "0a97e922db6646c291efc5ef73c09bd2a5a8f3fa5e0e3bd1c0de7359e766d031"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/myip"
    man.mkpath
    man1.install "man/myip.1"
  end

end
