module Update exposing (..)

import Model exposing (Model)


type Msg
    = Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
