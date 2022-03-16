## @pyxis/elm

Here you can find the documentation for the Pyxis Elm UI kit.

_Disclaimer: we're aware that Elm doesn't have components but only modules.
We will refer to components in order to keep consistency with pyxis-react._

**Table of contents**

1. [Get started](#get-started)
2. [Requiring a component](#requiring-a-component)
3. [Naming convention](#naming-convention)
4. [Using components](#using-components)
5. [Docs](#docs)

### Get started

~~You can use pyxis-elm the same way you do with any other Elm package.
In your project run `elm install primait/pyxis-elm`.~~
_(At the time of writing Pyxis is only available as Git submodule.)_

#### Requiring a component

All the Pyxis' Elm components are available under the `Components.componentName` namespace.

Here's an example of requiring a component in Pyxis:

```elm
import Components.Field.Text as Text
import Components.Form as Form
import Component.Form.Grid.Row as Row
import Components.Icon as Icon
```

We recommend to always use an `alias` for the Pyxis' stuff.

#### Naming convention

We tried to enforce consistency in our api so you can quickly guess how to use a component once after been playing with the previous one.

To reflect this we talk about:

- `Model`: this represents the _state_ of the component and **should be stored in your own application model**. Only stateful components have a `Model`.

- `Config`: this represents the configuration for the component's _view_ and behaviour. This configuration **should not be stored on your application model**. You can configure a component right before its rendering phase.

- `init`: the method which instantiate a component's `Model`

- `config`: the method which instantiate a component's `Config`. _Note that not every component has a generic config method for the sake of clarity._

#### Using components

As seen above you can use stateful or stateless components.

Example of **stateless** component usage:

```elm
import Components.Field.Label

-- Your application model
type alias Model {}

-- Your application view
view : Model -> Html msg
view model =
    Label.config "Your email address"
        |> Label.withSubText "You will receive a confirmation email"
        |> Label.render


```

Example of **stateful** component usage:

```elm
import Html exposing (Html)
import Components.Field.Text as Text
import Components.Field.Label as Label

-- Your application model which should contain the component's model.
type alias Model = {
    email : Text.Model ()
}

initialModel : Model
initialModel =
    { email = Text.init (always Ok) }

-- Your application Msg
type Msg =
    EmailFieldChanged Text.Msg

-- Your update function
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        -- Your stateful component will need to handle this message.
        EmailFieldChanged subMsg ->
            ({ model | email = Text.update subMsg model.email }, Cmd.none)

-- Your view function
view : Model -> Html Msg
view model =
    {--  Note that the Text module doesn't have a "config" method like others components.
    This because it's much more expressive to write Text.email or Text.password than passing an extra argument to the "config" function.
    --}
    Text.email "email"
        |> Text.withLabel (Label.config "Your email address")
        |> Text.withPlaceholder "it-department@prima.it"
        |> Text.render EmailFieldChanged model.email


```

#### Docs

You can find the documentation for each single component and also a preview of its appeareance and usage by following these links:

- [Elmbook documentation](https://elm-staging.prima.design)
- ~~[Elm packages documentation](https://to-be-defined)~~
