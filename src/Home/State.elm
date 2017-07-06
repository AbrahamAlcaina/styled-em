module Home.State exposing (init)

import Home.Types exposing (Model)
import Translation.Home.State as Translations


init : Model
init =
    Model Translations.title
