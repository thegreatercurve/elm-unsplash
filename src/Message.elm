module Message exposing (Msg(..))

import Http
import Model exposing (..)


type Msg
    = UpdateField String
    | GotImages (Result Http.Error RequestResponse)
    | SearchImages
