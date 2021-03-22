class I386JosElfGcc < Formula
  homepage "https://gcc.gnu.org/"
  desc "GNU compiler collection for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz"
  sha256 "27e879dccc639cd7b0cc08ed575c1669492579529b53c9ff27b0b96265fa867d"
  license "GPL-3.0-or-later"
  version "10.2"
  head "https://gcc.gnu.org/git/gcc.git"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "i386-jos-elf-binutils"

  bottle do
    root_url "https://github.com/austintraver/homebrew-tap/raw/master/Bottles"
    sha256 big_sur: "da50df061d2646e6deb9eb99f606d32812ec70d810e4e6e71cb18657fae4c26b"
  end

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? do
    reason "The bottle needs the Xcode CLT to be installed."
    satisfy { MacOS::CLT.installed? }
  end

  def install
   binutils = Formulary.factory "i386-jos-elf-binutils"

    args = [
      "--prefix=#{prefix}",
      "--enable-languages=#{languages.join(",")}",
      "--disable-werror",
      "--disable-nls",
      "--disable-libssp",
      "--disable-libmudflap",
      "--disable-multilib",
      "--with-as=#{binutils.bin}/i386-jos-elf-as",
      "--with-ld=#{binutils.bin}/i386-jos-elf-ld",
      "--with-newlib",
      "--without-headers",
      "--target=i386-jos-elf"
    ]

    mkdir "build" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
    end

    # remove miscellaneous files in order to prevent a conflict with 
    # those installed by the canonical GCC package on Homebrew
    info.rmtree
    man7.rmtree
  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end
