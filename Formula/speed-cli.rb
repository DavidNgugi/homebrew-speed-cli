class SpeedCli < Formula
  desc "Catch your ISP throttling you! Automatic hourly monitoring with a beautiful web dashboard"
  homepage "https://github.com/DavidNgugi/speed-cli"
  url "https://github.com/DavidNgugi/speed-cli/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "a5c576664975a25714f78cde8fdf7a50917d4cade07f31a2392f6e434b499150"
  license "MIT"
  head "https://github.com/DavidNgugi/speed-cli.git", branch: "main"

  depends_on "python@3.9"

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
      Speed CLI has been installed! 

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

      For more information, visit: https://github.com/DavidNgugi/speed-cli
    EOS
  end

  test do
    assert_match "Speed CLI", shell_output("#{bin}/speed --help", 1)
  end
end
