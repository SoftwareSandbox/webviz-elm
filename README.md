# Visualizing a webservices landscape with Elm
This web application tries to answer the question _Why?_ a certain webservice is userd by a certain application.

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

## VSCode config

You can also get added help for VSCode when coding in Elm.

### Install the Elm extensions

You'll want both the `elm` and `elm-format` extensions.

Optional: `HTML to Elm`, and I guess `Subword Navigation`.

### After installation of the extensions
The elm-format VSCode extension requires a locally installed `elm-format` binary.

```bash
npm install -g elm-format
```

Open your settings in VSCode (`ctrl+,` or `cmd+,`) and put this in there: 
```
"elm.formatOnSave": true
```