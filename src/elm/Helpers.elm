module Helpers exposing (getHexColor)

import Types exposing (Color(..))


getHexColor : Color -> String
getHexColor color' =
    case color' of
        Red ->
            "#f21f1f"

        Orange ->
            "#f78818"

        Yellow ->
            "#f4e916"

        Green ->
            "#5fd813"

        Aqua ->
            "#1eede9"

        Blue ->
            "#1953e5"

        Violet ->
            "#da1ee8"
