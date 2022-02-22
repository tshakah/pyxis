module Fuzz.Extra exposing
    ( className
    , date
    )

import Date exposing (Date)
import Fuzz


className : Fuzz.Fuzzer String
className =
    Fuzz.map (\str -> "_" ++ String.filter (\ch -> ch /= ' ') str)
        Fuzz.string


month : Fuzz.Fuzzer Date.Month
month =
    Fuzz.map Date.numberToMonth (Fuzz.intRange 1 12)


dayUpTo28 : Fuzz.Fuzzer Int
dayUpTo28 =
    Fuzz.intRange 1 28


year : Fuzz.Fuzzer Int
year =
    Fuzz.intRange 1920 2020


date : Fuzz.Fuzzer Date
date =
    Fuzz.map3 Date.fromCalendarDate year month dayUpTo28
