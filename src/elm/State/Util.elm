module State.Util exposing (..)

import Matrix exposing (..)
import Matrix.Extra as MExtra
import Array
import Types exposing (..)


switchRole : Role -> Role
switchRole role =
    case role of
        Chaos ->
            Order

        Order ->
            Chaos


getCellColour : Int -> Int -> Board -> Maybe Colour
getCellColour x y board =
    case Matrix.get x y board of
        Nothing ->
            Nothing

        Just cell ->
            cell.colour


makeBoard : Board
makeBoard =
    let
        m =
            Matrix.repeat 5 5 Nothing

        f x y el =
            { x = x
            , y = y
            , highlight = False
            , colour = el
            }
    in
        Matrix.indexedMap f m


isBoardFull : Board -> Bool
isBoardFull board =
    Matrix.map (\cell -> cell.colour) board
        |> Matrix.filter (\colour -> colour == Nothing)
        |> Array.isEmpty


validateMove : Int -> Int -> InGameState -> Bool
validateMove x y state =
    case Matrix.get x y state.board of
        Nothing ->
            False

        Just cell ->
            let
                neighbors =
                    MExtra.neighboursFour x y state.board

                isANeighbor =
                    List.member cell neighbors
            in
                case cell.colour of
                    Nothing ->
                        if state.tiles.current == Nothing && isANeighbor then
                            False
                        else
                            True

                    Just _ ->
                        False
