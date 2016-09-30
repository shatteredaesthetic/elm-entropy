module State.Game exposing (updateGame)

import Matrix exposing (Matrix)
import Types exposing (..)
import State.Util exposing (..)
import State.Score exposing (scoreChaos)
import Tiles exposing (randomTile)


updateGame : Action -> InGameState -> GameState
updateGame action state =
    case action of
        Choose x y ->
            case state.turn of
                Chaos ->
                    updateChaos x y state

                Order ->
                    updateOrder x y state

        _ ->
            InGame state


updateOrder : Int -> Int -> InGameState -> GameState
updateOrder x y state =
    case state.tiles.current of
        Nothing ->
            case getCellColour x y state.board of
                Nothing ->
                    InGame { state | message = "Select a Tile first." }

                Just colour ->
                    let
                        tiles =
                            state.tiles

                        tiles' =
                            { tiles | current = Just colour }
                    in
                        InGame
                            { state
                                | board =
                                    state.board
                                        |> Matrix.update x y (\cell -> { cell | colour = Nothing })
                                        |> highlightNeighbors x y
                                , tiles = tiles'
                                , message = "Place tile in any Empty Cell."
                            }

        Just tile ->
            case getCellColour x y state.board of
                Just _ ->
                    InGame { state | message = "Place tile in any Empty Cell." }

                Nothing ->
                    let
                        cell' =
                            Cell (Just tile) False x y
                    in
                        if validateOrder x y state then
                            InGame
                                { state
                                    | board =
                                        state.board
                                            |> Matrix.set x y cell'
                                            |> removeHighlights
                                    , tiles = randomTile state.tiles
                                    , turn = Chaos
                                    , message = "Place new Tile in any Empty Cell."
                                }
                        else
                            InGame { state | message = "You can't put a Tile on another Tile." }


updateChaos : Int -> Int -> InGameState -> GameState
updateChaos x y state =
    let
        cell' =
            Cell (state.tiles.current) False x y

        board' =
            Matrix.set x y cell' state.board

        tiles =
            state.tiles

        tiles' =
            { tiles | current = Nothing }
    in
        case isBoardFull board' of
            True ->
                case state.round of
                    1 ->
                        makeBreak state board' Player1

                    _ ->
                        makeBreak state board' Player2

            False ->
                if validateChaos x y state then
                    InGame
                        { state
                            | board = board'
                            , turn = switchRole state.turn
                            , tiles = tiles'
                            , message = "Select any Tile on Board."
                        }
                else
                    InGame { state | message = "You can't put a Tile on another Tile." }


type PlayerProxy
    = Player1
    | Player2


makeBreak : InGameState -> Board -> PlayerProxy -> GameState
makeBreak state newBoard isPlyr1 =
    case isPlyr1 of
        Player1 ->
            let
                player2 =
                    state.player2

                player2' =
                    { player2 | role = switchRole player2.role }
            in
                OutGame
                    { state
                        | board = newBoard
                        , player1 = scoreChaos state.player1 newBoard
                        , player2 = player2'
                    }

        Player2 ->
            let
                player1 =
                    state.player1

                player1' =
                    { player1 | role = switchRole player1.role }
            in
                OutGame
                    { state
                        | board = newBoard
                        , player2 = scoreChaos state.player2 newBoard
                    }
