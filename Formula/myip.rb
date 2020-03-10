class Myip < Formula
  desc "A tool to discovery your current public & private IP"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/myip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/myip.tgz"
  version "2.0"
  sha256 "3ee1a039ffc73d8b143b9f356321baaf2c6564c7ff2da6beb7f2a07189069acd"

  bottle :unneeded
  depends_on :macos => :catalina

  def install
    bin.install "bin/myip"
    man.mkpath
    man1.install "man/myip.1"
  end

end
