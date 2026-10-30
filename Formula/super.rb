class Super < Formula
  desc "super: a fast, minimal terminal coding agent"
  homepage "https://github.com/chwzr/super"
  version "0.0.38"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.38/super-aarch64-apple-darwin.tar.gz"
      sha256 "e83cc056b60ec64bee498a5d679e5388d3df46297c040514018413f438f656aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.38/super-x86_64-apple-darwin.tar.gz"
      sha256 "2c66ad8985e8f4abeea7f22152b159a03b8bdb50401e6f9742f57a16266cde14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chwzr/super/releases/download/v0.0.38/super-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2446c4b14f3a431ba34fd6c6f911908c5ec89786c2e2b6842f1ee35d52ff58f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chwzr/super/releases/download/v0.0.38/super-x86_64-unknown-linux-musl.tar.gz"
      sha256 "00d6812a887670afa13262a0a32e343c2703e7d83d480c9a4b20ed3832b9cbfa"
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
