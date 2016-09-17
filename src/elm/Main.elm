module Main exposing (..)

import Html.App as App
import Types exposing (..)
import State exposing (initState, update)
import View exposing (view)


-- APP


main : Program Never
main =
    App.program
        { init = initState
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
