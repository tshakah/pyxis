module Examples.Form.Model exposing
    ( Model
    , Msg(..)
    , initialModel
    )

import Components.Field.Date as Date
import Components.Field.Number as Number
import Components.Field.RadioGroup as RadioGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Examples.Form.Data as Data exposing (Data(..))


type Msg
    = Submit
    | TextFieldChanged Data.TextField Text.Msg
    | TextareaFieldChanged Data.TextareaField Textarea.Msg
    | DateFieldChanged Data.DateField Date.Msg
    | NumberFieldChanged Data.NumberField Number.Msg
    | GenderFieldChanged (RadioGroup.Msg Data.Gender)


type alias Model =
    { data : Data
    }


initialModel : Model
initialModel =
    { data = Data.initialData
    }
