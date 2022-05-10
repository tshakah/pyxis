# Pyxis

Prima's design system.

<img alt="Pyxis Design System" src="pyxis.png" width="100%" />

## ✨ Introduction

Pyxis helps Prima build consistent user interfaces and experiences.

Pyxis is composed of an agnostic _scss framework_ and two _ready-to-use bindings_ for [React](https://reactjs.org/) and [Elm](https://elm-lang.org/).
In addition we also maintain two packages containing _icons_ and _design tokens_.

| Package name                               | Description                                                        |
| ------------------------------------------ | ------------------------------------------------------------------ |
| [`@primauk/scss`](./packages/pyxis-scss)     | SCSS foundations and components documentation.                     |
| [`@primauk/elm`](./packages/pyxis-elm)       | Elm components and Elmbook documentation.                          |
| [`@primauk/react`](./packages/pyxis-react)   | React components and Storybook documentation.                      |
| [`@primauk/tokens`](./packages/pyxis-tokens) | Design Tokens are the bricks from which our foundations are built. |
| [`@primauk/icons`](./packages/pyxis-icons)   | A collection of svg icons used in our Design System.               |

## 📚 Documentation

We offer live documentation and code examples for both the bare scss framework and its bindings:

- [SCSS documentation](https://scss-staging.prima.design/)
- [React documentation](https://react-staging.prima.design/)
- [Elm documentation](https://elm-staging.prima.design/)

## ⌨️ Development

Pyxis was built as a single repository with development simplicity in mind.

We use [Yarn workspaces](https://classic.yarnpkg.com/en/docs/workspaces/) for handling dependencies and [Lerna](https://github.com/lerna/lerna/) to manage versioning and publishing.

Run the following commands to setup your local dev environment:

```sh
# Install `yarn`, alternatives at https://yarnpkg.com/en/docs/install
brew install yarn

# Clone the `pyxis` repo
git clone git@github.com:primait/pyxis.git
cd pyxis

# Install dependencies
yarn install

# Run React live-documentation dev server
yarn storybook:serve

# Run Elm live-documentation dev server
yarn elmbook:serve
```

For more in-depth instructions, development guidelines etc., see the README files for each sub-repository.

### Icons

Pyxis also includes `@primauk/icons`, a repository which contains all of our SVG icons.

Automatic _code generation_ lets us turn these icons into React components and Elm functions, by running the following command:

```sh
yarn generate:icons
```

### Design Tokens

Pyxis foundations is a set of constants derived from the design token entities.

To generate fresh tokens, run the following command:

```sh
yarn tokens:build
```

## 💜 Contributing

Pyxis is a living design system, undergoing continuous development, and you may find that it doesn't yet satisfy your requirements, be it a missing UI component, or a missing icon, or perhaps a typography setting you'd like to see changed...

Following is a list of possible issues you'll encounter when integrating Pyxis in your application. Each issue has a related process defined by the Pyxis team in order to unblock you as soon as possible, letting you continue with your development.

#### 1) I want to use Pyxis but I'm not following a mockup

That's a really bad situation! Pyxis is a Design System which obviously strictly relies on the guidelines defined by our Design team.
Not only the mockup should _have been validated by designers_ but also needs to be created _by only using foundations, components and design tokens_ which are the basic bricks for building everything with Pyxis.

This is not a team's whim but a requirement which enforces UI/UX consistency, reduces code fragmentation and prevents unexpected behaviours when upgrading to future versions of Pyxis.

#### 2) I've got a mockup but it contains something that's missing from the current version of Pyxis

If you're sure that our documentation doesn't help you addressing this issue and you have a mockup which follows the guidelines defined in the previous case, you can _open an issue_, specifying the following information:

1. a **short title** which defines the issue
2. a **description** of what you need to do and how current Pyxis APIs prevent you from doing that
3. **at least two reviewers** from the Pyxis team which can help you in the subsequent discussion on how this issue should be solved
4. _[optional]_ **a suggestion** of how the issue's solution should be addressed. This will start the conversation. Keep in mind that this kind of solution should follow our guidelines and be something that benefits other Pyxis users. _Don't propose solutions that only satisfy your specific needs._

If you do open an issue, remember to stay engaged and to partecipate in the discussion and development surrounding that issue, don't let it die! Pyxis belongs to everyone in Prima, and that means you too! So be responsible.

Use the `#team-pyxis` Slack channel in order to follow current discussions and help us address any issues.

#### 3) I've found a bug

Unfortunately, this can happen. When you find a bug in Pyxis please open an issue with the same criteria you can find in the previous point.

Additionally, please provide us with with clear steps to let us reproduce the issue. Include screenshots if you believe they can help us address the bug.

Bug reproduction steps should also note which _browsers, resolutions or devices_ suffer from the bug.

Remember, if we can't reproduce the bug, we won't be able to fix it.

## 🧭 Etymology

The name "**Pyxis**" comes from a [small constellation](https://en.wikipedia.org/wiki/Pyxis) in the southern sky. It's the latin term for *compass* and we chose it to indicate the path to follow for the designs of Prima.

## 🚧 License

WIP
