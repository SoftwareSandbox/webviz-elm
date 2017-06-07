module Example exposing (..)

import Model exposing (..)


model : Model
model =
    Model "WebViz" [ moobucksGroup, joynExternalGroup, amazonExternalGroup ]


moobucksGroup : Group
moobucksGroup =
    Group
        MainGroup
        "MooBucks"
        [ { name = "ordering" }, { name = "pricing" }, { name = "coffees" }, { name = "beans" } ]
        False
        moobucksInfo


joynExternalGroup : Group
joynExternalGroup =
    Group ExternalGroup "Joyn" [ { name = "payment" }, { name = "payment2" } ] False joyninfo


amazonExternalGroup : Group
amazonExternalGroup =
    Group ExternalGroup "Amazon" [ Endpoint "echo-orders" ] False <| amazonInfo


moobucksInfo : Info
moobucksInfo =
    Info
        "Provide a REST API for checking orders, pricing, types of coffee and types of beans"
        (Just <| ContactPerson "moorista@moobucks.com")
        """Should be able to service ~1.000 calls per second
        99.9999% uptime
        Requires ssl
        """


joyninfo : Info
joyninfo =
    Info
        "Electronic loyalty card system. Provides payment API"
        (Just <| ContactPerson "support@joyn.com")
        """
        99.9999% uptime
        Requires ssl
        Requires throttling requests
        """


amazonInfo : Info
amazonInfo =
    Info
        "Deliver stuff"
        (Just <| ContactPerson "alexa@amazon.com")
        """Requires ssl
        """
