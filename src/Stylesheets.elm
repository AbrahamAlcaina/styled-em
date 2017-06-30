port module Stylesheets exposing (main)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Styles.Shared
import Styles.Main


port files : CssFileStructure -> Cmd msg


styles =
    [ Styles.Shared.css
    , Styles.Main.css
    ]


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "main.css", Css.File.compile styles ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
