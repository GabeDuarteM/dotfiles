#!/bin/bash
gitCreateBranch() {
	git checkout -b $1
	git push -u origin $1
}
