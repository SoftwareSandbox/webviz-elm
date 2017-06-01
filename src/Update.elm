module Update exposing (..)

import Model exposing (Model)


type Msg
    = BallWasClicked Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BallWasClicked model ->
            ( { model | color = Model.Orange }, Cmd.none )
