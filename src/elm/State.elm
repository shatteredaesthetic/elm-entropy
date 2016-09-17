module State exposing (initState, update)

import Maybe exposing (Maybe(..))
import List
import Matrix
import Types exposing (..)


-- MODEL


makeGrid : Matrix.Matrix Cell
makeGrid =
    let
        m =
            Matrix.repeat 5 5 Nothing

        f x y el =
            { x = x
            , y = y
            , highlight = False
            , content = el
            }
    in
        Matrix.indexedMap f m


initTiles : List Color
initTiles =
    [ Red, Blue, Yellow, Red, Green, Green, Orange, Yellow, Blue, Green, Blue, Yellow, Red, Yellow, Orange, Blue, Green, Red, Blue, Yellow, Orange, Green, Orange, Red, Orange ]


initState : ( Model, Cmd Msg )
initState =
    { board = makeGrid
    , message = ""
    , players = [ (Player "" 0 Chaos), (Player "" 0 Order) ]
    , round' = Yin
    , tiles = initTiles
    , tileIdx = 0
    , gameStep = Welcome
    }
        ! []



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetTile cell color' ->
            { model
                | board = setCell cell model.board color'
                , tileIdx = model.tileIdx + 1
            }
                ! []

        _ ->
            ( model, Cmd.none )


setCell : Cell -> Matrix.Matrix Cell -> Color -> Matrix.Matrix Cell
setCell cell matrix color' =
    let
        f cell' =
            { cell' | content = Just color' }
    in
        Matrix.update cell.x cell.y (\c -> f c) matrix



{--
initColorList : Array.Array Color
initColorList =
    [ Red, Orange, Yellow, Blue, Violet ]
        |> List.map (List.repeat 5)
        |> List.concat
        |> Array.fromList
--}
