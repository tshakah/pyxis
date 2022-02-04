module Examples.Validation exposing (main)

import Browser
import Commons.Properties.Placement as Placement
import Components.Button as Btn
import Components.Input as Input
import Date exposing (Date)
import Email exposing (Email)
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import PipeValidation
import Validation exposing (Validation)
import Validation.Int
import Validation.String



{- Validation is simply defined as

   type alias Validation from to =
       from -> Result String to


   It's called `Validation` but is more of a "Parsing" design pattern

   https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/


   The following validators are just a design pattern, not a feature.
   The user can simply write a plain function returning a `Result`
-}


{--}
requiredFieldValidation : Validation String String
requiredFieldValidation =
    Validation.String.notEmpty "Required field"


{-|

    * if the string is empty, it shows the message `Required field`
    * else, it trims it
    * if the string is empty, it shows the message `Insert a valid name`

-}
nameFieldValidation : Validation String String
nameFieldValidation =
    requiredFieldValidation
        >> Result.andThen Validation.String.trim
        >> Result.andThen (Validation.String.notEmpty "Insert a valid name")


{-|

    * if the string is empty, it shows the message `Required field`
    * else, it converts it to an integer
    * if it fails the conversion, it shows the message `Expected an integer`
    * else, if it is < 18, it shows the message `Age must be >= 18`
    * else, if it is > 100, it shows the message `Age must be <= 100`

-}
ageFieldValidation : Validation String Int
ageFieldValidation =
    requiredFieldValidation
        >> Result.andThen (Validation.String.toInt "Expected an integer")
        >> Result.andThen (Validation.Int.min 18 "Age must be >= 18")
        >> Result.andThen (Validation.Int.max 100 "Age must be <= 100")


allCharsAlpha : String -> Validation String String
allCharsAlpha =
    Validation.fromPredicate (String.all Char.isAlpha)


jobFieldValidation : Validation String String
jobFieldValidation =
    allCharsAlpha "Job cannot contain non-number chars"


idValidation : Validation String String
idValidation =
    requiredFieldValidation


emailFieldValidation : Validation String Email
emailFieldValidation =
    requiredFieldValidation
        >> Result.andThen (Email.fromString "Insert a valid email")


passwordValidation : String -> Result String String
passwordValidation =
    Validation.String.minLength 6 "Password needs at least 6 characters"


type alias Model =
    { name : Input.Model String
    , age : Input.Model Int
    , date : Input.Model Date
    , job : Input.Model (Maybe String)
    , id : Input.Model (Maybe String)
    , email : Input.Model Email
    , password : Input.Model String
    , confirmPassword : Input.Model String
    , submittedData : List (Result String FormData)
    }


init : Model
init =
    { name = Input.empty nameFieldValidation
    , age = Input.empty ageFieldValidation

    {- In an actual app it would be useful to `Result.mapError` for a better message -}
    , date = Input.empty Date.fromIsoString

    {- Validation.String.option is a higher order Validation that, given a validator:
       * if the given string is empty, resolves to `Ok Nothing`
       * else, runs the given validator

       This way job is optional and marked as `Maybe String`
    -}
    , job = Input.empty (Validation.String.optional jobFieldValidation)

    {- Initializes the field with an initial string `initial-value`
       The `Input.detectChanges` modifier detects if the current value is equal to the initial value
       * If it is, the validation resolves to Nothing
       * Else, the validation resolves to Just [result of validation]
    -}
    , id =
        Input.init "initial-value" idValidation
            |> Input.detectChanges
    , email = Input.empty emailFieldValidation
    , password = Input.empty passwordValidation
    , confirmPassword = Input.empty passwordValidation
    , submittedData = []
    }


type Msg
    = AgeInput Input.Msg
    | NameInput Input.Msg
    | DateInput Input.Msg
    | JobInput Input.Msg
    | IdInput Input.Msg
    | EmailInput Input.Msg
    | PasswordInput Input.Msg
    | ConfirmPasswordInput Input.Msg
    | Submit


