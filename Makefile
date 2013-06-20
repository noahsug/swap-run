all: deploy

# deploy as an html5 game, run by opening main.html in a browser
deploy:
	-rm -r bin
	mkdir bin
	coffee -cmo bin coffee
	coffee -cmo bin nodejs_web
	coffee -cmo bin vendor
	python nodejs_web/populate_html.py

# run the test suit using node.js
test:
	jasmine-node --coffee spec/

# automatically test whenever a change is made
watch:
	jasmine-node --coffee spec/ --autotest --watch . --noStack

# run a terminal version of the program using node.js
run:
	coffee coffee/main_console.coffee
