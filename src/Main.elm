module Main exposing (..)

import Model exposing (Model, Group, Info, Endpoint)
import Update exposing (update, Msg)
import View exposing (view)
import Html exposing (Html)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


model : Model
model =
    Model "WebViz" [ mainGroup, externalGroup1 ]


mainGroup : Group
mainGroup =
    Group "MooBucks" [ endpoint1, endpoint2 ] False info


externalGroup1 : Group
externalGroup1 =
    Group "Joyn" [ endpoint1, endpoint2, endpoint2 ] False info


endpoint1 : Endpoint
endpoint1 =
    { name = "uwmama" }


endpoint2 : Endpoint
endpoint2 =
    { name = "uwmama" }


info : Info
info =
    { name = "uwmama" }


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
