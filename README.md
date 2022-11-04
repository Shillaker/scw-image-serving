# Scaleway serverless container image serving

Demonstration using [Scaleway Serverless Containers](https://www.scaleway.com/en/serverless-containers/) from the browser to handle normal API requests and serve images.

## Setup

- Install and configure [Terraform](https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/install-cli)
- Install the [Scaleway CLI](https://github.com/scaleway/scaleway-cli#installation)

## Local test

Test the server locally by running:

```
python3 container/server.py
```

Then open `index.html` in your browser, e.g.

```
firefox index.html
```

## Running on serverless containers

```
terraform init
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

