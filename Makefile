all: deploy_fast

# Create bin/ with required files to run the game.
# Specify required .js files in nodejs_web/populate_html.py.
deploy: deploy_fast
	python nodejs_web/populate_html.py "PROD"

# Same as deploy, but required .js files are generated automatically.
# Note: May cause console errors due to incorrect file order.
deploy_fast:
	-rm -r bin
	mkdir bin
	coffee -cmo bin coffee
	coffee -cmo bin nodejs_web
	coffee -cmo bin vendor/atom
	cp vendor/jquery.js bin/
	cp vendor/Canvas-Sprite-Animations/sprite.min.js bin/
	python nodejs_web/populate_html.py "DEV"

# Run the test suit using node.js.
test:
	jasmine-node --coffee spec/

# Automatically run tests whenever a change is made.
watch:
	jasmine-node --coffee spec/ --autotest --watch . --noStack
