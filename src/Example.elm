module Example exposing (..)

import Model exposing (..)


model : Model
model =
    Model "WebViz" [ mainGroup, externalGroup1, externalGroup2 ]


mainGroup : Group
mainGroup =
    Group
        "MooBucks"
        [ { name = "ordering" }, { name = "pricing" }, { name = "coffees" }, { name = "beans" } ]
        False
        moobucksInfo


externalGroup1 : Group
externalGroup1 =
    Group "Joyn" [ { name = "payment" }, { name = "payment2" } ] False joyninfo


externalGroup2 : Group
externalGroup2 =
    Group "Amazon" [ Endpoint "echo-orders" ] False <| amazonInfo


moobucksInfo : Info
moobucksInfo =
    Info
        "Provide a REST API for checking orders, pricing, types of coffee and types of beans"
        (ContactPerson "moorista@moobucks.com")
        """Should be able to service ~1.000 calls per second
        99.9999% uptime
        Requires ssl
        """


joyninfo : Info
joyninfo =
    Info
        "Electronic loyalty card system. Provides payment API"
        (ContactPerson "support@joyn.com")
        """
        99.9999% uptime
        Requires ssl
        Requires throttling requests
        """


amazonInfo : Info
amazonInfo =
    Info
        "Deliver stuff"
        (ContactPerson "alexa@amazon.com")
        """Requires ssl
        """
