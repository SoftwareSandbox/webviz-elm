module Update exposing (..)

import Model exposing (Model, Group)


type Msg
    = BallWasClicked Group
    | CanvasWasClicked Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BallWasClicked group ->
            ( { model | mainGroup = Model.selectGroup group }
            , Cmd.none
            )

        CanvasWasClicked model ->
            ( { model | mainGroup = Model.deselectGroup model.mainGroup }, Cmd.none )
