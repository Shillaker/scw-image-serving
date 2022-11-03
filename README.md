# Scaleway serverless container image serving

Demonstration using [Scaleway Serverless Containers](https://www.scaleway.com/en/serverless-containers/) from the browser to handle normal API requests and serve images.

Please see the [Scaleway Serverless Framework Plugin](https://github.com/scaleway/serverless-scaleway-functions) for setup instructions.

*Note that Serving images from Serverless containers is not recommended, instead you should use a CDN.*

## Local test

Test locally by running:

```
python3 container/server.py
```

Then opening `index.html` in your browser, e.g.

```
firefox index.html
```

## Running on serverless containers

Deploy the container by running the following:

```
serverless deploy
```

This will return a URL through which you can invoke the function.

Then run the following to generate your token:

```
serverless jwt
```

Open `index.html` and set:

- `token` to your function's token
- `functionUrl` to your function's URL

Then open the `index.html` file in your browser, e.g.

```
firefox index.html
```

