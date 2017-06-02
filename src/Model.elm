module Model exposing (..)


type alias Model =
    { title : String
    , mainGroup : Group
    , externalPartyGroups : List Group
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


deselectGroup : Group -> Group
deselectGroup group =
    { group | selected = False }
