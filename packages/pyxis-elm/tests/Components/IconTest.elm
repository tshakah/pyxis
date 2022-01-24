module Components.IconTest exposing (suite)

import Commons.Attributes as CA
import Commons.Properties.Size as Size
import Commons.Properties.Theme as Theme
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes)


suite : Test
suite =
    describe "The Icon component"
        [ describe "Icon theme"
            [ test "is light" <|
                \_ ->
                    IconSet.User
                        |> Icon.create
                        |> Icon.withTheme Theme.default
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon" ] ]
            , test "is dark" <|
                \_ ->
                    IconSet.Alarm
                        |> Icon.create
                        |> Icon.withStyle Icon.boxed
                        |> Icon.withTheme Theme.alternative
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--alt" ] ]
            ]
        , describe "Icon size"
            [ test "is large" <|
                \_ ->
                    IconSet.Facebook
                        |> Icon.create
                        |> Icon.withSize Size.large
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-l" ] ]
            , test "is medium" <|
                \_ ->
                    IconSet.Book
                        |> Icon.create
                        |> Icon.withSize Size.medium
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-m" ] ]
            , test "is small" <|
                \_ ->
                    IconSet.Van
                        |> Icon.create
                        |> Icon.withSize Size.small
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-s" ] ]
            ]
        , describe "Icon style"
            [ test "is default" <|
                \_ ->
                    IconSet.Wallet
                        |> Icon.create
                        |> Icon.withStyle Icon.default
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.hasNot [ classes [ "icon--boxed" ] ]
            , test "is boxed" <|
                \_ ->
                    IconSet.Motorcycle
                        |> Icon.create
                        |> Icon.withStyle Icon.boxed
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--boxed" ] ]
            ]
        , describe "Icon generics"
            [ test "has accessible description" <|
                \_ ->
                    IconSet.VehicleNaturalEvents
                        |> Icon.create
                        |> Icon.withDescription "Natural events"
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.ariaLabel "Natural events") ]
            , test "has accessible role" <|
                \_ ->
                    IconSet.VehicleVandalism
                        |> Icon.create
                        |> Icon.withDescription "Vehicle vandalism"
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.role "img") ]
            , test "is hidden for screen readers when no description is provided" <|
                \_ ->
                    IconSet.Camera
                        |> Icon.create
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (CA.ariaHidden True) ]
            , test "has a classList" <|
                \_ ->
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
