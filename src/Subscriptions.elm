module Subscriptions exposing (subscriptions)

import Message exposing (Msg)
import Model exposing (State)


subscriptions : State -> Sub Msg
subscriptions model =
    Sub.none
