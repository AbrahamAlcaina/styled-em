module NotFound.State exposing (init)

import NotFound.Types exposing (Model)
import Translation.NotFound.State as Translations


init : Model
init =
    Model Translations.title
