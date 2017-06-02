module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Json exposing (..)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Model exposing (Model, Group, Endpoint)
import Update exposing (Msg)


-- pale orange or whatever: "#f2d391"
-- light purple "#d6bee0"
-- purple "#cb9cfc"

mainGroupRadius : Int
mainGroupRadius =
    42


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "height", "70%" ), ( "width", "70%" ) ] ]
        [ Html.h1 [] [ Html.text model.title ]
        , svg
            [ SvgAttrs.viewBox "0 0 1500 1500"
            , SvgAttrs.width "90%"
            , SvgAttrs.height "90%"
            , SvgAttrs.version "1.1"
            , onClick <| Update.CanvasWasClicked model
            ]
          <|
            (List.append
                (drawGroup model.mainGroup)
                (drawGroups model.externalPartyGroups 0)
            )
        ]


drawGroups : List Group -> Int -> List (Svg Msg)
drawGroups groups depth =
    case groups of
        [] ->
            []

        head :: tail ->
            let
                circleDegrees =
                    (degrees (toFloat (220 - depth * 35)))

                xMove =
                    toString (round (toFloat mainGroupRadius * 25 * cos circleDegrees + 1100))

                yMove =
                    toString (round (toFloat mainGroupRadius * 25 * sin circleDegrees + 1100))

                groupsSvg =
                    drawGroups tail (depth + 1)

                currentGroup =
                    [ g [ SvgAttrs.transform <| "translate(" ++ xMove ++ "," ++ yMove ++ ")" ]
                        [ g
                            [ SvgAttrs.transform <| "rotate (180)" ]
                            [ g
                                [ SvgAttrs.transform <| "translate(-1100,-1100)" ]
                                (drawGroup head)
                            ]
                        ]
                    ]
            in
                List.append currentGroup groupsSvg


drawGroup : Group -> List (Svg Msg)
drawGroup mainGroup =
    let
        x =
            1100

        y =
            1100

        r =
            9

        endpointsSvg =
            (drawEndPoints mainGroup.endpoints 0)

        currentCircle =
            List.singleton
                (circle
                    [ SvgAttrs.cx <| toString 0
                    , SvgAttrs.cy <| toString 0
                    , SvgAttrs.r <| toString mainGroupRadius
                    , SvgAttrs.fill <| groupColorAsString mainGroup
                    , onClickWithoutPropagation <| Update.BallWasClicked mainGroup
                    ]
                    []
                )

        circleList =
            [ g [ SvgAttrs.transform <| "translate(" ++ (toString x) ++ "," ++ (toString y) ++ ") scale(" ++ (toString r) ++ ")" ]
                (List.append
                    currentCircle
                    endpointsSvg
                )
            ]
    in
        circleList


drawEndPoints : List Endpoint -> Int -> List (Svg Msg)
drawEndPoints endpoints depth =
    case endpoints of
        [] ->
            []

        head :: tail ->
            let
                endpointsSvg =
                    drawEndPoints tail (depth + 1)

                currentCircle =
                    drawEndPoint head depth
            in
                List.append currentCircle endpointsSvg


drawEndPoint : Endpoint -> Int -> List (Svg Msg)
drawEndPoint endpoint depth =
    let
        circleDegrees =
            (degrees (toFloat (240 - depth * 35)))
    in
        List.singleton
            (circle
                [ SvgAttrs.cx <| toString (round (toFloat mainGroupRadius * cos circleDegrees))
                , SvgAttrs.cy <| toString (round (toFloat mainGroupRadius * sin circleDegrees))
                , SvgAttrs.r "5"
                , SvgAttrs.fill "#d6bee0"
                ]
                []
            )


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
        -- light purple
        MainGroupUnselected ->
            "#d6bee0"

        -- purple
        MainGroupSelected ->
            "#cb9cfc"


groupToColor : Group -> Color
groupToColor group =
    if group.selected then
        MainGroupSelected
    else
        MainGroupUnselected
