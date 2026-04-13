class Anvil < Formula
  desc "Structural governance for AI-assisted development"
  homepage "https://eddacraft.ai"
  version "0.3.1-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "26969d0635c4069d92732590b81bb38164d8153f367f79655a13dce2eda5d38b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "92ba53273caeb746fb1dee3781e2b7437a17868625e44b46e4ea80fcd86b5e83"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7965c38e5affeae1334a71669d68a09fba6abeb683067f8c2a808fdfd3e26b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47b7ba9942e67ad97ca0d9f876836a4fb929fc9dbf7dc1fae24e9f96ee69e9e2"
    end
  end
  license "LicenseRef-Proprietary"

  def install
    bin.install "anvil"

    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match "anvil", shell_output("#{bin}/anvil --version")
  end
end
