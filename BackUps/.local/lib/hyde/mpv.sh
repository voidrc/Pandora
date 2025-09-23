#!/usr/bin/env bash
# Music Player with fzf interface

# Configuration
mDIR="$HOME/Music/"
iDIR="$HOME/.local/share/icons/logo.png"
HISTORY_FILE="$HOME/.cache/music_player_history"

# Online Stations
declare -A online_music=(
  ["Lofi Girl"]="https://play.streamafrica.net/lofiradio"
  ["Chillhop"]="http://stream.zeno.fm/f3wvbbqmdg8uv"
  ["Jazz Vibes"]="https://jazz-wr04.ice.infomaniak.ch/jazz-wr04-128.mp3"
)

# Initialize history file
[ -f "$HISTORY_FILE" ] || touch "$HISTORY_FILE"

# Main functions
populate_local_music() {
  local_music=()
  while IFS= read -r -d $'\0' file; do
    local_music+=("$file")
  done < <(find -L "$mDIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" \) -print0)
}

notification() {
  notify-send -u low -i "$iDIR" "Music Player" "$1"
}

play_selection() {
  local selection="$1"
  notification "▶️ Playing: $(basename "$selection")"
  echo "$selection" >> "$HISTORY_FILE"
  mpv --no-video --loop-playlist "$selection"
}

show_main_menu() {
  mode=$(printf "%s\n" "Local Music" "Online Radio" "Play History" "Stop Playback" | \
    fzf --height=20% --reverse --prompt="Music Player > " --header="Select Mode:")
  
  case "$mode" in
    "Local Music") show_local_music ;;
    "Online Radio") show_online_radio ;;
    "Play History") show_history ;;
    "Stop Playback") stop_music ;;
  esac
}

show_local_music() {
  populate_local_music
  [ ${#local_music[@]} -eq 0 ] && {
    notification "No music files found in $mDIR"
    exit 1
  }

  selection=$(printf "%s\n" "${local_music[@]}" | \
    fzf --height=40% --reverse --prompt="Local Music > " \
    --header="Select Song:" --preview="mediainfo {}" --preview-window=right:50%:wrap)
  
  [ -n "$selection" ] && play_selection "$selection"
}

show_online_radio() {
  selection=$(printf "%s\n" "${!online_music[@]}" | \
    fzf --height=30% --reverse --prompt="Online Radio > " --header="Select Station:")
  
  [ -n "$selection" ] && {
    notification "📻 Tuned to: $selection"
    mpv --no-video "${online_music[$selection]}"
  }
}

show_history() {
  [ ! -s "$HISTORY_FILE" ] && {
    notification "No playback history yet"
    exit 0
  }

  selection=$(tac "$HISTORY_FILE" | awk '!seen[$0]++' | \
    fzf --height=40% --reverse --prompt="History > " \
    --header="Recent Plays:" --preview="mediainfo {}")
  
  [ -n "$selection" ] && play_selection "$selection"
}

stop_music() {
  pkill -f "mpv --no-video" && notification "⏹️ Playback stopped"
}

# Keybind mode support
case "$1" in
  --local) show_local_music ;;
  --online) show_online_radio ;;
  --shuffle) 
    populate_local_music
    [ ${#local_music[@]} -gt 0 ] && {
      shuffle=$(printf "%s\n" "${local_music[@]}" | shuf -n 1)
      play_selection "$shuffle"
    }
    ;;
  --stop) stop_music ;;
  --history) show_history ;;
  *) show_main_menu ;;
esac
