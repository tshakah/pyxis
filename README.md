# Pyxis

The Prima Assicurazioni's design system.

<img alt="Pyxis Design System" src="pyxis.png" width="100%" />

## ✨ Introduction

Pyxis is our Design System which helps Prima's to build UI-consistent applications.

In order to allow you to build your application, Pyxis offers you a ready-to-use kit with three different technologies and languages.
In addition we also maintain two packages regarding Icons and Design Tokens.

| Package name                               | Description                                                      |
| ------------------------------------------ | ---------------------------------------------------------------- |
| [`@pyxis/scss`](./packages/pyxis-scss)     | SCSS foundations and components documentation.                   |
| [`@pyxis/elm`](./packages/pyxis-elm)       | Elm components and Elmbook documentation.                        |
| [`@pyxis/react`](./packages/pyxis-react)   | React components and Storybook documentation.                    |
| [`@pyxis/tokens`](./packages/pyxis-tokens) | Design Tokens are the bricks in which our foundations are built. |
| [`@pyxis/icons`](./packages/pyxis-icons)   | A collection of icons in svg used in our Design System.          |

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

## 💜 Contributing

Pyxis is still in development (and hopefully will always be!) and often you'll find yourself stuck in creating something is currently not allowed to be done via Pyxis'APIs.

Below lies a list of possible issues you'll find when approaching Pyxis usage in your application. Each issue has a related process defined by Pyxis team in order to allow you to continue with your development.

#### 1) I want to use Pyxis but I don't have any mockup

That's a really bad situation! Pyxis is a Design System which obviously strictly relies on the guidelines defined by our Design team.
Not only the mockup should _have been validated by designers_ but also needs to be created _by only using foundations, components and design tokens_ which are the basic bricks for building everything with Pyxis.

This is not a team's whim but a requirement which allow all our applications to be consistent, reduces code fragmentation and prevent unexpected behaviours when you'll manage to upgrade to the future versions of Pyxis.

#### 2) I've a mockup which defines something I'm not able to do with current apis

If you're sure that our documentation doesn't help you addressing this issue and you own a mockup which follows guidelines defined in the previous case, you can open us an issue with the following informations:

1. a **short title** which define the issue
2. a **description** of what you should do and how current apis prevents you to do that
3. **at least two reviewers** from Pyxis team which can help you in the subsequent discussion on how this issue should be solved
4. _[optional]_ **a suggestion** of how the issue's solution should be addressed. This will be the basic of the discussion. Keep in mind that this kind of solution should follow our code guidelines and be something each other can use. _Don't think about a solution which can only satisfies your particular need._

Keep in mind that Pyxis belongs to anyone in Prima, so it is your responsibility to open the issue and collaborate with the Pyxis team in order to solve the problem. Opening an issue and then forgetting about that is not the way things should be done.

Instead, use the `#team-pyxis` channel on Slack in order to follow discussion and help us to address the issue.

#### 3) I've found a bug

This is one of the most common problems you can experience when using Pyxis. When you find a bug in Pyxis you should open us an issue with the same criteria you can find in the previous point.

If you don't feel comfortable in proposing any solution, just try to be clearer as possible in describing the bug. Any image or small video you can provide helps us in detecting and solving the bug.

Always remember to also note which _browsers, resolutions or devices_ suffer from this bug so can be easier to address the issue.

## 🚧 License

WIP
