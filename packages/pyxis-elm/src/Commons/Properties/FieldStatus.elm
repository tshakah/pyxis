module Commons.Properties.FieldStatus exposing
    ( FieldStatus
    , default
    , dirty
    , disabled
    , error
    , filled
    , focus
    , hasDefault
    , hasDirty
    , hasDisabled
    , hasError
    , hasFilled
    , hasFocus
    , hasHover
    , hasPristine
    , hasTouched
    , hasUntouched
    , hasValid
    , hover
    , pristine
    , touched
    , untouched
    , valid
    )


type FieldStatus
    = Default
    | Hover
    | Focus
    | Filled
    | Valid
    | Error
    | Disabled
    | Untouched
    | Touched
    | Pristine
    | Dirty


default : FieldStatus
default =
    Default


hover : FieldStatus
hover =
    Hover


focus : FieldStatus
focus =
    Focus


filled : FieldStatus
filled =
    Filled


valid : FieldStatus
valid =
    Valid


error : FieldStatus
error =
    Error


disabled : FieldStatus
disabled =
    Disabled


untouched : FieldStatus
untouched =
    Untouched


touched : FieldStatus
touched =
    Touched


pristine : FieldStatus
pristine =
    Pristine


dirty : FieldStatus
dirty =
    Dirty


hasDefault : List FieldStatus -> Bool
hasDefault =
    List.any ((==) Default)


hasHover : List FieldStatus -> Bool
hasHover =
    List.any ((==) Hover)


hasFocus : List FieldStatus -> Bool
hasFocus =
    List.any ((==) Focus)


hasFilled : List FieldStatus -> Bool
hasFilled =
    List.any ((==) Filled)


hasValid : List FieldStatus -> Bool
hasValid =
    List.any ((==) Valid)


hasError : List FieldStatus -> Bool
hasError =
    List.any ((==) Error)


hasDisabled : List FieldStatus -> Bool
hasDisabled =
    List.any ((==) Disabled)


hasUntouched : List FieldStatus -> Bool
hasUntouched =
    List.any ((==) Untouched)


hasTouched : List FieldStatus -> Bool
hasTouched =
    List.any ((==) Touched)


hasPristine : List FieldStatus -> Bool
hasPristine =
    List.any ((==) Pristine)


hasDirty : List FieldStatus -> Bool
hasDirty =
    List.any ((==) Dirty)
