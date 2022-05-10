# @primauk/react
This repository is part of the Pyxis Design System and contains all the React components.

## Getting started
You can install and use `@primauk/react` by following these steps:
```sh
# Go to your project root
cd myproject

# Add Pyxis React
yarn add @primauk/react
```

## Usage
```jsx
import { Button } from '@primauk/react';

const MyComponent = () => (
  <Button>This is a button!</Button>
)
```
For more information about each component, check out our [Storybook](https://react-staging.prima.design/).

## Development

`@primauk/react` is part of a `pyxis` monorepo, to develop it you need to download the [project](https://github.com/primait/pyxis).

Once you have installed the monorepo, you will be able to run commands directly from the root of `pyxis`.
Remember that the commands launched by the root are global and could launch commands that also affect other repositories, like: `yarn build`.

#### Development mode with Storybook

```sh
yarn storybook:serve
```
This will start a development Storybook server on `http://localhost:6006`

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

#### Test
```sh
# In pyxis root directory
# Before launching the tests, you need to launch the test-ready storybook build.
yarn storybook:test

# Run test
yarn test
```
---

#### Build Storybook
```sh
# In pyxis root directory
yarn storybook:build
```

This will generate the folder `storybook-static` inside `pyxis-react`.


