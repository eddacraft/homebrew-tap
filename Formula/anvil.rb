class Anvil < Formula
  desc "Anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/eddacraft/anvil"
  version "0.7.4-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.4-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "f5153456104b5f51b3e777c16dcbe64bd558ac16c793c5ca63e016cf8598d0c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.4-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "d0871e16d2f628f16279ebeae8d56c13659c2b46c7e893062393a87f824c98bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.4-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9adf173378d2c2e9e114d609cfaaf1007c56493fbd59964d3b3515e0c205bad2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.4-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e4bbf7db59869af5f194a4414bf06137822b8b65b3b77fa3831ced32c710389"
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
