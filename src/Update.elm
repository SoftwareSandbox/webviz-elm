module Update exposing (..)

import Model exposing (Model, Group)


type Msg
    = GroupWasClicked Group
    | CanvasWasClicked Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GroupWasClicked group ->
            ( Model.selectGroup model group
            , Cmd.none
            )

        CanvasWasClicked model ->
            ( Model.deselectAllGroups model, Cmd.none )
