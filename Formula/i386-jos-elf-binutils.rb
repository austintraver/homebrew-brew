class I386JosElfBinutils < Formula
  homepage "https://www.gnu.org/software/binutils/"
  desc "GNU binary utility commands for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz"
  sha256 "f67c632ccd81137d745681672bb4515a3411afa53722ccf01caa07d798fd8fb0"
  license "GPL-3.0-or-later"
  version "2.36"
  
  bottle do
    root_url "https://homebrew.bintray.com/bottles-tap"
    rebuild 1
    sha256 big_sur: "1d2674534012c5cb8b7b8cf986675fa9b3b23c32513f46b004a589db4dcf3ea8"
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
    
    info.rmtree
  end

  test do
    system "#{bin}/i386-jos-elf-objdump -i"
  end
end
