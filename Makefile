all: deploy_test

# deploy as an html5 game for test, run by opening main.html in a browser
deploy_test:
	-rm -r bin
	mkdir bin
	coffee -cmo bin coffee
	coffee -cmo bin nodejs_web
	coffee -cmo bin vendor/atom
	cp vendor/jquery.js bin/
	cp vendor/Canvas-Sprite-Animations/sprite.min.js bin/
	python nodejs_web/populate_html.py "DEV"

# deploy as an html5 game for production
deploy: deploy_test
	python nodejs_web/populate_html.py "PROD"

# run the test suit using node.js
test:
	jasmine-node --coffee spec/

# automatically test whenever a change is made
watch:
	jasmine-node --coffee spec/ --autotest --watch . --noStack

# run a terminal version of the program using node.js
run:
	coffee coffee/main_console.coffee
