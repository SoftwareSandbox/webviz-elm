module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Json exposing (..)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Model exposing (Model, Group, Endpoint)
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
            , onClick <| Update.CanvasWasClicked model
            ]
          <|
            (drawGroup model.mainGroup)
        ]


drawGroup : Group -> List (Svg Msg)
drawGroup mainGroup =
    let
        x =
            60

        y =
            60

        r =
            25

        endpointsSvg =
            (drawEndPoints mainGroup.endpoints 0 x y r)

        currentCircle =
            List.singleton
                (circle
                    [ SvgAttrs.cx <| toString x
                    , SvgAttrs.cy <| toString y
                    , SvgAttrs.r <| toString r
                    , SvgAttrs.fill <| groupColorAsString mainGroup
                    , onClickWithoutPropagation <| Update.BallWasClicked mainGroup
                    ]
                    []
                )

        circleList =
            List.append currentCircle endpointsSvg
    in
        circleList


drawEndPoints : List Endpoint -> Int -> Int -> Int -> Int -> List (Svg Msg)
drawEndPoints endpoints dept cx cy r =
    let
        firstElement =
            List.head

        restOfTheElements =
            List.tail endpoints

        endpointsSvg =
            case restOfTheElements of
                Nothing ->
                    []

                Just restOfTheElements ->
                    (drawEndPoints restOfTheElements (dept + 1) cx cy r)

        currentCircle =
            List.singleton
                (circle
                    [ SvgAttrs.cx <| toString (cx + round (toFloat r * cos (degrees (toFloat (240 + dept * 10)))))
                    , SvgAttrs.cy <| toString (cx + round (toFloat r * sin (degrees (toFloat (240 + dept * 10)))))
                    , SvgAttrs.r "5"
                    , SvgAttrs.fill "red"
                    ]
                    []
                )

        circleList =
            List.append currentCircle endpointsSvg
    in
        circleList


onClickWithoutPropagation : msg -> Attribute msg
onClickWithoutPropagation message =
    onWithOptions
        "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed message)


type Color
    = MainGroupUnselected
    | MainGroupSelected


groupColorAsString : Group -> String
groupColorAsString group =
    colorAsString <|
        groupToColor group


colorAsString : Color -> String
colorAsString color =
    case color of
        MainGroupUnselected ->
            "blue"

        MainGroupSelected ->
            "orange"


groupToColor : Group -> Color
groupToColor group =
    if group.selected then
        MainGroupSelected
    else
        MainGroupUnselected
