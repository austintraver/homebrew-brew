class I386JosElfGdb < Formula
  homepage "https://www.gnu.org/software/gdb/"
  desc "GNU debugger for i386-jos-elf cross compilation and development"
  url "https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz"
  sha256 "f12f388b99e1408c01308c3f753313fafa45517740c81ab7ed0d511b13e2cf55"
  license "GPL-3.0-or-later"
  version "10.1"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-tap"
    rebuild 1
    sha256 big_sur: "9624860f7ca2017249fcc91127b34491af5f6682e0b0554ae6956a5045ecfed9"
  end

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? do
    reason "The bottle needs the Xcode CLT to be installed."
    satisfy { MacOS::CLT.installed? }
  end

  depends_on "python@3.9"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--with-gdb-datadir=#{pkgshare}"
                          "--disable-werror"
                          "--with-python=#{Formula["python@3.9"].opt_bin}/python3"

    system "make"
    system "make", "install"
    
    # avoid conflict with binutils
    rm_rf include
    rm_rf lib
    rm_rf share/"locale"
    rm_rf share/"info"
  end

  test do
    system "#{bin}/i386-jos-elf-gdb -v"
  end
end
