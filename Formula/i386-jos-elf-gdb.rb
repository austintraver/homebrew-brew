class I386JosElfGdb < Formula
  homepage "https://www.gnu.org/software/gdb/"
  description "GNU compiler collection for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz"
  sha256 "f12f388b99e1408c01308c3f753313fafa45517740c81ab7ed0d511b13e2cf55"
  license "GPL-3.0-or-later"
  version "10.1"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--program-prefix=i386-jos-elf-",
                          "--disable-nls",
                          "--disable-werror"
    system "make", "all"
    system "make", "install"
    # avoid conflict with binutil
    if Formula["i386-jos-elf-binutils"].any_version_installed?
      rm_r share/"info"
      rm_r lib
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gdb -v"
  end
end
