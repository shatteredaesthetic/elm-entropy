module Main exposing (..)

import Html exposing (Html)
import Html.App as App
import Types exposing (..)
import State exposing (updateState)
import View.BoardUI exposing (gameView)
import View.ConfigUI exposing (configUI)
import View.BreakUI exposing (breakUI)


init : ( GameState, Cmd Action )
init =
    ( Config (ConfigState "" ""), Cmd.none )


view : GameState -> Html Action
view gameState =
    case gameState of
        Config cfg ->
            configUI cfg

        InGame inGameState ->
            gameView inGameState

        OutGame inGameState ->
            breakUI inGameState


update : Action -> GameState -> ( GameState, Cmd Action )
update action gameState =
    ( updateState action gameState, Cmd.none )


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \state -> Sub.none
        }
