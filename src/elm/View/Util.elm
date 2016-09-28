module View.Util exposing (..)

import Color exposing (Color, toRgb)
import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (style)
import Types exposing (..)
import String


styleList : List (List Attr) -> Attribute Action
styleList lists =
    style <| List.concat lists


toRgbaString : Color -> String
toRgbaString color' =
    let
        { red, green, blue, alpha } =
            toRgb color'

        rgb' =
            [ toString red, toString green, toString blue, toString alpha ]
    in
        "rgba(" ++ (String.join ", " rgb') ++ ")"


htmlFromAttributes : List (Attribute Action) -> Html Action
htmlFromAttributes attributes =
    div attributes []


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type alias Attr =
    ( String, String )


hiddenStyle : List ( String, String )
hiddenStyle =
    [ "display" => "hidden" ]


tileToString : Colour -> String
tileToString colour =
    case colour of
        Red ->
            "red"

        Orange ->
            "orange"

        Green ->
            "green"

        Blue ->
            "blue"

        Violet ->
            "violet"


getHexColor : Colour -> String
getHexColor color' =
    case color' of
        Red ->
            "#f21f1f"

        Orange ->
            "#f78818"

        Green ->
            "#5fd813"

        Blue ->
            "#1953e5"

        Violet ->
            "#da1ee8"


flexStyle : List Attr
flexStyle =
    [ "display" => "flex" ]


centerStyle : List Attr
centerStyle =
    [ "justify-content" => "center"
    , "align-items" => "center"
    ]


btnStyle : List Attr
btnStyle =
    [ "cursor" => "pointer" ]
