gitPullMain() {
	git pull origin $(git remote show origin | grep "HEAD branch" | sed 's/.*: //') -r
}
