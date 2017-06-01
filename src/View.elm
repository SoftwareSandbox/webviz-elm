module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Model exposing (Model, colorAsString, groupToColor)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "height", "63%" ), ( "width", "63%" ) ] ]
        [ Html.h1 [] [ Html.text model.title ]
        , svg
            [ SvgAttrs.viewBox "0 0 100 100"
            , SvgAttrs.width "90%"
            , SvgAttrs.height "90%"
            , SvgAttrs.version "1.1"
            ]
            [ circle
                [ SvgAttrs.cx "60"
                , SvgAttrs.cy "60"
                , SvgAttrs.r "25"
                , SvgAttrs.fill <| colorAsString <| groupToColor model.mainGroup
                , onClick <| Update.BallWasClicked model
                ]
                []
            ]
        ]
