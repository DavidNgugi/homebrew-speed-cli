class SpeedCli < Formula
  desc "Cross-platform speed testing tool with automatic monitoring and beautiful web dashboard. Supports macOS, Linux, and Windows."
  homepage "https://github.com/DavidNgugi/speed-cli"
  url "https://github.com/DavidNgugi/speed-cli/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "67926bc5e8c6a502a1b5fef15752d35e227ee0c354a961813f46525fa0cbdc83"
  license "MIT"
  head "https://github.com/DavidNgugi/speed-cli.git", branch: "main"

  depends_on "python@3.9"
  depends_on "speedtest-cli" => :optional

  def install
    bin.install "src/speed_cli.sh" => "speed"
    bin.install "src/internet_monitor.sh"
    bin.install "src/speed_dashboard.py"
    
    chmod 0755, bin/"speed"
    chmod 0755, bin/"internet_monitor.sh"
    chmod 0755, bin/"speed_dashboard.py"
    
    (etc/"speed-cli").mkpath
    
    doc.install "README.md"
    doc.install "LICENSE"
    doc.install "CHANGELOG.md"
  end

  def post_install
    (var/"log/speed-cli").mkpath
    (HOMEBREW_PREFIX/"etc/speed-cli").mkpath unless (HOMEBREW_PREFIX/"etc/speed-cli").exist?
  end

  def caveats
    <<~EOS
      Speed CLI v1.0.5 has been installed! 

      🚀 NEW FEATURES:
      • Cross-platform support for macOS, Linux, and Windows
      • Automatic dependency management for all platforms
      • Improved speed testing with speedtest-cli integration
      • Reliable fallback methods when primary tools unavailable

      To get started:
        1. Run: speed configure
        2. Set your expected speeds and monitoring frequency
        3. Start monitoring: speed start
        4. Open dashboard: speed dashboard

      The web dashboard will be available at: http://localhost:6432

      Dashboard commands:
        speed dashboard         # Interactive mode
        speed dashboard start   # Background service
        speed dashboard stop    # Stop service
        speed dashboard status  # Check status

      Platform-specific notes:
        • macOS: Full support with all features
        • Linux: Uses speedtest-cli for accurate measurements
        • Windows: PowerShell integration with automated setup

      For more information, visit: https://github.com/DavidNgugi/speed-cli
    EOS
  end

  test do
    assert_match "Speed CLI", shell_output("#{bin}/speed --help", 1)
  end
end
