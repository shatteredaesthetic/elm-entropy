module State.Util exposing (..)

import Matrix exposing (..)
import Matrix.Extra exposing (neighboursFour)
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
    board
        |> Matrix.map (\cell -> cell.colour)
        |> Matrix.filter (\colour -> colour == Nothing)
        |> Array.isEmpty


validateOrder : Int -> Int -> InGameState -> Bool
validateOrder x y state =
    case Matrix.get x y state.board of
        Nothing ->
            False

        Just cell ->
            cell.highlight


validateChaos : Int -> Int -> InGameState -> Bool
validateChaos x y state =
    case Matrix.get x y state.board of
        Nothing ->
            False

        Just cell ->
            case cell.colour of
                Just _ ->
                    False

                Nothing ->
                    True


highlightNeighbors : Int -> Int -> Matrix Cell -> Matrix Cell
highlightNeighbors x y board =
    let
        highlightCell cell =
            case cell.colour of
                Nothing ->
                    { cell | highlight = not cell.highlight }

                Just _ ->
                    cell
    in
        board
            |> Matrix.update (x + 1) y highlightCell
            |> Matrix.update (x - 1) y highlightCell
            |> Matrix.update x (y + 1) highlightCell
            |> Matrix.update x (y - 1) highlightCell


removeHighlights : Matrix Cell -> Matrix Cell
removeHighlights board =
    Matrix.map (\cell -> { cell | highlight = False }) board
