module Main exposing (..)

import Html exposing (Html)
import Model exposing (Endpoint, Group, Info, Model)
import Update exposing (Msg, update)
import View exposing (view)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


model : Model
model =
    Model "WebViz" [ mainGroup, externalGroup1, externalGroup2, externalGroup3, externalGroup4 ]


mainGroup : Group
mainGroup =
    Group "MooBucks" [ { name = "ordering" }, { name = "pricing" }, { name = "coffees" }, { name = "beans" } ] False info


externalGroup1 : Group
externalGroup1 =
    Group "Joyn" [ { name = "payment" }, { name = "payment2" } ] False joyninfo


externalGroup2 : Group
externalGroup2 =
    Group "Amazon" [ Endpoint "endpoint1" ] False <| Info "info whatever"


info : Info
info =
    { name = "moobucks coffee shop" }


joyninfo : Info
joyninfo =
    { name = "Electronic loyalty card system" }


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
