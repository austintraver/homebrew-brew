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

  uses_from_macos "zlib"
  
  # GCC bootstraps itself, so it is OK to have an incompatible C++ stdlib
  cxxstdlib_check :skip

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
    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete "LD"

    args << "SED=/usr/bin/sed"
    # Xcode 10 dropped 32-bit support
    args << "--disable-multilib" if DevelopmentTools.clang_build_version >= 1000

    # System headers may not be in /usr/include
    sdk = MacOS.sdk_path_if_needed
    if sdk
      args << "--with-native-system-header-dir=/usr/include"
      args << "--with-sysroot=#{sdk}"
    end

    # Ensure correct install names when linking against libgcc_s;
    # see discussion in https://github.com/Homebrew/legacy-homebrew/pull/34303
    inreplace "libgcc/config/t-slibgcc-darwin", "@shlib_slibdir@", "#{HOMEBREW_PREFIX}/lib/gcc"

    languages = %w[c c++ fortran]

    pkgversion = "Homebrew GCC #{pkg_version} #{build.used_options*" "}".strip
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"

    args = %W[
      --target=i386-jos-elf
      --prefix=#{prefix}
      --with-as=#{Formula["i386-jos-elf-binutils"].bin}/i386-jos-elf-as
      --with-ld=#{Formula["i386-jos-elf-binutils"].bin}/i386-jos-elf-ld
      --with-gmp=#{Formula["gmp"].opt_prefix}
      --with-mpfr=#{Formula["mpfr"].opt_prefix}
      --with-mpc=#{Formula["libmpc"].opt_prefix}
      --with-isl=#{Formula["isl"].opt_prefix}
      --with-pkgversion=#{pkgversion}
      --enable-languages=#{languages.join(",")}
      --with-newlib
      --with-system-zlib
      --disable-nls
    ]

    mkdir "build" do
      system "../configure", *args
      # Use -headerpad_max_install_names in the build,
      # otherwise updated load commands won't fit in the Mach-O header.
      # This is needed because `gcc` avoids the superenv shim.
      system "make", "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
      system "make", "install"
    end

  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end
