class Netme < Formula
  desc "A discovery utility for network address information"
  homepage "https://github.com/austintraver/homebrew-tap/Packages/netme"
  url "https://github.com/austintraver/homebrew-tap/raw/master/Archives/netme.tgz"
  version "2.1"
  sha256 "a17dd48f61677bc3656bee6e2560d55603e04a4b19ed4255f068d951fda1eb68"

  depends_on :macos => :catalina

  def install
    bin.install "bin/netme"
    man.mkpath
    man1.install "man/netme.1"
  end

end
