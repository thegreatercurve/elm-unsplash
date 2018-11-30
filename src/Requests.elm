module Requests exposing (baseUrl, getImages, imageDecoder, imagesDecoder, searchImages)

import Http exposing (get)
import Json.Decode exposing (Decoder, decodeString, field, int, list, map, map2, null, oneOf, string)
import Message exposing (Msg(..))
import Model exposing (Image, RequestResponse)


baseUrl : String -> String
baseUrl accessKey =
    "https://api.unsplash.com/search/photos?client_id=" ++ accessKey


searchImages : String -> String -> String
searchImages accessKey query =
    baseUrl accessKey ++ "&query=" ++ query


imageDecoder : Decoder Image
imageDecoder =
    map2 Image
        (field
            "description"
            (oneOf [ string, null "" ])
        )
        (field
            "urls"
            (field
                "regular"
                string
            )
        )


imagesDecoder : Decoder RequestResponse
imagesDecoder =
    map RequestResponse
        (field
            "results"
            (list imageDecoder)
        )


getImages : String -> String -> Cmd Msg
getImages accessKey query =
    get { expect = Http.expectJson GotImages imagesDecoder, url = searchImages accessKey query }
