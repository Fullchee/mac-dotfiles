# Files


alias cat=bat
alias -s {js,json,env,md,html,css,toml}=cat
alias vsc=code
alias o.="o ."

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias la="eza --icons --grid --all"
alias ls='eza --git --icons --grid --git-ignore'
alias ll='eza -la --git --icons'
alias searchtree='eza --tree --icons --git-ignore | fzf'

# Arguments:
#   Depth (int) (optional, default=2)
# Usage:
#	tree . 1
# 	tree folder_name 2
tree() {
	eza --tree --icons --git-ignore -L "${2:-2}" "${1:-.}"
}


# start vim at the end of the file
vimend () {
    vim '+normal Go' $1
}


# use fd so that it respects .gitignore
# https://github.com/junegunn/fzf#respecting-gitignore

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'c

# Fuzzy find all files and subdirectories of the working directory, and output the selection to STDOUT.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Fuzzy find all subdirectories of the working directory, and run the command "cd" with the output as argument.
export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"

## suffix aliases
# https://www.stefanjudis.com/today-i-learned/suffix-aliases-in-zsh/
alias -s {js,json,env,gitignore,md,html,css,toml}=cat

alias ...="cd ../.."
alias ....="cd ../../.."

#### File and folder helpers START

mkcd() {
  mkdir "$1"
  cd "$1"
}

function diffdir() {
	diff -r $1 $2 | grep $1 | awk '{print $4}'
}

function t() {
	# Defaults to 3 levels deep, do more with `t 5` or `t 1`
  	# pass additional args after
	tree -I '.git|node_modules|.DS_Store' --dirsfirst -L ${1:-3} -aC $2
}

# asdf/fileName.ext => fileName
function extract-filename() {
	fullfile="$1"
	filename=$(basename "$fullfile")  # asdf/fieleName.ext => fileName.ext
	echo "${filename%.*}"  # fileName.ext => fileName
}


# Hide/show all desktop icons (useful when presenting)
alias hide-desktop-icons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias show-desktop-icons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

update-raycast-config() {
	cd ~/.dotfiles
  	for file in Raycast\ 202*.rayconfig; do
		# Check if the file exists and matches the pattern
		if [[ -f "$file" ]]; then
			mv -f "$file" "Raycast.rayconfig"
		fi
	done
	cd - > /dev/null
}



## File Manipulation/editing START

### Video, Audio and YouTube

time_diff() {
    # Convert the time strings to seconds
    start_seconds=$(date -u -d "$1" +%s)
    end_seconds=$(date -u -d "$2" +%s)

    # Calculate the difference in seconds
    diff_seconds=$((end_seconds-start_seconds))

    # Convert the difference back to the HH:MM:SS format
    diff_time=$(date -u -d @"$diff_seconds" +'%T')

    echo $diff_time
}

slice-av() {
	if [ -z "$3" ] ; then
        echo 'Usage: slice-av input.mp4 75 400'
		echo 'Usage: slice-av input.mp3 00:45:45 00:45:59'
        return
    fi
	# extension="${$1##*.}"
	ffmpeg -ss "$2" -i "$1" -t "$3" -vcodec copy -acodec copy "output.$extension"
}

compressmp4() {
	if [ -z "$1" ] ; then
		echo 'Usage: compressmp4 "file_path"'
		echo "Just use handbrake"
		return
	fi
	ffmpeg -i "$1" -acodec mp2 "compressed-$1"
}

