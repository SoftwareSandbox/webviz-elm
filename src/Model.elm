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
selectGroup model selectedGroup =
    let
        updatedGroups =
            List.map (\group -> ({ group | selected = groupsMatch group selectedGroup })) model.groups
    in
        { model | groups = updatedGroups }


deselectAllGroups : Model -> Model
deselectAllGroups model =
    let
        deselectedGroups =
            List.map (\group -> { group | selected = False }) model.groups
    in
        { model | groups = deselectedGroups }


groupsMatch : Group -> Group -> Bool
groupsMatch left right =
    left.name == right.name
