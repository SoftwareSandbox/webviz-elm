module Model exposing (..)

-- first group in list must be the main group


type alias Model =
    { title : String
    , groups : List Group
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


selectGroup : Model -> Group -> Model
selectGroup model group =
    model


deselectGroup : Model -> Model
deselectGroup model =
    model
