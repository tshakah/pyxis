module Pyxis.Commons.List exposing (find, findNext, findPrevious, last, paired, withPreviousAndNext)

{-| Utilities around `List` type
-}


{-| Finds the first element matching the predicate
-}
find : (a -> Bool) -> List a -> Maybe a
find pred lst =
    case lst of
        [] ->
            Nothing

        hd :: tl ->
            if pred hd then
                Just hd

            else
                find pred tl


{-| Internal
-}
findNextHelper : (a -> Bool) -> List a -> Maybe a
findNextHelper pred lst =
    case lst of
        x :: y :: tl ->
            if pred x then
                Just y

            else
                findNextHelper pred (y :: tl)

        _ ->
            Nothing


{-| Returns (if present) the element after the element matching the predicate
Check tests / ListExtraTest.elm the complete specs
-}
findNext : (a -> Bool) -> List a -> Maybe a
findNext pred lst =
    case findNextHelper pred lst of
        Just x ->
            Just x

        Nothing ->
            List.head lst


{-| Like `findNext`, but in the opposite direction
-}
findPrevious : (a -> Bool) -> List a -> Maybe a
findPrevious pred =
    List.reverse >> findNext pred


paired : List a -> List ( a, a )
paired lst =
    case lst of
        [] ->
            []

        hd :: tl ->
            List.map2 Tuple.pair lst (tl ++ [ hd ])


withPreviousAndNext : List a -> List ( a, a, a )
withPreviousAndNext lst =
    -- This should be optimized a bit in futures updates
    case ( lst, List.reverse lst ) of
        ( [ x ], _ ) ->
            [ ( x, x, x ) ]

        ( hd :: tl, revHd :: revTl ) ->
            List.map3 (\a b c -> ( a, b, c ))
                (revHd :: List.reverse revTl)
                lst
                (tl ++ [ hd ])

        _ ->
            []


last : List a -> Maybe a
last =
    List.foldl (\x _ -> Just x) Nothing
