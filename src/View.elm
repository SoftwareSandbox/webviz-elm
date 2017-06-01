module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "height", "63%" ), ( "width", "63%" ) ] ]
        [ Html.h1 [] [ Html.text model.hello ]
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
                , SvgAttrs.fill "#0009FF"
                ]
                []
            ]
        ]
