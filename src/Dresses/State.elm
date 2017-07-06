module Dresses.State exposing (init)

import Dresses.Types exposing (Model)
import Translation.Dresses.State as Translations


init : Model
init =
    Model Translations.title
