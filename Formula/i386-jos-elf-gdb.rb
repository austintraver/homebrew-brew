class I386JosElfGdb < Formula
  homepage "https://www.gnu.org/software/gdb/"
  desc "GNU debugger for i386-jos-elf cross compilation and development"
  url "https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz"
  sha256 "f12f388b99e1408c01308c3f753313fafa45517740c81ab7ed0d511b13e2cf55"
  license "GPL-3.0-or-later"
  version "10.1"

  depends_on "python@3.9"
  depends_on "xz" # required for lzma support


  conflicts_with "gdb", because: "both install include/gdb, share/gdb and share/info"
  conflicts_with "x86_64-elf-gdb", because: "both install include/gdb, share/gdb and share/info"


  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--program-prefix=i386-jos-elf-",
                          "--disable-nls",
                          "--disable-werror"
                          "--disable-debug"
                          "--disable-dependency-tracking"
                          "--with-lzma"
                          "--with-python=#{Formula["python@3.9"].opt_bin}/python3"
                          "--disable-binutils"

    system "make"
    system "make", "install-gdb"
    # avoid conflict with binutil
    # if Formula["i386-jos-elf-binutils"].any_version_installed?
    #   rm_r share/"info"
    #   rm_r lib
    # end
  end

  test do
    system "#{bin}/i386-jos-elf-gdb -v"
  end
end
