class Myip < Formula
  desc "A tool to discovery your current public & private IP"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/myip"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/myip.tgz"
  version "1.8"
  sha256 "f30f9a03a7eb900ffa1654c4308fbad22aba8c75fd7edc13b5c5fa0ef68b7c18"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/myip"
    man.mkpath
    man1.install "man/myip.1"
  end

end
