bin := node_modules/.bin
limit := 5000

run_tests := $(bin)/mocha --check-leaks --recursive test --compilers ls:LiveScript
.PHONY: test
test:
	NODE_PATH=$(src) $(run_tests) --reporter mocha-unfunk-reporter --slow $(limit) --timeout $(limit) $(args)
