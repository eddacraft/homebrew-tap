class Anvil < Formula
  desc "anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/eddacraft/anvil"
  version "0.11.0-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.11.0-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "fa4e9e796c8ff9eb18d9276640a3cad5e13ab06ba0679f6d42c2c3c224d503b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.11.0-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "33178ef727272b5b84810673982a5443aadf5f70f0640236612be6ebcfa40dc5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.11.0-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7c41c7bda97b6447f3bfa856156cb3436670b8ce3002a9be3ac3af7bdc85eea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.11.0-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81411b6025663f94028a17b1ffef49d244341e2d2e202d358080d657f4c34016"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
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
      bin.install "anvil"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "anvil"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "anvil"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "anvil"
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
