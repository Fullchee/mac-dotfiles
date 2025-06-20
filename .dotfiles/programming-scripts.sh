alias sz="source ~/.zshrc"

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

# Add this to your ~/.zshrc file
function lockafter() {
  # Check if a parameter was provided
  if [[ $# -eq 0 ]]; then
    echo "Usage: lockafter <minutes>"
    echo "Example: lockafter 5 (locks after 5 minutes)"
    return 1
  fi

  # Check if the parameter is a number
  if [[ ! $1 =~ ^[0-9]+$ ]]; then
    echo "Error: Please provide a valid number of minutes"
    return 1
  fi

  # Convert minutes to seconds
  local seconds=$(($1 * 60))

  # Inform the user
  echo "Your Mac will lock in $1 minute(s)."

  # Run the lock command in the background, make it harder to cancel
  nohup bash -c "sleep $seconds && pmset displaysleepnow" >/dev/null 2>&1 &
}




## Git: see git-scripts.sh

## Databases
alias copydb=createdb -O postgres -T
renamedb() {
  local old_db_name=$1
  local new_db_name=$2

  if [ -z "$old_db_name" ] || [ -z "$new_db_name" ]; then
    echo "Usage: rename_or_create_db <old_db_name> <new_db_name>"
    return 1
  fi

  echo "Checking if database '$new_db_name' exists..."

  # Check if the new database already exists
  if psql -U fullchee -lqt | cut -d \| -f 1 | grep -qw "$new_db_name"; then
    echo "Database '$new_db_name' already exists."
  else
    echo "Renaming database '$old_db_name' to '$new_db_name'..."
    # Rename the old database to the new name
    psql -U fullchee -c "ALTER DATABASE \"$old_db_name\" RENAME TO \"$new_db_name\";"
    echo "Database '$old_db_name' has been renamed to '$new_db_name'."
  fi
}

# Usage
# rename_or_create_db old_database_name new_database_name


# Usage
# rename_or_create_db old_database_name new_database_name

generate-psql-url() {
	echo "postgresql://$REMOTE_DATABASE_USER:$REMOTE_DATABASE_PASSWORD@localhost:$LOCAL_DATABASE_PORT/$REMOTE_DATABASE_NAME"
}

alias killpostmaster="rm /usr/local/var/postgres/postmaster.pid"
alias fixpsql="killpostmaster"

# mv_table $DB_SRC $DB_DEST "table_name"
function mv_table {
  psql -d $2 -c "TRUNCATE TABLE $3;"
  pg_dump -d $1 --no-owner --no-acl -Fc --table=$3 | pg_restore -d $2 --no-owner --no-acl --table=$3
}


## Databases end

alias rm-known-localhost="sed -i '' '/^\[localhost\]:56789/d' ~/.ssh/known_hosts"

alias randomstring="openssl rand -base64 24"

alias ip="echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

# `pmset displaysleepnow` doesn't work 😞
alias lock-screen="osascript ~/learning/lock-screen.scpt"
alias lock-in-25="(sleep 1500; lock-screen) &; disown %1"
alias lockin25="lock-in-25"

alias stopin30="sudo shutdown -s +30"


killport() {
    if [ -z "$1" ] ; then
        echo 'Usage: killport <portnumber'
        return
    fi
    kill $(lsof -t -i:"$1")
}

### Node

eval "$(fnm env --use-on-cd --shell zsh)"
# for npm global modules without sudo
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH

alias reinstall="rm -rf package-lock.json && rm -rf node_modules && npm i"

# TODO: override fnm and let just run fnm as is unless you explicitly type fnm use
function fnm-use() {
	fnm list | awk '{print $2}' | fzf --header "Pick node version" | xargs fnm use
}
eval "$(fnm env --use-on-cd)"

### pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
### pnpm end
## Node end

function notify() {
	if [ -z "$1" ] ; then
		echo 'Usage: notify <message> time'
		return
	fi
	echo 'notify-send "$1"' | at $2
}


# write current command location to `.zsh_history_ext` whenever a command is ran
# `.zsh_history_ext` is used in `lc` command
function zshaddhistory() {
  # ignore empty commands
  if [[ $1 == $'\n' ]]; then return; fi

  # ignore specific commands
  local COMMANDS_TO_IGNORE=( last ls ll cd j git gss gap lc ggpush ggpull);
  for i in "${COMMANDS_TO_IGNORE[@]}"
  do
    # return if the run commands starts with the ignored commands
    if [[ $1 == "$i"* ]]; then
      return;
    fi
  done

  echo "${1%%$'\n'}${LC_DELIMITER_START}${PWD}${LC_DELIMITER_END}" >> ~/.lc_history
}

# `lc`:  last command
function last() {
  SELECTED_COMMAND=$(grep -a --color=never "${PWD}${LC_DELIMITER_END}" ~/.lc_history | cut -f1 -d "${LC_DELIMITER_START}" | tail -r | fzf);

  # handle case of selecting no command via fzf
  if [[ ${#SELECTED_COMMAND} -gt 0 ]]; then
    echo "Running '$SELECTED_COMMAND'..."
    echo "**************************"
    eval " $SELECTED_COMMAND";
  fi
}

ssm () {
	sed -i '' "/^\[localhost\]:${2}/d" ~/.ssh/known_hosts
	aws ssm start-session --target $3 --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["'${1}'"],"localPortNumber":["'${2}'"]}' --region us-east-1
}


## Android
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK/tools
export PATH=$PATH:$ANDROID_SDK/tools/bin
export PATH=$PATH:$ANDROID_SDK/platform-tools
## Android end


## Python
export PATH="$HOME/.pyenv/bin:$PATH"
export PYTHONSTARTUP=$HOME/.dotfiles/repl_startup.py
alias py=python
eval "$(pyenv init --path)"
PIP_REQUIRE_VIRTUALENV=true
alias ptpy=ptpython
## Python end

# Added by Windsurf
export PATH="/Users/fullcheezhang/.codeium/windsurf/bin:$PATH"
