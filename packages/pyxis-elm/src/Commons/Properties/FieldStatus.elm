module Commons.Properties.FieldStatus exposing
    ( FieldStatus
    , StatusList
    , addStatus
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
    , initStatusList
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
    | Error String
    | Disabled
    | Untouched
    | Touched
    | Pristine
    | Dirty


type StatusList
    = StatusList (List FieldStatus)


initStatusList : List FieldStatus -> StatusList
initStatusList =
    StatusList


getList : StatusList -> List FieldStatus
getList (StatusList list) =
    list


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


error : String -> FieldStatus
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


hasDefault : StatusList -> Bool
hasDefault =
    getList
        >> List.any ((==) Default)


hasHover : StatusList -> Bool
hasHover =
    getList
        >> List.any ((==) Hover)


hasFocus : StatusList -> Bool
hasFocus =
    getList
        >> List.any ((==) Focus)


hasFilled : StatusList -> Bool
hasFilled =
    getList
        >> List.any ((==) Filled)


hasValid : StatusList -> Bool
hasValid =
    getList
        >> List.any ((==) Valid)


isError : FieldStatus -> Bool
isError status =
    case status of
        Error _ ->
            True

        _ ->
            False


hasError : StatusList -> Bool
hasError =
    getList
        >> List.any isError


hasDisabled : StatusList -> Bool
hasDisabled =
    getList
        >> List.any ((==) Disabled)


hasUntouched : StatusList -> Bool
hasUntouched =
    getList
        >> List.any ((==) Untouched)


hasTouched : StatusList -> Bool
hasTouched =
    getList
        >> List.any ((==) Touched)


hasPristine : StatusList -> Bool
hasPristine =
    getList
        >> List.any ((==) Pristine)


hasDirty : StatusList -> Bool
hasDirty =
    getList
        >> List.any ((==) Dirty)


addStatus : FieldStatus -> StatusList -> StatusList
addStatus status ((StatusList list) as statusList) =
    if List.member status list then
        statusList

    else
        list
            |> removeInconsistentStatus status
            |> (::) status
            |> StatusList


removeInconsistentStatus : FieldStatus -> List FieldStatus -> List FieldStatus
removeInconsistentStatus status =
    case status of
        Default ->
            List.filter (\s -> (s == Valid || isError s || s == Filled) |> not)

        Hover ->
            identity

        Focus ->
            identity

        Filled ->
            List.filter (\s -> (s == Valid || isError s || s == Default) |> not)

        Valid ->
            List.filter (isError >> not)

        Error _ ->
            List.filter ((==) Valid >> not)

        Disabled ->
            List.filter (\s -> (s == Valid || isError s) |> not)

        Untouched ->
            List.filter (\s -> (s == Touched || s == Dirty) |> not)

        Touched ->
            List.filter ((==) Untouched >> not)

        Pristine ->
            List.filter ((==) Dirty >> not)

        Dirty ->
            List.filter (\s -> (s == Untouched || s == Pristine) |> not)
