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
    { purpose : String
    , contact : ContactPerson
    , nfrs : String
    }


type alias ContactPerson =
    { email : String }


selectGroup : Model -> Group -> Model
selectGroup model selectedGroup =
    let
        updatedGroups =
            List.map (\group -> ({ group | selected = groupsHaveSameName group selectedGroup })) model.groups
    in
        { model | groups = updatedGroups }


deselectAllGroups : Model -> Model
deselectAllGroups model =
    let
        deselectedGroups =
            List.map (\group -> { group | selected = False }) model.groups
    in
        { model | groups = deselectedGroups }


groupsHaveSameName : Group -> Group -> Bool
groupsHaveSameName left right =
    left.name == right.name


getSelectedGroup : List Group -> Maybe Group
getSelectedGroup groups =
    List.head <| List.filter (\group -> group.selected == True) groups
