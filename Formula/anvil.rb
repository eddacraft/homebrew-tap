class Anvil < Formula
  desc "Anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/eddacraft/anvil"
  version "0.3.3-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.3.3-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "b76cb7449b421d966e1ff528044d13496d243e08e4c931a978600fed3754722d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.3.3-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "3c8057de73f8cba93890be3d4153b2a32dc8d3b8bd6b22f380eca84e43c39c3d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/anvil/releases/download/v0.3.3-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a970affe7d84d8a8a55e2f66319ba2babf301e147cae81540cfd62e132117da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/anvil/releases/download/v0.3.3-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b08a715dcf5c55ce85afa50a869d564f34d0979c0dcdb541c8d29ab4dc934c95"
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
