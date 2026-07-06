class TimeboxSkills < Formula
  desc "TimeBox skill pack for Claude Code (/timebox /update /braindump /tasksworkspace)"
  homepage "https://github.com/Happyendingsonly/timebox-skills"
  url "https://github.com/Happyendingsonly/timebox-skills/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "ab5e6b96159a2a3978206b06eeb5513e403ca70de10759c156a42106abe51ef7"
  license "MIT"

  def install
    pkgshare.install "timebox", "update", "braindump", "tasksworkspace", "README.md"

    (bin/"timebox-skills-install").write <<~EOS
      #!/bin/bash
      set -e
      mkdir -p "$HOME/.claude/skills"
      for s in timebox update braindump tasksworkspace; do
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
