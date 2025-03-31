export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# --- CONFIG
# use 'config' instead of 'git' to manage this git repo, lose all git auto-complete commands :(
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' $@
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' $@
alias save-crontab='sudo crontab -l >| ~/.backup-crontab.sh'
alias pull='git stash && git pull && git stash pop'
alias copy-tech-notes="~/learning/notes/copy-to-tech-notes.sh"

alias it="git"  # common typo
alias gc="git commit -a --no-verify -m"
alias gs="git st"
alias fetchmerge="git fetch && git merge origin/main --no-edit"
alias fm=fetchmerge

alias viewpr="gh pr view --web"

switchpr() {
	GH_FORCE_TTY=100% gh pr list --assignee "fullchee" | tail -n +2 | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

pulls() {
	GH_FORCE_TTY=100% gh pr list --assignee "fullchee" | tail -n +2 | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr view --web
}

function configpush() {
	config add -u
	if [ -z "$1" ] ; then
		config commit -m "$(date)"
	else
  		config commit -m $1
	fi
	config pull
	config push
}
alias pushconfig="configpush"

function pushnotes() {
	git -C ~/learning/notes add -A
	if [ -z "$1" ] ; then
		git -C ~/learning/notes commit -m "$(date)"
	else
  		git -C ~/learning/notes commit -m $1
	fi
	git -C ~/learning/notes pull;
	git -C ~/learning/notes push;
}

function rm_branch() {
	branch_name=`git rev-parse --abbrev-ref HEAD`;
	git stash;
	git checkout main;
	git branch -D $branch_name;
	git pull;
	git stash pop;
}

function delete_remote_branch() {
	if read -q "choice?Delete remote branch? (Y/y)"; then
		branch_name=`git rev-parse --abbrev-ref HEAD`;
		git push origin --delete $branch_name;
	else
		echo "Not deleting remote branch"
		exit 1
	fi
}

function delete_remote_and_local_branch() {
	if read -q "choice?Delete remote branch? (Y/y)"; then
		branch_name=`git rev-parse --abbrev-ref HEAD`;
		git push origin --delete $branch_name;
		delete_current_branch
	else
		echo "Not deleting remote branch"
		exit 1
	fi
}


# git sparse checkout
# I use this when setting up my config dotfiles
# so I only have the files that I want in the git repo
# instead of all of the files in my home directory
# TODO: what is sparse checkout?
function sparse-checkout() {
	if [ -z "$1" ] ; then
		echo 'Usage: sparse-checkout <url>'
		return
	fi

	giturl="$1"
	filename=$(basename "$giturl")
	filename="${filename%.*}"

	mkdir $filename
	cd $filename
	git init
	git remote add -f origin $giturl
	git config core.sparseCheckout true

	echo "\n"
	echo "Add the directories you wish to pull\n"
	echo '    echo "some/dir/" >> .git/info/sparse-checkout\n'
	echo "\n"
	echo 'When you are done, pull\n'
	echo '    git pull origin main\n'
}

createpr() {
	git stash;
	git switch -c $1;
	git empty-commit  # see .gitconfig
	git push origin $1;
	git set-upstream;
	# using `--web` instead of `--draft` so that the PR description isn't blank and uses the PR template
	gh pr create --assignee "@me" --web;
	git stash pop;
}

pushempty() {
	git commit --allow-empty -m "Trigger GH Actions";
	git push;
}
alias emptycommit="pushempty"

bumpversion() {
	npm version patch --no-git-tag-version;
	git add package.json package-lock.json;
	git commit -m "Bump version";
	git push;
}

push-staged() {
	git commit --no-verify -m "$1";
	git push ;
}

push() {
	git add -u
	push-staged $1
}

pushall() {
	git add -A
	push-staged $1
}

commitconfig() {
	config commit -m $1
	config push
}

# https://www.youtube.com/watch?v=lZehYwOfJAs
recent-branch() {
	git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always" | xargs git checkout
}
alias rb=recent-branch

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
# things for the `lc` command
LC_DELIMITER_START="⋮";
LC_DELIMITER_END="⭐";
