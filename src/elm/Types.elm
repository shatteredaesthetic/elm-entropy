module Types exposing (..)

import Matrix
import Maybe
import Array


type alias Model =
    { board : Matrix.Matrix Cell
    , message : String
    , players : List Player
    , round' : Round
    , tiles : List Color
    , tileIdx : Int
    , gameStep : GameStep
    }


type alias Cell =
    { x : Int
    , y : Int
    , highlight : Bool
    , content : Maybe Color
    }


type Round
    = Yin
    | Yang


type GameStep
    = Welcome
    | GamePlay Role
    | GameOver


type Role
    = Chaos
    | Order


type alias Player =
    { name : String
    , score : Int
    , role : Role
    }


type Msg
    = NoOp
    | Start
    | MakeTiles Array.Array
    | ValidateMove Int Int
    | SetTile Cell Color
    | PickupTile Int Int
    | ScoreRound (Matrix.Matrix Cell)
    | Winner ( Int, Int )


type Color
    = NoColor
    | Red
    | Orange
    | Yellow
    | Green
    | Aqua
    | Blue
    | Violet
