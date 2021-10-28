class Drain < Formula
  desc "A command line tool to free up clogged ports"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/drain"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/drain.tgz"
  version "1.11"
  sha256 "19a00158f4a3df6d06c9883b709505f40058ced3d9dcb3fb05f58b909bfc6786"

  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/drain"
    man.mkpath
    man1.install "man/drain.1"
  end

end
