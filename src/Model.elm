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
    { title : String
    , mainGroup : Group
    }


type alias Group =
    { name : String
    , endpoints : List Endpoint
    , selected : Bool
    , info : Info
    }


type alias Endpoint =
    { name : String }


type alias Info =
    { name : String }


selectGroup : Group -> Group
selectGroup group =
    { group | selected = True }


groupToColor : Group -> Color
groupToColor group =
    if group.selected then
        Orange
    else
        Blue
