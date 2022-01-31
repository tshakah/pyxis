module Fuzz.Extra exposing (className)

import Fuzz


className : Fuzz.Fuzzer String
className =
    Fuzz.map (\str -> "_" ++ String.filter (\ch -> ch /= ' ') str)
        Fuzz.string
