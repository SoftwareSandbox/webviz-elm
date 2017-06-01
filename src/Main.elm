module Main exposing (..)

import Model exposing (Model)
import Update exposing (update, Msg)
import View exposing (view)
import Html exposing (Html)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


helloWorld : Model
helloWorld =
    { hello = "Delightful World" }


main : Program Never Model Msg
main =
    Html.program
        { init = ( helloWorld, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
