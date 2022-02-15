module Lens exposing
    ( Lens
    , andCompose
    , update
    )

{-| [Lenses](https://hackage.haskell.org/package/lens) are a design pattern for handling nested record getters/setters

The specs in `tests/LensTest.elm` should be pretty straightforward

-}


type alias Lens r field =
    { get : r -> field
    , set : field -> r -> r
    }


{-| Update a subField of the structure
e.g.

    ageLens : Lens { r | age : a } a
    ageLens = Lens .age (\newAge r -> { r | age = newAge })

    { name = "John Doe", age = 42 }
    |> Lens.update ageLens ((+) 1)
    |> Expect.equal { name = "John Doe", age = 43 }

-}
update : Lens r field -> (field -> field) -> r -> r
update { get, set } mapper r =
    set (mapper (get r)) r


{-| Compose lenses
This function is meant to be called with pipe, e.g.

    adLens =
        abLens
            |> Lens.andCompose bcLens
            |> Lens.andCompose cdLens

even when there is a single pipe step
e.g. `abLens |> Lens.andCompose bcLens` instead of `Lens.andCompose bcLens abLens`
This way it is more similar to proper lens composition ( `abLens >> bcLens >> cdLens` )

-}
andCompose : Lens b c -> Lens a b -> Lens a c
andCompose nestedLens lens =
    { get = lens.get >> nestedLens.get
    , set = nestedLens.set >> update lens
    }
