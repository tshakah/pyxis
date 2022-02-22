module Examples.Form.Main exposing (main)

import Browser
import Examples.Form.Model as Model exposing (Model)
import Examples.Form.Update as Update
import Examples.Form.View as View


main : Program () Model Model.Msg
main =
    Browser.sandbox
        { init = Model.initialModel
        , view = View.view
        , update = Update.update
        }
