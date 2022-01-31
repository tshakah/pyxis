module Components.IconTest exposing (suite)

import Commons.Attributes as CA
import Commons.Properties.Size as Size
import Commons.Properties.Theme as Theme
import Components.Icon as Icon
import Components.IconSet as IconSet
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes)


suite : Test
suite =
    Test.describe "The Icon component"
        [ Test.describe "Icon theme"
            [ Test.test "is light" <|
                \() ->
                    IconSet.User
                        |> Icon.create
                        |> Icon.withTheme Theme.default
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon" ] ]
            , Test.test "is dark" <|
                \() ->
                    IconSet.Alarm
                        |> Icon.create
                        |> Icon.withStyle Icon.boxed
                        |> Icon.withTheme Theme.alternative
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--alt" ] ]
            ]
        , Test.describe "Icon size"
            [ Test.test "is large" <|
                \() ->
                    IconSet.Facebook
                        |> Icon.create
                        |> Icon.withSize Size.large
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-l" ] ]
            , Test.test "is medium" <|
                \() ->
                    IconSet.Book
                        |> Icon.create
                        |> Icon.withSize Size.medium
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-m" ] ]
            , Test.test "is small" <|
                \() ->
                    IconSet.Van
                        |> Icon.create
                        |> Icon.withSize Size.small
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-s" ] ]
            ]
        , Test.describe "Icon style"
            [ Test.test "is default" <|
                \() ->
                    IconSet.Wallet
                        |> Icon.create
                        |> Icon.withStyle Icon.default
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.hasNot [ classes [ "icon--boxed" ] ]
            , Test.test "is boxed" <|
                \() ->
                    IconSet.Motorcycle
                        |> Icon.create
                        |> Icon.withStyle Icon.boxed
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--boxed" ] ]
            ]
        , Test.describe "Icon generics"
            [ Test.test "has accessible description" <|
                \() ->
                    IconSet.VehicleNaturalEvents
                        |> Icon.create
                        |> Icon.withDescription "Natural events"
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.ariaLabel "Natural events") ]
            , Test.test "has accessible role" <|
                \() ->
                    IconSet.VehicleVandalism
                        |> Icon.create
                        |> Icon.withDescription "Vehicle vandalism"
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.role "img") ]
            , Test.test "is hidden for screen readers when no description is provided" <|
                \() ->
                    IconSet.Camera
                        |> Icon.create
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.ariaHidden True) ]
            , Test.test "has a classList" <|
                \() ->
                    IconSet.Calendar
                        |> Icon.create
                        |> Icon.withClassList
                            [ ( "my-class", True )
                            , ( "my-other-class", True )
                            ]
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "my-class", "my-other-class" ] ]
            ]
        ]
