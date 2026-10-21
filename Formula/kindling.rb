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
  version "0.4.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "81bf7a1564fc7f2f23e140a285c1ae43b9105ee2af4b2ee401259de2760c320f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7fb0653f3c926a5d6a32f6a3e3cf93d4851818d71aab20be2f2748eae8c2c4f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "11e2712f26896433121b79c8f69995a1a75b092a5b77a22273052d52010d6b5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eddacraft/kindling/releases/download/v#{version}/kindling-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd9d549d194177f4a81a008ce9f0d218c00b20a565aac7ac332ee4dfabab69cf"
    end
  end

  def install
    bin.install "kindling"
  end

  test do
    assert_match "kindling #{version}", shell_output("#{bin}/kindling --version")
  end
end