#!/usr/bin/env bash
# Remembers which Claude session runs in which tmux pane so that tmux-resurrect can resume them.
#   hook    - Claude SessionStart hook which tags the current pane with the session id from stdin
#   save    - resurrect post-save hook which snapshots the panes still running Claude
#   restore - resurrect post-restore hook which runs `claude --resume` in each snapshotted pane
set -euo pipefail
state="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/claude-sessions.tsv"

case "${1:-}" in
  hook)
    id="$(jq -r '.session_id // empty')"
    if [ -n "${TMUX_PANE:-}" ] && [ -n "$id" ]; then
      tmux set -p -t "$TMUX_PANE" @claude_session "$id"
    fi
    ;;
  save)
    mkdir -p "$(dirname "$state")"
    # A pane back at its shell has exited Claude, so its stale tag is skipped.
    tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index}	#{pane_current_command}	#{@claude_session}" \
      | awk -F'\t' '$3 != "" && $2 !~ /^(fish|bash|zsh|sh)$/ {print $1 "\t" $3}' > "$state"
    ;;
  restore)
    [ -f "$state" ] || exit 0
    while IFS=$'\t' read -r target id; do
      tmux send-keys -t "$target" "claude --resume $id" Enter
    done < "$state"
    ;;
  *) echo "usage: $0 hook|save|restore" >&2; exit 1 ;;
esac
