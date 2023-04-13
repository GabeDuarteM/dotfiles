git-checkout() {
	git rev-parse HEAD >/dev/null 2>&1 || return

	local branch

	if [[ "$1" = "." ]]; then
		git checkout .
		return
	elif [[ "$1" = '-' ]]; then
		git checkout -
		return
  elif [[ "$1" = '-b' ]]; then
    git checkout -b $2
    return
  elif

	branch=$(fzf-git-branch $1)
	if [[ "$branch" = "" ]]; then
		echo "No branch selected."

		return
	fi

	# If branch name starts with 'remotes/' then it is a remote branch. By
	# using --track and a remote branch name, it is the same as:
	# git checkout -b branchName --track origin/branchName
	if [[ "$branch" = 'remotes/'* ]]; then
		git checkout --track $branch
	else
		git checkout $branch
	fi
}
