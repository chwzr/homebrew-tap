class Super < Formula
  desc "super: a fast, minimal terminal coding agent"
  homepage "https://github.com/chwzr/super"
  version "0.0.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.37/super-aarch64-apple-darwin.tar.gz"
      sha256 "c16d76e779b1f9cb7e8e9671eec76bdaebda96a1ee0d820ff514f111e7527452"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.37/super-x86_64-apple-darwin.tar.gz"
      sha256 "d8ec5e0c45fd2c8f5ef60b4f2b9aebcd28a8f1254c271bda47286a9292a12969"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.37/super-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d3b43388ea822fbaef04c89c2f4c35f608565dc4a797084796885e95fb6f15ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.37/super-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d7fa3610207df52a0a11c411843d972aef9da3d48482b343459f18f9bfb38129"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "super"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "super"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "super"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "super"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
