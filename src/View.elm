module View exposing (imageList, loading, view)

import Html exposing (Html, button, div, footer, header, img, input, li, main_, p, span, text, ul)
import Html.Attributes exposing (alt, class, placeholder, src, style, value)
import Html.Events exposing (onClick, onInput)
import Message exposing (Msg(..))
import Model exposing (Image, RequestResponse, RequestStatus(..), State)


loading : Html Msg
loading =
    img [ class "loading", src "./src/assets/loading.svg", alt "Loading..." ] []


search : State -> Html Msg
search model =
    input
        [ class "search", onInput UpdateField, placeholder "Search photos...", value model.search ]
        []


submit : Html Msg
submit =
    button [ class "submit", onClick SearchImages ] [ text "Submit" ]


statusText : String -> Html Msg
statusText value =
    p [] [ text value ]


imageList : List Image -> Html Msg
imageList images =
    ul [ class "list" ]
        (List.map
            (\image ->
                li [ class "image-container" ]
                    [ span
                        [ class "image"
                        , style
                            "background-image"
                            ("url(" ++ image.url ++ ")")
                        , alt image.description
                        ]
                        []
                    ]
            )
            images
        )


statusContainer : State -> Html Msg
statusContainer model =
    case model.images of
        Loading ->
            loading

        Success response ->
            if List.length response < 1 then
                statusText "We couldn't find any images for that search term. Please try another. 😊"

            else
                imageList response

        Failure ->
            statusText "There was an unexpected error. Please try again. 😟"

        NotCalled ->
            statusText "Images will appear here. 😊"


view : State -> Html Msg
view model =
    div [ class "app" ]
        [ header
            []
            [ div [ class "field-set" ]
                [ search model, submit ]
            ]
        , main_ []
            [ statusContainer model
            ]
        , footer
            []
            []
        ]
