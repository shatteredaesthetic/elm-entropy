module State exposing (..)

import Matrix exposing (Matrix)
import Random exposing (initialSeed)
import Dict
import Array exposing (Array)
import Types exposing (..)
import Tiles exposing (..)
import State.Util exposing (makeBoard)
import State.Game exposing (updateGame)


updateState : Action -> GameState -> GameState
updateState action state =
    case state of
        Config cfg ->
            updateConfig action cfg

        InGame state ->
            updateGame action state

        OutGame state ->
            updateBreak action state


updateBreak : Action -> InGameState -> GameState
updateBreak action state =
    case action of
        NextRound ->
            InGame
                { state
                    | round = 2
                    , turn = Chaos
                    , board = makeBoard
                    , message = ""
                    , tiles = TileState Nothing Dict.empty (initialSeed <| 5 ^ 5)
                }

        NewGame ->
            Config (ConfigState "" "")

        _ ->
            OutGame state


updateConfig : Action -> ConfigState -> GameState
updateConfig action cfg =
    case action of
        SetPlayer1 str ->
            Config { cfg | player1name = str }

        SetPlayer2 str ->
            Config { cfg | player2name = str }

        StartGame ->
            InGame
                { board = makeBoard
                , player1 = Player cfg.player1name Chaos 0
                , player2 = Player cfg.player2name Order 0
                , turn = Chaos
                , tiles = randomTile <| TileState Nothing Dict.empty (initialSeed <| 5 ^ 5)
                , round = 1
                , message = "Place tile in any empty square"
                }

        _ ->
            Config cfg
