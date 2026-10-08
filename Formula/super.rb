class Super < Formula
  desc "super: a fast, minimal terminal coding agent"
  homepage "https://github.com/chwzr/super"
  version "0.0.36"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.36/super-aarch64-apple-darwin.tar.gz"
      sha256 "119439efa8ecf22a38ed058a7663f95674ab4d7591f6ad9531ec1600df086ffc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.36/super-x86_64-apple-darwin.tar.gz"
      sha256 "77bb1b16b9138062d7917d0d731c5347e5282443689be4028a062850d2e9dcd4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.36/super-aarch64-unknown-linux-musl.tar.gz"
      sha256 "012aadb4cf8dbd323abebdb3b73f935840a86c547deb4b17404fd3825100e4d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.36/super-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2290e58747123f9d28dd886c00e40afc08c35e04403cb79c254f0be84b0d2387"
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
