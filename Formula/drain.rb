class Drain < Formula
  desc "A command line tool to free up clogged ports"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/drain"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/drain.tgz"
  version "1.11"
  sha256 "30fb434aee92b97d4598f1e87e43f06a4b22958024d0bf6e7d0f852434d5bfd0"

  bottle :unneeded
  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
    bin.install "bin/drain"
    man.mkpath
    man1.install "man/drain.1"
  end

end
