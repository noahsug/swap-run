# first run 'make deploy' on master
all: clean
	mv bin/* .
	rm *.map
	git checkout master assets
	mv assets/* .
	rm -rf assets
	python fix_paths.py

clean:
	rm *.png
	rm *.js
	rm *.html
