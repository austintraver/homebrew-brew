class I386JosElfBinutils < Formula
  homepage "https://www.gnu.org/software/binutils/"
  desc "GNU binary utility commands for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz"
  sha256 "f67c632ccd81137d745681672bb4515a3411afa53722ccf01caa07d798fd8fb0"
  license "GPL-3.0-or-later"
  version "2.36"

  bottle do
    root_url "https://github.com/austintraver/homebrew-tap/raw/master/Bottles"
    sha256 big_sur: "35b9101e36e0d2deeab88cafdb2092c0d523aafd7f8a4c0f8c93642f7273c3f1"
  end

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? do
    reason "The bottle needs the Xcode CLT to be installed."
    satisfy { MacOS::CLT.installed? }
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--disable-werror",
                          "--disable-nls"
    system "make"
    system "make", "install"
    # avoid conflict with gdb
    if Formula["i386-jos-elf-gdb"].any_version_installed?
      rm_r share/"info"
      rm_r lib
    end
  end

  test do
    system "#{bin}/i386-jos-elf-objdump -i"
  end
end
