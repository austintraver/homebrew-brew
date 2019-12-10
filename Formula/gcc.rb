class Gcc < Formula
  desc "GNU compiler collection"
  homepage "https://gcc.gnu.org/"
  url "https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz"
  sha256 "ea6ef08f121239da5695f76c9b33637a118dcf63e24164422231917fa61fb206"
  version '9.2'

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? do
    reason "The bottle needs the Xcode CLT to be installed."
    satisfy { MacOS::CLT.installed? }
  end

  bottle do
    root_url "https://github.com/austintraver/homebrew-tap/raw/master/Bottles"
    sha256 "cae3defff6e1739bb162313429876af16dabfb9a0dd346b7045d293f51a35590" => :catalina
  end

  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"

  # GCC bootstraps itself, so it is OK to have an incompatible C++ stdlib
  cxxstdlib_check :skip

  # Fix system headers for Catalina SDK
  # (otherwise __OSX_AVAILABLE_STARTING ends up undefined)
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b8b8e65e/gcc/9.2.0-catalina.patch"
    sha256 "0b8d14a7f3c6a2f0d2498526e86e088926671b5da50a554ffa6b7f73ac4f132b"
  end

  def install
    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete "LD"

    osmajor = `uname -r`.split(".").first

    args = %W[
      --build=x86_64-apple-darwin#{osmajor}
      --prefix=#{prefix}
      --with-system-zlib
      --disable-nls
      --disable-multilib
      --enable-languages=c,c++
      --enable-threads=posix
      --enable-checking=release
      --with-gcc-major-version-only
      --with-gmp=#{Formula["gmp"].opt_prefix}
      --with-mpfr=#{Formula["mpfr"].opt_prefix}
      --with-mpc=#{Formula["libmpc"].opt_prefix}
      --with-isl=#{Formula["isl"].opt_prefix}
      --program-transform-name='s/++/xx/'
      --with-native-system-header-dir=/usr/include
      --with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX#{MacOS.version}.sdk
      --with-arch=ivybridge
      --with-tune=skylake
      --without-bootstrap
    ]

    # Ensure correct install names when linking against libgcc_s;
    inreplace "libgcc/config/t-slibgcc-darwin", "@shlib_slibdir@", "#{HOMEBREW_PREFIX}/lib/gcc/9"

    system "./configure", *args

    # Use -headerpad_max_install_names in the build,
    # otherwise updated load commands won't fit in the Mach-O header.
    # This is needed because `gcc` avoids the superenv shim.
    system "make", "-j", "4", "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
    system "make", "-j", "4", "install"

    # Even when we disable building info pages some are still installed.
    info.rmtree
  end
end
