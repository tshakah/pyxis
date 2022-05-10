# @primauk/scss
This repository is part of Pyxis Design System, and contain all the foundations and the components in SCSS.

## Usage
Pyxis can be used as a standalone unit by projects which do not rely on _Elm_ or _React_ for the frontend.

If you use one of the technologies above please check the following section.

### Using Pyxis UI Toolkit

- [Use Pyxis with React](https://github.com/primait/pyxis/tree/master/packages/pyxis-react)
- [Use Pyxis with Elm](https://github.com/primait/pyxis/tree/master/packages/pyxis-elm)

If you want to use Pyxis with a custom framework or for simple purposes please continue reading.

### Using Pyxis standalone version

- [Use Pyxis SCSS](#use-pyxis-via-scss)
- [Configuring Pyxis](#configuring-pyxis)
- [Development](#development)

---

#### Use Pyxis via SCSS
You can install and use `@primauk/scss` by following these steps:
```sh
# Go to your project root
cd myproject

# Add Pyxis Scss
yarn add @primauk/scss

# Go to your `scss` entrypoint and import Pyxis
# with `@use pyxis-scss/src/scss/pyxis.scss`
```

#### Configuring Pyxis

You can redefine some variables (those defined in `pyxis-scss/src/scss/config.scss`) by writing something like that:

```scss
// Require the configuration module and override the $fontDisplay variable.
// Using the @use directive we ensure CSS is never repeated in case of multiple requirements.
@use "~pyxis-scss/src/scss/config.scss" with ($fontDisplay: "fallback");

// Pyxis core module will now use your $fontPath variable.
@forward "~pyxis-scss/src/scss/pyxis.scss";
```

---

### Pyxis SCSS module system

Pyxis is a complex entity made up of:
- a `foundation` module _(required)_
- a `components` module _(optional)_

#### Foundations module
This module is a collection of rules, directives, and utility classes which define a common look & feel for all our applications.

It is intended to be used only for simple settings like:

- typography
- colors
- spacing
- containers
- etc...

#### Components module

Here is where the things get complex. Pyxis gives you a powerful UI kit in order to get things done easily.

Each of these modules is paired with a [React](https://github.com/primait/pyxis/tree/master/packages/pyxis-react) and an [Elm](https://github.com/primait/pyxis/tree/master/packages/pyxis-elm) version of the component.

---

### Development

`@primauk/scss` is part of a `pyxis` monorepo, to develop it you need to download the [project](https://github.com/primait/pyxis).

Once you have installed the monorepo, you will be able to run commands directly from the root of `pyxis`.
Remember that the commands launched by the root are global and could launch commands that also affect other repositories, like: `yarn build`.

#### Development mode

```sh
# Go inside `pyxis-react`
cd pyxis/packages/pyxis-scss
yarn serve
```
This will start a development server on `localhost:8080`

---

#### Lint code
```sh
# In pyxis root directory
yarn lint

# To autofix errors reported by stylelint
yarn lint:fix
```
---

#### Build
```sh
# In pyxis root directory
yarn build
```

This will create a `dist` folder (inside `pyxis-scss`) in which you'll find a `pyxis.css` file.

---

#### Build SassDoc
```sh
# In pyxis root directory
yarn sassdocs:build
```

This will generate the folder `sassdoc` inside `pyxis-scss`.


