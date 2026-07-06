class TimeboxSkills < Formula
  desc "TimeBox skill pack for Claude Code (/timebox /update /braindump /tasksworkspace /handover)"
  homepage "https://github.com/Happyendingsonly/timebox-skills"
  url "https://github.com/Happyendingsonly/timebox-skills/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "b985855ee071b6bafd97184beb5a0170e2d67749921c6a97b1082287fcfad9c5"
  license "MIT"

  def install
    pkgshare.install "timebox", "update", "braindump", "tasksworkspace", "handover", "README.md"

    (bin/"timebox-skills-install").write <<~EOS
      #!/bin/bash
      set -e
      mkdir -p "$HOME/.claude/skills"
      for s in timebox update braindump tasksworkspace handover; do
        ln -sfn "#{opt_pkgshare}/$s" "$HOME/.claude/skills/$s"
      done
      echo "TimeBox skills linked into ~/.claude/skills."
      echo "Open a NEW Claude Code session and type /timebox to set up your key."
    EOS
    chmod 0755, bin/"timebox-skills-install"
  end

  def caveats
    <<~EOS
      To activate the skills, run:
        timebox-skills-install

      Then open a new Claude Code session and type /timebox.
      Get Claude Code: https://claude.com/claude-code
    EOS
  end

  test do
    assert_path_exists pkgshare/"timebox/SKILL.md"
    assert_path_exists pkgshare/"timebox/scripts/tb.sh"
  end
end
