# lushreds-website
lushreds official website
https://lushreds.com

### Building the content

run:

```bash
$ make build
```

### Testing locally

Use python's built-in HTTP server to serve the content locally:

```bash
$ python3 -m http.server 8000
```

or use the alias:

```bash
alias www='python3 -m http.server 8000'
$ www
```

Then visit `http://localhost:8000` in your web browser.

### Deployment

Login to google cloud:

```bash
$ make auth
```

Then deploy the content to the Google Cloud Storage bucket:

```bash
$ make deploy
```