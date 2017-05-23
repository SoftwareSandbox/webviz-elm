# Visualizing a webservices landscape with Elm
This web application tries to answer the question _Why?_ a certain webservice is userd by a certain application.

[![Build Status](https://travis-ci.org/SoftwareSandbox/webviz-elm.svg?branch=master)](https://travis-ci.org/SoftwareSandbox/webviz-elm)

## Get it working on your machine
1. Clone this repository

2. Install [Elm](http://elm-lang.org)

3. Install Elm stuff

```bash
elm package install
```

4. Install elm-test

Because elm-test isn't available as regular binary, you'll need Node and install it via NPM.
```bash
npm install -g elm-test
```

5. Run Elm stuff

```bash
elm-reactor
```

6. Run tests

```bash
elm-test
```
Add the `--watch` flag if you want them to be continuously run.

GL HF!
