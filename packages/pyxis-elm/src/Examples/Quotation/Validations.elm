module Examples.Quotation.Validations exposing (requiredFieldValidation)

import Validation exposing (Validation)
import Validation.String


requiredFieldValidation : Validation String String
requiredFieldValidation =
    Validation.String.notEmpty "Campo obbligatorio"
