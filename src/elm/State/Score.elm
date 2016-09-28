module State.Score exposing (..)

import Array exposing (Array)
import Matrix exposing (Matrix)
import List.Extra exposing (groupsOfWithStep)
import Types exposing (..)
import State.Util exposing (..)


scoreChaos : Player -> Board -> Player
scoreChaos player board =
    let
        rowScore =
            reduceBoardDirection Matrix.getRow board

        colScore =
            reduceBoardDirection Matrix.getColumn board
    in
        Player player.name (switchRole player.role) (rowScore + colScore)


palindrome : List a -> Bool
palindrome list =
    list == List.reverse list


reduceBoardDirection : (Int -> Board -> Maybe (Array Cell)) -> Board -> Int
reduceBoardDirection f board =
    let
        arr i =
            f i board
                |> Maybe.map Array.toList
                |> Maybe.withDefault []

        lofl =
            [0..4]
                |> List.map arr

        fGroups i lst =
            groupsOfWithStep i 1 lst

        g =
            flip fGroups
    in
        [2..5]
            |> List.map (g lofl)
            |> List.foldl (::) []
            |> List.filter palindrome
            |> List.map List.length
            |> List.foldl (+) 0
