module Example exposing (..)

import Model exposing (..)


model : Model
model =
    Model "WebViz" [ mainGroup, externalGroup1, externalGroup2 ]


mainGroup : Group
mainGroup =
    Group "MooBucks" [ { name = "ordering" }, { name = "pricing" }, { name = "coffees" }, { name = "beans" } ] False info


externalGroup1 : Group
externalGroup1 =
    Group "Joyn" [ { name = "payment" }, { name = "payment2" } ] False joyninfo


externalGroup2 : Group
externalGroup2 =
    Group "Amazon" [ Endpoint "endpoint1" ] False <| Info "Amazon is amazon... duuh"


info : Info
info =
    Info "moobucks coffee shop"


joyninfo : Info
joyninfo =
    Info "Electronic loyalty card system"
