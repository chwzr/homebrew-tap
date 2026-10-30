class Super < Formula
  desc "super: a fast, minimal terminal coding agent"
  homepage "https://github.com/chwzr/super"
  version "0.0.39"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.39/super-aarch64-apple-darwin.tar.gz"
      sha256 "b02d712e2219dffd4775139580ebedca23f2c46cace8c2f9861b840d6ab0154d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.39/super-x86_64-apple-darwin.tar.gz"
      sha256 "d4efe7502b30934979eb43890b5bbefa7147405145aa10e9c68c1be635f34a7e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.39/super-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d37dd6eca2597053e9deb9ee12da0e25f6986d97bc7f634301389c2f9e9affb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.39/super-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f03bdf21a774e8b7333cd737b8ebe8a10d7dc99d2935d18c265621fead0ecdf"
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
