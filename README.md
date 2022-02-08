# Pyxis
The Prima Assicurazioni's design system.

<img alt="Pyxis Design System" src="pyxis.png" width="100%" />

## ✨ Introduction
Pyxis is our Design System which helps Prima's to build UI-consistent applications.

In order to allow you to build your application, Pyxis offers you a ready-to-use kit with three different technologies and languages.
In addition we also maintain two packages regarding Icons and Design Tokens.

| Package name                               | Description                                                       |
|--------------------------------------------|-------------------------------------------------------------------|
| [`@pyxis/scss`](./packages/pyxis-scss)     | SCSS foundations and components documentation.                    |
| [`@pyxis/elm`](./packages/pyxis-elm)       | Elm components and Elmbook documentation.                   |
| [`@pyxis/react`](./packages/pyxis-react)   | React components and Storybook documentation.               |
| [`@pyxis/tokens`](./packages/pyxis-tokens) | Design Tokens are the bricks in which our foundations are built. |
| [`@pyxis/icons`](./packages/pyxis-icons)   | A collection of icons in svg used in our Design System.           |

## 📚 Documentation
You can take a look at our live-documentation by following:
- [SCSS documentation](https://scss-staging.prima.design/)
- [React documentation](https://react-staging.prima.design/)
- [Elm documentation](https://elm-staging.prima.design/)

## ⌨️ Development
Pyxis was built as a single repository with development simplicity in mind.

To achieve this we had chosen to use [Yarn workspaces](https://classic.yarnpkg.com/en/docs/workspaces/) for dependencies handling and [Lerna](https://github.com/lerna/lerna/) manage versioning and publishing.

Run the following commands to setup your local dev environment:

```sh
# Install `yarn`, alternatives at https://yarnpkg.com/en/docs/install
brew install yarn

# Clone `pyxis`
git clone git@github.com:primait/pyxis.git
cd pyxis

# Install dependencies
yarn install

# Run React live-documentation dev server
yarn storybook:serve

# Run Elm live-documentation dev server
yarn elmbook:serve
```

For a specific documentation about development view the Readme on the sub-repository.

### Generate icons
Pyxis also includes a repository, `@pyxis/icons`, which contains all our SVG icons. We provided a script to turn icons into components within React and Elm.
You can generate icons by running the following command:
```sh
yarn generate:icons
```

### Build Design Tokens
Pyxis foundations is a set of constants obtained by the Design Token entities.

To generate fresh tokens, run the following command:
```sh
yarn tokens:build
```

## 🚧 License
WIP
