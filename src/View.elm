module View exposing (..)

import Html exposing (Html)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    Html.h1 [] [ Html.text model.hello ]
