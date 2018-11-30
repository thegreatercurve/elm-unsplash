module Model exposing (Image, RequestResponse, RequestStatus(..), State)


type alias Image =
    { description : String
    , url : String
    }


type alias RequestResponse =
    { results : List Image }


type RequestStatus a
    = NotCalled
    | Failure
    | Loading
    | Success a


type alias State =
    { accessKey : String, images : RequestStatus (List Image), search : String }
