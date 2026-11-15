# Homebrew formula for kindling.
#
# Publishes alongside anvil in github.com/eddacraft/homebrew-tap (Formula/kindling.rb).
#
#   brew install eddacraft/tap/kindling
#
# Generate version + checksums: ./scripts/generate-homebrew-formula.sh vX.Y.Z --sync-tap
class Kindling < Formula
  desc "Local memory and continuity engine for AI-assisted development"
  homepage "https://github.com/eddacraft/kindling"
  license "Apache-2.0"

  # Bump per release (bare version, no leading "v").
  version "0.4.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0324235bbc0e2fbf0e8b81f610e425050d6ed66dc839a40379b1c2f482437bac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "69775f047402c5bc7a8a6ed42ffca656517f08a98b602d8d4315316be3bc6545"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5e7e65d42d9d988de3c6982a8854f3fcb5b3bb39dc06371c5906f243348f4a80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc00cc52b0a1012fc41fb7e53f9eab9ab12fcbc1cba09111c3e9eda66cf8c845"
    end
  end

  def install
    bin.install "kindling"
  end

  test do
    assert_match "kindling #{version}", shell_output("#{bin}/kindling --version")
  end
end
