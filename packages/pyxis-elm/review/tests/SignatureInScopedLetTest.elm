module SignatureInScopedLetTest exposing (..)

import Custom.SignatureInScopedLet as SignatureInScopedLet
import Review.Test
import Test exposing (..)


suite : Test
suite =
    describe "NoPipeRecordGetterRule test"
        [ test "should not report anything when local let variabile has signature" <|
            \() ->
                """module M exposing (..)
x =
    let
        y : Int
        y = value
    in
        f y

"""
                    |> Review.Test.run SignatureInScopedLet.rule
                    |> Review.Test.expectNoErrors
        , test "should not report anything when local let is a destructuring expression" <|
            \() ->
                """module M exposing (..)
x =
    let
        { url, fragment } = url
    in
        f y

                     """
                    |> Review.Test.run SignatureInScopedLet.rule
                    |> Review.Test.expectNoErrors
        , test "should not report anything when local let function has signature" <|
            \() ->
                """module M exposing (..)
x =
    let
        id : a -> a
        id v = v
    in
        id 42
"""
                    |> Review.Test.run SignatureInScopedLet.rule
                    |> Review.Test.expectNoErrors
        , test "should report when local let value doesn't have a signature" <|
            \() ->
                """module M exposing (..)
x =
    let
        y = value
    in
        f y
        """
                    |> Review.Test.run SignatureInScopedLet.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = SignatureInScopedLet.message
                            , details = SignatureInScopedLet.details
                            , under = """y = value"""
                            }
                        ]
        , test "should report when local let function doesn't have a signature" <|
            \() ->
                """module M exposing (..)
x =
    let
        id v = v
    in
        id 42
"""
                    |> Review.Test.run SignatureInScopedLet.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = SignatureInScopedLet.message
                            , details = SignatureInScopedLet.details
                            , under = """id v = v"""
                            }
                        ]
        ]
