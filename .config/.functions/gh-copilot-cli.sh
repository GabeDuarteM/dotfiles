copilot_what-the-shell() {
	TMPFILE=$(mktemp)
	trap 'rm -f $TMPFILE' EXIT
	if $HOME/.local/share/pnpm/global/5/node_modules/@githubnext/github-copilot-cli/cli.js what-the-shell "$@" --shellout $TMPFILE; then
		if [ -e "$TMPFILE" ]; then
			FIXED_CMD=$(cat $TMPFILE)

			eval "$FIXED_CMD"
		else
			echo "Apologies! Extracting command failed"
		fi
	else
		return 1
	fi
}
alias '??'='copilot_what-the-shell'

copilot_git-assist() {
	TMPFILE=$(mktemp)
	trap 'rm -f $TMPFILE' EXIT
	if $HOME/.local/share/pnpm/global/5/node_modules/@githubnext/github-copilot-cli/cli.js git-assist "$@" --shellout $TMPFILE; then
		if [ -e "$TMPFILE" ]; then
			FIXED_CMD=$(cat $TMPFILE)

			eval "$FIXED_CMD"
		else
			echo "Apologies! Extracting command failed"
		fi
	else
		return 1
	fi
}
alias 'git?'='copilot_git-assist'

copilot_gh-assist() {
	TMPFILE=$(mktemp)
	trap 'rm -f $TMPFILE' EXIT
	if $HOME/.local/share/pnpm/global/5/node_modules/@githubnext/github-copilot-cli/cli.js gh-assist "$@" --shellout $TMPFILE; then
		if [ -e "$TMPFILE" ]; then
			FIXED_CMD=$(cat $TMPFILE)

			eval "$FIXED_CMD"
		else
			echo "Apologies! Extracting command failed"
		fi
	else
		return 1
	fi
}
alias 'gh?'='copilot_gh-assist'
alias 'wts'='copilot_what-the-shell'
