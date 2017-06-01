module Update exposing (..)

import Model exposing (Model)


type Msg
    = BallWasClicked Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BallWasClicked model ->
            ( { model | mainGroup = Model.selectGroup model.mainGroup }
            , Cmd.none
            )
