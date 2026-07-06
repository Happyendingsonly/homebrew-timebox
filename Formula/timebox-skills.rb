class TimeboxSkills < Formula
  desc "TimeBox skill pack for Claude Code (/timebox /update /braindump /tasksworkspace /handover /promptguide)"
  homepage "https://github.com/Happyendingsonly/timebox-skills"
  url "https://github.com/Happyendingsonly/timebox-skills/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "6ac5ee834f5fa3c4f1b5bd890e53cc069f91c62eb6ef3be4980d349da7c116b6"
  license "MIT"

  def install
    pkgshare.install "timebox", "update", "braindump", "tasksworkspace", "handover", "promptguide", "README.md"

    (bin/"timebox-skills-install").write <<~EOS
      #!/bin/bash
      set -e
      mkdir -p "$HOME/.claude/skills"
      for s in timebox update braindump tasksworkspace handover promptguide; do
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
