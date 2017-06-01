module Model exposing (..)


type Color
    = Blue
    | Orange


colorAsString : Color -> String
colorAsString color =
    case color of
        Blue ->
            "blue"

        Orange ->
            "orange"


type alias Model =
    { hello : String
    , color : Color
    }
