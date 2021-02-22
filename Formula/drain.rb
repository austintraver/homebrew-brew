class Drain < Formula
  desc "A command line tool to free up clogged ports"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/drain"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/drain.tgz"
  version "1.8"
  sha256 "049b8615eaa779d999269e99e893d5d0c145bd6adc04dce2b8e88630f30ac112"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/drain"
    man.mkpath
    man1.install "man/drain.1"
  end

end
