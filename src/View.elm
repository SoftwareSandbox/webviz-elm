module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Json exposing (..)
import Model exposing (Endpoint, Group, Model, Info, ContactPerson, getSelectedGroup)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Update exposing (Msg)


-- pale orange or whatever: "#f2d391"
-- light purple "#d6bee0"
-- purple "#cb9cfc"


type alias GroupPosition =
    { radius : Int
    , x : Int
    , y : Int
    }


mainGroupPosition : GroupPosition
mainGroupPosition =
    { radius = 42, x = 1500, y = 1500 }


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "height", "90%" ), ( "width", "80%" ) ] ]
        [ Html.h1 [] [ Html.text model.title ]
        , renderInfoCard <| getSelectedGroup model.groups
        , svg
            [ SvgAttrs.viewBox "0 0 4000 3000"
            , SvgAttrs.width "90%"
            , SvgAttrs.height "90%"
            , SvgAttrs.version "1.1"
            , onClick <| Update.CanvasWasClicked model
            ]
          <|
            (drawGroups model.groups)
        ]


renderInfoCard : Maybe Group -> Html Msg
renderInfoCard group =
    case group of
        Nothing ->
            Html.div [] []

        Just group ->
            if group.selected then
                renderInfo ( group.name, group.info )
            else
                Html.div [] []


renderInfo : ( String, Info ) -> Html Msg
renderInfo ( groupName, info ) =
    let
        contact =
            Maybe.withDefault (ContactPerson "") info.contact
    in
        Html.div
            [ Html.Attributes.style [ ( "float", "right" ) ] ]
            [ Html.p [] [ Html.text groupName ]
            , Html.p [] [ Html.text info.purpose ]
            , Html.p [] [ Html.text contact.email ]
            , Html.p [] [ Html.text info.nfrs ]
            ]


drawGroups : List Group -> List (Svg Msg)
drawGroups groups =
    case groups of
        [] ->
            []

        head :: tail ->
            let
                groupsSvg =
                    drawExternalGroups
                        tail
                        0

                currentGroup =
                    (drawGroup head)
            in
                List.append currentGroup groupsSvg


drawExternalGroups : List Group -> Int -> List (Svg Msg)
drawExternalGroups groups depth =
    case groups of
        [] ->
            []

        head :: tail ->
            let
                circleDegreesLocation =
                    (degrees (toFloat (220 - depth * 55)))

                xMove =
                    toString (round (toFloat mainGroupPosition.radius * 25 * cos circleDegreesLocation + 1500))

                yMove =
                    toString (round (toFloat mainGroupPosition.radius * 25 * sin circleDegreesLocation + 1500))

                circleDegreesRotation =
                    (toString (toFloat (-70 + depth * 55)))

                groupsSvg =
                    drawExternalGroups
                        tail
                        (depth + 1)

                currentGroup =
                    [ g [ SvgAttrs.transform <| "translate(" ++ xMove ++ "," ++ yMove ++ ")" ]
                        [ g
                            [ SvgAttrs.transform <| "scale(-1,1) rotate (" ++ circleDegreesRotation ++ ")" ]
                            [ g
                                [ SvgAttrs.transform <| "translate(-" ++ toString mainGroupPosition.x ++ ",-" ++ toString mainGroupPosition.y ++ ")" ]
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
            mainGroupPosition.x

        y =
            mainGroupPosition.y

        r =
            7

        endpointsSvg =
            drawEndPoints mainGroup.endpoints 0

        currentCircle =
            List.singleton
                (circle
                    [ SvgAttrs.cx <| toString 0
                    , SvgAttrs.cy <| toString 0
                    , SvgAttrs.r <| toString mainGroupPosition.radius
                    , SvgAttrs.fill <| groupColorAsString mainGroup
                    , strokeWidth ".5"
                    , stroke "grey"
                    , onClickWithoutPropagation <| Update.GroupWasClicked mainGroup
                    ]
                    []
                )

        circleList =
            [ g [ SvgAttrs.transform <| "translate(" ++ toString x ++ "," ++ toString y ++ ") scale(" ++ toString r ++ ")" ]
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
            degrees (toFloat (240 - depth * 35))
    in
        List.singleton
            (circle
                [ cx <| toString <| round <| toFloat mainGroupPosition.radius * cos circleDegrees
                , cy <| toString <| round <| toFloat mainGroupPosition.radius * sin circleDegrees
                , strokeWidth ".5"
                , stroke "black"
                , r "5"
                , fill "#d6bee0"
                , SvgAttrs.name endpoint.name
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
