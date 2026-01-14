all: gen lint

gen:
	sbcl --noinform --load gen.lisp --quit

loop:
	while true; do make gen; sleep 5; done

pub: gen co push

co:
	git add -p
	git diff --cached
	@echo 'Type Enter to commit, Ctrl + C to cancel.'; read
	git commit

push:
	git remote remove gh || :
	git remote remove cb || :
	git remote add gh git@github.com:hnpwd/hnpwd.github.io.git
	git remote add cb git@codeberg.org:hnpwd/pages.git
	git push gh main
	git push gh --tags
	git push cb main
	git push cb --tags

lint:
	tidy -q -e index.html
