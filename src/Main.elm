module Main exposing (..)

import Model exposing (Model, Color, Group)
import Update exposing (update, Msg)
import View exposing (view)
import Html exposing (Html)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


model : Model
model =
    Model "WebViz" mainGroup


mainGroup : Group
mainGroup =
    Group "MooBucks" [] False { name = "uwmama" }


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
