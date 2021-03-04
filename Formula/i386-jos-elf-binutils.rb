class I386JosElfBinutils < Formula
  homepage "https://www.gnu.org/software/binutils/"
  desc "GNU binary utility commands for i386-jos-elf"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz"
  sha256 "f67c632ccd81137d745681672bb4515a3411afa53722ccf01caa07d798fd8fb0"
  license "GPL-3.0-or-later"
  version "2.36"

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
