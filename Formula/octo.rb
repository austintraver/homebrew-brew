class Octo < Formula
  desc "A command line tool to check octal file permission codes"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/octo"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/octo.tgz"
  version "1.7"
  sha256 "05383b6592850b65678d50ce968ceb29fe2907224c4b6d86b61ff92dcf299fa1"

  depends_on "coreutils"
  depends_on :macos => :catalina

  def install
  # bin.install Dir["bin/*"]
    bin.install "bin/octo"
    man.mkpath
    man1.install "man/octo.1"
  end

end
