module Main exposing (main)

import Browser
import Message exposing (Msg(..))
import Model exposing (RequestStatus(..), State)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : String -> ( State, Cmd Msg )
init accessKey =
    ( { accessKey = accessKey, images = NotCalled, search = "" }, Cmd.none )


main : Program String State Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
