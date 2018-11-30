module Update exposing (update)

import Message exposing (Msg(..))
import Model exposing (Image, RequestStatus(..), State)
import Requests exposing (getImages)


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        UpdateField value ->
            ( { state | search = value }, Cmd.none )

        SearchImages ->
            ( { state | images = Loading }, getImages state.accessKey state.search )

        GotImages (Ok response) ->
            ( { state | images = Success response.results, search = "" }, Cmd.none )

        GotImages (Err _) ->
            ( { state | images = Failure }, Cmd.none )
