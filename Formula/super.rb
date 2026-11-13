class Super < Formula
  desc "super: a fast, minimal terminal coding agent"
  homepage "https://github.com/chwzr/super"
  version "0.0.40"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.40/super-aarch64-apple-darwin.tar.gz"
      sha256 "ef6f502a6477cfbe1d3ae83443502a1c4a9f40fea34e4ced6b980d9b73d96fe7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.40/super-x86_64-apple-darwin.tar.gz"
      sha256 "2697b248b0c73d777537da28a887e9d6695f3f9fdb95f42a3f7c32703e5435f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.40/super-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fdf29238d3c8495314599f8d3b46146e3a5b99ec62e783bc516ca752e2a0c035"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.40/super-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d24c8416c93d70dc38b98237d0e19741d9faa315821a18bbe94e934d97b66b33"
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
