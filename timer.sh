# Determine the operating system.
OS_NAME="$(uname)"

# Define default session timings.
DEFAULT_WORK_PERIOD="50"
DEFAULT_BREAK_PERIOD="10"


# Define a timer function for break sessions.
break_timer() {
  local break_period="$1"
  local message="Pomodoro"
  local title="Break is over! Get your ass up here! Now! 👇"
  local sound="Crystal"

  # Start the timer with the configurations.
  timer "${break_period}m" && terminal-notifier -message "$message"\
    -title "$title"\
    -sound "$sound"

  return
}


# Define a timer function for work sessions.
work_timer() {
  local work_period="$1"
  local message="Pomodoro"
  local title="Tring-tring! Take a break now! 😊"
  local icon="/Users/cloudwick/Pictures/chill_guy.png"
  local sound="Crystal"

  # Start the timer with the configurations.
  timer "${work_period}m" && terminal-notifier -message "$message"\
    -title "$title"\
    -appIcon "$icon"\
    -sound "$sound"

  # Start a break timer automatically when a work session ends.
  if [ "$?" -eq 0 ]; then
    break_timer "$DEFAULT_BREAK_PERIOD"
  fi

  return
}


# Define a function to handle program invocations.
pomodoro() {
  if [ "$OS_NAME" = "Darwin" ]; then
    local arg="${(L)1}"
  else
    local arg="${1,,}"
  fi

  case "$arg" in
    "work")
      work_timer "$DEFAULT_WORK_PERIOD"
      ;;
    "break")
      break_timer "$DEFAULT_BREAK_PERIOD"
      ;;
    *)
      if [[ "$arg" =~ [0-9]+$ ]]; then
        work_timer "$arg"
      fi
      ;;
  esac

  return
}


pomodoro "$1"
exit 0