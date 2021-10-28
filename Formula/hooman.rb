class Hooman < Formula
  desc "A command line tool to view manpages in your web browser"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/hooman"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/hooman.tgz"
  version "1.2"
  sha256 "5ccd0489789819ff43837fd3548b9c7ff184857e9be1f090fff39ef75339e374"

  depends_on "gnu-sed"
  depends_on "man-db"
  depends_on :macos => :catalina

  def install
    bin.install Dir["bin/*"]
    share.install Dir["share/*"]
    # man.mkpath
    # man1.install "man/octo.1"
  end

end
