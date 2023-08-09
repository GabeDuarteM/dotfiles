function gitGetCurrentBranch() {
	git rev-parse --abbrev-ref HEAD
}
