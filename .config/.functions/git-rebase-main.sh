gitRebaseMain() {
	git rebase origin/$(git remote show origin | grep "HEAD branch" | sed 's/.*: //')
}
