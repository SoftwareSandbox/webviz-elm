module Main exposing (..)

import Html exposing (Html)
import Model exposing (Endpoint, Group, Info, Model)
import Update exposing (Msg, update)
import View exposing (view)
import Example exposing (model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


model : Model
model =
    Example.model


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
