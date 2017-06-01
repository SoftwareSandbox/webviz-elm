module Main exposing (..)

import Model exposing (Model, Color)
import Update exposing (update, Msg)
import View exposing (view)
import Html exposing (Html)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


helloWorld : Model
helloWorld =
    Model "Delightful World" Model.Blue


main : Program Never Model Msg
main =
    Html.program
        { init = ( helloWorld, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
