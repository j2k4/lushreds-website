GCP_PROJECT=lushreds

minimize-css:
	cleancss -O2 -o ./dist/styles.min.css ./src/styles.css ./src/external.css

minimize-html:
	html-minifier --input-dir ./src --output-dir ./dist --file-ext html --collapse-whitespace --remove-comments --minify-css true --minify-js true 

create-404:
	cp ./dist/index.html ./dist/404.html

build: minimize-css minimize-html create-404
	@echo "Build complete"

auth:
	gcloud config set project $(GCP_PROJECT)
	gcloud auth login

deploy: build
	gcloud config set project $(GCP_PROJECT)
	gsutil -m cp -r -z html,css,js,txt,json,svg,xml ./dist/* gs://lushreds-website