class Hooman < Formula
  desc "A command line tool to view manpages in your web browser"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/hooman"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/hooman.tgz"
  version "1.0"
  sha256 "05383b6592850b65678d50ce968ceb29fe2907224c4b6d86b61ff92dcf299fa1"

  bottle :unneeded
  depends_on "gnu-sed"
  depends_on "man-db"
  depends_on :macos => :catalina

  def install
  # bin.install Dir["bin/*"]
    bin.install "bin/hooman"
    # man.mkpath
    # man1.install "man/octo.1"
  end

end