{-| The final data structure we want to parse when submitting the form
-}
type alias FormData =
    { name : String
    , age : Int
    , date : Date
    , job : Maybe String
    , id : Maybe String
    , email : Email
    , password : String
    }


{-| The Input.Model interface is:

-- Not very useful
Input.getValue : Input.Model x -> String

-- This is what we're interested in
Input.validate : Input.Model value -> Result String value

Using `Result.mapN` instead of just asking for the string, we have the type-safe guarantee
that we're not submitting invalid data

    parseForm : Validation Model FormData
    parseForm model =
        Result.map6 FormData
            (Input.validate model.name)
            (Input.validate model.age)
            (Input.validate model.date)
            (Input.validate model.job)
            (Input.validate model.id)
            (Input.validate model.confirmPassword)

Or we could use the general version of `Result.mapN`
(it is implemented in the Result.Extra module, but is a one liner so we don't really need the external dep)

    parseForm : Validation Model FormData
    parseForm model =
        Ok FormData
            |> Result.andMap (Input.validate model.name)
            |> Result.andMap (Input.validate model.age)
            |> Result.andMap (Input.validate model.date)
            |> Result.andMap (Input.validate model.job)
            |> Result.andMap (Input.validate model.id)
            |> Result.andMap (Input.validate model.confirmPassword)

The following is a shortcut to the above.
It's just a design pattern, not a feature, and the user can just use the approaches above

The pipe can be mixed with other types of values, not only `PipeValidation..input`

-}
parseForm : Validation Model FormData
parseForm =
    PipeValidation.succeed FormData
        |> PipeValidation.input .name
        |> PipeValidation.input .age
        |> PipeValidation.input .date
        |> PipeValidation.input .job
        |> PipeValidation.input .id
        |> PipeValidation.input .email
        |> PipeValidation.input .confirmPassword


{-| Higher order `update` function that applies an [input mask](https://css-tricks.com/input-masking/)
to the given update function
-}
idUpdate : Input.Msg -> Input.Model data -> Input.Model data
idUpdate =
    Input.enhanceUpdateWithMask idFieldMask Input.update


{-| For example, with this function, every space becomes a "-"
Some use cases are phone/id/credit card number formatting (333 - 123 123), or
normalizing the "." in a "," (or vice-versa), or trimming the input (is different from doing it in the validation)

Returning Nothing prevents the update of the value
For example one could prevent the user to insert some characters

-}
idFieldMask : String -> Maybe String
idFieldMask =
    String.replace " " "-" >> Just


baseUpdate : Msg -> Model -> Model
baseUpdate msg model =
    case msg of
        NameInput subMsg ->
            { model | name = Input.update subMsg model.name }

        AgeInput subMsg ->
            { model | age = Input.update subMsg model.age }

        DateInput subMsg ->
            { model | date = Input.update subMsg model.date }

        JobInput subMsg ->
            { model | job = Input.update subMsg model.job }

        IdInput subMsg ->
            { model | id = idUpdate subMsg model.id }

        EmailInput subMsg ->
            { model | email = Input.update subMsg model.email }

        PasswordInput subMsg ->
            { model | password = Input.update subMsg model.password }

        ConfirmPasswordInput subMsg ->
            { model | confirmPassword = Input.update subMsg model.confirmPassword }

        Submit ->
            model
                |> baseUpdate (AgeInput Input.submit)
                |> baseUpdate (NameInput Input.submit)
                |> baseUpdate (DateInput Input.submit)
                |> baseUpdate (JobInput Input.submit)
                |> baseUpdate (IdInput Input.submit)
                |> baseUpdate (EmailInput Input.submit)
                |> baseUpdate (PasswordInput Input.submit)
                |> baseUpdate (ConfirmPasswordInput Input.submit)
                |> submitData


{-| This allows to perform more general validation using parsed data

        -- This validation is applied to the `guideType` field
        guideTypeMultiValidation : GuideType -> Model -> Result String ()
        guideTypeMultiValidation self model =
            PipeValidation.succeed
                (\birthDate licenceDate ->
                    case (licenceDate, driverCategory) of
                        (Nothing, Just _) ->
                            Err "Without a licence date, the driver category is invalid"

                        (Just dateValue, Just GuideType.Expert) ->
                            if Date.year model.today - Date.year d1 < 25 then
                                Err "You cannot select 'Expert' guide category"

                            else
                                Ok ()
                       _ ->
                            Ok ()
                )
           |> PipeValidation.input .birthDate    -- model.birthDate : Input.Model Date, a required field
           |> PipeValidation.input .licenceDate  -- model.licenceDate : Input.Model (Maybe Date), an optional date

       -- ...

       baseUpdate
            |> afterUpdate
                (\model ->
                    { model | guideType = Input.forceValidation guideTypeMultiValidation model .guideType }
                )

Still a design pattern, not a feature

-}
confirmPasswordMultiValidation : String -> Validation Model (Result String ())
confirmPasswordMultiValidation self =
    PipeValidation.succeed
        (\password ->
            if password == self then
                Ok ()

            else
                Err "Passwords do not match"
        )
        |> PipeValidation.input .password


afterUpdate : (Model -> Model) -> (Msg -> Model -> Model) -> Msg -> Model -> Model
afterUpdate mapper update_ msg model =
    mapper (update_ msg model)


update : Msg -> Model -> Model
update =
    baseUpdate
        |> afterUpdate
            (\model ->
                { model | confirmPassword = Input.forceValidation confirmPasswordMultiValidation model .confirmPassword }
            )



-- View


viewForm : Model -> Html Msg
viewForm model =
    Html.form [ class "space-y", Html.Events.onSubmit Submit ]
        [ Input.text
            |> Input.withPlaceholder "John Doe"
            -- This does not compile:
            -- |> Input.numberMin 18
            |> Input.render model.name NameInput
        , Input.number
            |> Input.withPlaceholder "Age"
            |> Input.numberMin 18
            |> Input.numberMax 100
            -- This does not compile
            -- |> Input.dateMax (Date.fromRataDie 1000)
            |> Input.withAddon Placement.append (Input.textAddon "Addon")
            |> Input.render model.age AgeInput
        , Input.text
            |> Input.withPlaceholder "Job"
            |> Input.render model.job JobInput
        , Input.date
            |> Input.withPlaceholder "Birth date"
            -- This does not compile:
            -- |> Input.withAddon Placement.append (Input.textAddon "Addon")
            |> Input.dateMax (Date.fromRataDie 100000)
            |> Input.render model.date DateInput
        , Input.text
            |> Input.withPlaceholder "Id"
            |> Input.render model.id IdInput
        , Input.text
            |> Input.withPlaceholder "Email"
            |> Input.render model.email EmailInput
        , Input.password
            |> Input.withPlaceholder "Password"
            |> Input.render model.password PasswordInput
        , Input.password
            |> Input.withPlaceholder "Confirm password"
            |> Input.render model.confirmPassword ConfirmPasswordInput
        , Btn.primary
            |> Btn.withText "Submit"
            |> Btn.withType Btn.submit
            |> Btn.render
        ]



-- Boilerplate


submitData : Model -> Model
submitData model =
    { model | submittedData = parseForm model :: model.submittedData }


view : Model -> Html Msg
view model =
    Html.div []
        [ viewForm model

        {-
           , Html.div [ class "h-4" ] []
                   , Html.hr [] []
                   , Html.div [ class "h-4" ] []
                   , Html.text "Submitted data: "
              , Html.ul [ class "overflow-x-auto list-disc" ]
                         (model.submittedData
                             |> List.map
                                 (\data ->
                                     Html.li []
                                         [ Html.pre [ class "inline" ] [ Html.text (Enc.encode 2 (encodeFormDataResult data)) ]
                                         ]
                                 )
                         )
        -}
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
