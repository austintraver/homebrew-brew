class I386JosElfGcc < Formula
  homepage "https://gcc.gnu.org"
  desc "GNU compiler collection for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz"
  sha256 "27e879dccc639cd7b0cc08ed575c1669492579529b53c9ff27b0b96265fa867d"
  license "GPL-3.0-or-later"
  version "10.2.0"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "i386-jos-elf-binutils"

  def install
    mkdir "i386-jos-elf-gcc-build" do
      system "../configure", "--target=i386-jos-elf",
                             "--prefix=#{prefix}",
                             "--infodir=#{info}/i386-jos-elf-gcc",
                             "--disable-werror",
                             "--disable-libssp",
                             "--disable-libmudflap",
                             "--disable-nls",
                             "--with-newlib",
                             "--with-as=#{Formula["i386-jos-elf-binutils"].bin}/i386-jos-elf-as",
                             "--with-ld=#{Formula["i386-jos-elf-binutils"].bin}/i386-jos-elf-ld",
                             "--enable-languages=c"
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"

      # FSF-related man pages may conflict with native gcc
      (share/"man/man7").rmtree
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end
