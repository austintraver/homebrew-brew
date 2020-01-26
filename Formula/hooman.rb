class Hooman < Formula
  desc "A command line tool to view manpages in your web browser"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/hooman"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/hooman.tgz"
  version "1.1"
  sha256 "0cb752544e9e8249c668cd68ecaf408d1ec635f34d20697b4ad9f57636f170ac"

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
