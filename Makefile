bin := node_modules/.bin

run_tests := $(bin)/mocha --check-leaks --recursive test --compilers ls:LiveScript
.PHONY: test
test:
	NODE_PATH=$(src) $(run_tests) --reporter mocha-unfunk-reporter --timeout 3000 $(args)
