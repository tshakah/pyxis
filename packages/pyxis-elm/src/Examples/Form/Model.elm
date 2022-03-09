module Examples.Form.Model exposing
    ( Model
    , Msg(..)
    , initialModel
    )

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Date as Date
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Examples.Form.Data as Data exposing (Data(..))


type Msg
    = Submit
    | TextFieldChanged Data.TextField Text.Msg
    | TextareaFieldChanged Data.TextareaField Textarea.Msg
    | DateFieldChanged Data.DateField Date.Msg
    | InsuranceTypeChanged (RadioCardGroup.Msg Data.InsuranceType)
    | PrivacyChanged (CheckboxGroup.Msg ())
    | ClaimTypeChanged (RadioCardGroup.Msg Data.ClaimType)
    | PeopleInvolvedChanged (RadioCardGroup.Msg Data.PeopleInvolved)


type alias Model =
    { data : Data
    }


initialModel : Model
initialModel =
    { data = Data.initialData
    }
