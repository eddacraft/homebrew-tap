class Anvil < Formula
  desc "Anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/eddacraft/anvil"
  version "0.6.1-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.6.1-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "0fb6ffcff1561e9ea91a49d66ee4a7306885602f95b7fbae14cc06ed72168884"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.6.1-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "1541f5e017c9d3ad0e760bfa4157305fad33a85906deca9941f0a76be2be5e06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.6.1-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f7a67eab029c901eeb029711b8c634823e2c96ae48a24014f6323de68e3838a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.6.1-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb4e900cb4e451af2c5cf1b8ca8f9c5f336481cda70140a5e86561fb06bc8af8"
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
