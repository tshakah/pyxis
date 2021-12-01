# pyxis-scss

The Prima Assicurazioni's design system.

<img alt="Pyxis Design System" src="https://primait.invisionapp.com/assets/A_MGFjZjlkZDY2YjhlM2JmOcFk5Abzk3TRKxwC2DizMEC_4iALnd1rcz3A4sLpUZhZLAeTWF6uAwL4P5Wms5DGkWJqJGcTJbrH-nJvJ-Ijn0aqwJqoMNrGTe-44N-QSOJmH0sBBqsqThhHMvL4qhtgVA==" width="100%" />

## Table of contents

Pyxis can be used as a standalone unit by projects which do not rely on _Elm_ or _React_ for the frontend.

If you use one of the technologies above please check the following section.

##### Using Pyxis UI Toolkit

- [Use Pyxis with React](https://github.com/primait/pyxis-react)
- Use Pyxis with Elm _(coming soon)_

If you want to use Pyxis with a custom framework or for simple purposes please continue reading.

##### Using Pyxis standalone version

- [Use Pyxis SCSS](#use-pyxis-via-scss-recommended)
- [Use Pyxis CSS](#use-pyxis-via-css-not-recommended)
- [Configuring Pyxis](#configuring-pyxis)
- [Pyxis Development](#pyxis-development)

---

### Use Pyxis via SCSS _(recommended)_

You can install and use Pyxis foundations by following these steps:

- go to your project root
- run `yarn add pyxis-scss`
- go to your `scss` entrypoint
- import Pyxis with `@use pyxis-scss/src/scss/pyxis.scss`

### Use Pyxis via CSS

- go to your project root
- run `yarn add pyxis-scss`
- require `pyxis-scss/dist/pyxis.css` in your framework or HTML

---

### Configuring Pyxis

You can redefine some variables (those defined in `pyxis-scss/src/scss/config.scss`) by writing something like that:

```scss
// Require the configuration module and override the $fontDisplay variable.
// Using the @use directive we ensure CSS is never repeated in case of multiple requirements.
@use "~pyxis-scss/src/scss/config.scss" with ($fontDisplay: "fallback");

// Pyxis core module will now use your $fontPath variable.
@forward "~pyxis-scss/src/scss/pyxis.scss";
```

### Pyxis SCSS module system

Pyxis is a complex entity made up of:

- a `foundation` module _(required)_
- a `components` module _(optional)_

#### Foundations module

This module is a collection of rules, directives, and utility classes which define a common look & feel for all our applications.

Is intended to be used only for simple settings like:

- typography
- colors
- spacing
- containers
- etc.

#### Components module

Here is where the things get complex. Pyxis gives you a powerful UI kit in order to get things done easily.

Each of these modules is paired with a [React](https://github.com/primait/pyxis-react) and an Elm version of the component.

---

### Pyxis Development

##### Build CSS version

Run `yarn build` in Pyxis root directory.

This will create a `dist` folder in which you'll find a `pyxis.css` file.

##### Run development mode with code change detection

Run `yarn serve` in Pyxis root directory.

This will start a development server on `localhost:8080`

##### Lint code

Run `yarn lint` in Pyxis root directory.

To autofix errors reported by stylelint
Run `yarn lint:fix` in Pyxis root directory.