function compressmp4folder() {
	for file in "$PWD"/*; do
		ffmpeg -i "$file" -acodec mp2 "${file/.mp4/s.mp4}"
	done
}

# ~/youtube-dl --extract-audio --audio-format mp3 "$url"
function youtube-worst-audio() {
	if [ -z "$1" ] ; then
		echo 'Usage: youtube-worst-audio url1 url2 url3 ...'
		return
   	fi
	for url in "$@"
	do
		~/yt-dlp --extract-audio --audio-format mp3 --audio-quality worst -o "%(title)s.%(ext)s" --parse-metadata "title:%(title)s.replace(r' \[[a-zA-Z0-9_-]{11}\]$', '')" "$url"
	done
}

function youtube-best-audio() {
	if [ -z "$1" ] ; then
		echo 'Usage: youtube-best-audio url1 url2 url3 ...'
		return
   	fi
	for url in "$@"
	do
		~/youtube-dl --extract-audio -f bestaudio -o "%(title)s.%(ext)s" "$url"
	done
}
alias y3-best=youtube-best-audio

# downloads a webm video
#yt-dlp "$url"

function youtube-worst-video() {
	for url in "$@"
	do
		~/youtube-dl -f "worstvideo[height>=480][ext=webm]+worstaudio[ext=webm]/worst" -o "%(title)s.%(ext)s" "$url"
	done
}

alias y3=youtube-worst-audio
alias y4=youtube-worst-video
alias youtube="cd ~/Library/CloudStorage/GoogleDrive-fullcheezhang@gmail.com/My\ Drive/YouTube"

mp3tomp4() {
    if [ -z "$1" ] ; then
        echo 'Usage: mp3tomp4 mp3File'
        return
    fi
	ffmpeg -loop 1 -i blank.jpg -i "$1" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest output.mp4
}

alias create-blank-jpg="ffmpeg -f lavfi -i color=c=black:s=1280x720 -t 1 blank.jpg"

function giftomp4() {
	ffmpeg -i $1 -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" $1.mp4
}

function mp3slice() {
    if [ -z "$1" ] ; then
        echo 'Usage: mp3slice input.mp3 HH:MM:SS.mmm HH:MM:SS:mmm output.mp3'
        return
    fi
    ffmpeg -i "$1" -ss "$2" -to "$3" -c copy "$4"
}

function concatmp3() {
	if [ -z "$3" ] ; then
		echo 'Usage: concatmp3 file1.mp3 file2.mp3 output.mp3'
		return
	fi
	ffmpeg -i "concat:$1|$2" -acodec copy "$3"
}

### Images

function shrinkimage() {
	if [ -z "$1" ] ; then
		echo 'Usage: shrinkimage src dest size'
		return
	fi
	convert "$1" -resize x"$3" "$2"
}

# adds a dropshadown to an image
function dropshadow () {
	if [ -z "$1" ] ; then
        echo 'Usage: dropshadow filename.png'
        return
    fi

    filename=$(basename -- "$1")
    # extension="${filename##*.}"
    basename="${filename%.*}"
    # we want to enforce png (even if .jpg as input)
    suffix=".png"
    convert "$1" \( +clone -background black -shadow 50x10+5+5 \) +swap -background none -layers merge +repage "$basename$suffix"
}

### Text

function md2word() {
	if [ -z "$1" ] ; then
		echo 'Usage: md2word src dest'
		return
	fi
	pandoc -o "$2" -f markdown -t docx "$1"
}


#### PDF
# requires ghostscript (gs)
# usage: compresspdf <pdf filename>
function compresspdf() {
	if [ -z "$1" ] ; then
	        echo 'Usage: compresspdf <pdf filename>'
        	return
   	fi
    /usr/local/bin/gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

function compressresume() {
	rm -f ~/projects/portfolio/public/assets/Fullchee-Resume.pdf;
	compresspdf ~/Downloads/Fullchee-Resume.pdf ~/projects/portfolio/public/assets/Fullchee-Resume.pdf;
}
alias resume="cd ~/projects/portfolio/public/assets"

flatten-pdf() {
	if [ -z "$1" ] ; then
		echo 'Usage: flatten-pdf existing.pdf flattened.pdf'
		return
   	fi
	convert -density 150 $1 $2
}
###### End of PDF

download-site-offline() {
	args=(
		--limit-rate=200k 	#  limit download to 200 Kb /sec
		--no-clobber 		#  don't overwrite any existing files (used in case the download is interrupted and resumed)
		--convert-links 	#  links work locally, offline, instead of pointing to a website online
		--random-wait  		#  random waits between download - websites dont like their websites downloaded
		-r  				#  recursive - downloads full website
		-p 					#  downloads everything even pictures (same as --page-requsites, downloads the images, css stuff and so on)
		-E 					#  gets the right extension of the file, without most html and other files have no extension
		-e robots=off 		#  act like we are not a robot/crawler - websites dont like robots/crawlers unless they're a search engine
		-U mozilla 			#  pretends to be just like a browser Mozilla
		# --no-parent : don't ascend in the path hierarchy (useful for just getting a "/docs/" section)
	    # --domains=domain-list # Set domains to be followed.  domain-list is a comma-separated list of domains.  Note that it does not turn on -H.
		# --exclude-domains domain-list  # Specify the domains that are not to be followed.
	)
	wget "${args[@]}" $1
}
