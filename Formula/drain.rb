class Drain < Formula
  desc "A command line tool to free up clogged ports"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/drain"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/drain.tgz"
  version "1.8"
  sha256 "7d0c12d67501294911840c943751e4cbf0b718f55dc06ff313921c96a50965c8"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/drain"
    man.mkpath
    man1.install "man/drain.1"
  end

end
