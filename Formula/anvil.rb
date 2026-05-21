class Anvil < Formula
  desc "Anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/eddacraft/anvil"
  version "0.7.0-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.0-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "be994028046c9e032ed3c7fbb5f6e6837c0094b6afb30e78bd234bab67eee6e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.0-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "315446e4ee63c82a8ff92df93b4b85671630fb046380205d03907bda125bec6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.0-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "917c30b078e257bedc3ba2d33ac31fbf647b477913e64cbc7b511d2f935d7912"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.7.0-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a003baaf71096150a6ae3f13f632b1c7fd84ded7cd53e1cd71fd6ad04597a1dd"
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
