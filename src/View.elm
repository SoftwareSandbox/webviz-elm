module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Json exposing (..)
import Model exposing (Endpoint, Group, Model, Info, ContactPerson, getSelectedGroup)
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Update exposing (Msg)


type alias GroupPosition =
    { radius : Float
    , x : Int
    , y : Int
    }


mainGroupStartingPosition : GroupPosition
mainGroupStartingPosition =
    { radius = 42, x = 1500, y = 1500 }


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "height", "90%" ), ( "width", "80%" ) ] ]
        [ Html.h1 [] [ Html.text model.title ]
        , renderInfoCard <| getSelectedGroup model.groups
        , svg (canvasAttributes model) <| drawGroups model.groups
        ]


canvasAttributes : Model -> List (Html.Attribute Msg)
canvasAttributes model =
    [ SvgAttrs.viewBox "0 0 4000 3000"
    , SvgAttrs.width "90%"
    , SvgAttrs.height "90%"
    , SvgAttrs.version "1.1"
    , onClick <| Update.CanvasWasClicked model
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
                    drawExternalGroups tail 0

                currentGroup =
                    drawGroup head
            in
                currentGroup ++ groupsSvg


type alias Depth =
    Int


drawExternalGroups : List Group -> Depth -> List (Svg Msg)
drawExternalGroups groups depth =
    case groups of
        [] ->
            []

        head :: tail ->
            let
                circleDegreesLocation =
                    degrees <| toFloat <| 220 - depth * 55

                xMove =
                    toString <| round <| mainGroupStartingPosition.radius * 25 * cos circleDegreesLocation + 1500

                yMove =
                    toString <| round <| mainGroupStartingPosition.radius * 25 * sin circleDegreesLocation + 1500

                circleDegreesRotation =
                    toString <| toFloat <| -70 + depth * 55

                groupsSvg =
                    drawExternalGroups
                        tail
                        (depth + 1)

                currentGroup =
                    [ g [ SvgAttrs.transform <| "translate(" ++ xMove ++ "," ++ yMove ++ ")" ]
                        [ g
                            [ SvgAttrs.transform <| "scale(-1,1) rotate (" ++ circleDegreesRotation ++ ")" ]
                            [ g
                                [ SvgAttrs.transform <| "translate(-" ++ toString mainGroupStartingPosition.x ++ ",-" ++ toString mainGroupStartingPosition.y ++ ")" ]
                              <|
                                drawGroup head
                            ]
                        ]
                    ]
            in
                currentGroup ++ groupsSvg



-- TODO: drawGroup relative to the "mainGroup", not just the mainGroupStartingPosition
-- this implies that Groups, or at least MainGroup should know its coordinates/position
-- Or maybe make an in between ViewModel, that just contains all of the calculated drawing information
-- So you'd first map from Group to GroupView
-- And then map GroupView to Svg


drawGroup : Group -> List (Svg Msg)
drawGroup group =
    let
        x =
            mainGroupStartingPosition.x

        y =
            mainGroupStartingPosition.y

        r =
            7

        endpointsSvg =
            drawEndPoints group.endpoints 0

        currentCircle =
            [ circle
                [ SvgAttrs.cx <| toString 0
                , SvgAttrs.cy <| toString 0
                , SvgAttrs.r <| toString mainGroupStartingPosition.radius
                , SvgAttrs.fill <| groupColorAsString group
                , strokeWidth ".5"
                , stroke "grey"
                , onClickWithoutPropagation <| Update.GroupWasClicked group
                ]
                []
            ]
    in
        [ g
            [ SvgAttrs.transform <| "translate(" ++ toString x ++ "," ++ toString y ++ ") scale(" ++ toString r ++ ")" ]
          <|
            currentCircle
                ++ endpointsSvg
        ]


drawEndPoints : List Endpoint -> Depth -> List (Svg Msg)
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
                currentCircle ++ endpointsSvg


drawEndPoint : Endpoint -> Depth -> List (Svg Msg)
drawEndPoint endpoint depth =
    let
        circleDegrees =
            degrees <| toFloat (240 - depth * 35)

        xPositionOnCircle =
            round <| mainGroupStartingPosition.radius * cos circleDegrees

        yPositionOnCircle =
            round <| mainGroupStartingPosition.radius * sin circleDegrees
    in
        [ circle
            [ cx <| toString <| xPositionOnCircle
            , cy <| toString <| yPositionOnCircle
            , strokeWidth ".5"
            , stroke "black"
            , r "5"
            , fill <| colorAsString MainGroupUnselected
            , SvgAttrs.name endpoint.name
            ]
            []
        ]


onClickWithoutPropagation : msg -> Attribute msg
onClickWithoutPropagation message =
    onWithOptions
        "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed message)



-- Stuff about colors


type Color
    = MainGroupUnselected
    | MainGroupSelected
    | ExternalGroupUnselected
    | ExternalGroupSelected


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

        -- light orange or whatever
        ExternalGroupUnselected ->
            "#f2d391"

        -- peach or whatever
        ExternalGroupSelected ->
            "#fec391"


groupToColor : Group -> Color
groupToColor { selected, groupType } =
    case ( selected, groupType ) of
        ( True, Model.MainGroup ) ->
            MainGroupSelected

        ( False, Model.MainGroup ) ->
            MainGroupUnselected

        ( True, Model.ExternalGroup ) ->
            ExternalGroupSelected

        ( False, Model.ExternalGroup ) ->
            ExternalGroupUnselected
