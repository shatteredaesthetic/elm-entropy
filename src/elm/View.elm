module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Maybe exposing (withDefault)
import Array
import Matrix
import Styles exposing (..)
import Types exposing (..)
import Helpers exposing (getHexColor)
import Types exposing (..)


-- VIEW


view : Model -> Html Msg
view model =
    div [ style <| List.concat [ flexStyle, fullScreenStyle ] ]
        [ div [ style <| flexStyle ]
            [ div []
                [ gridView model.board (withDefault NoColor <| Array.get model.tileIdx <| Array.fromList model.tiles) ]
            ]
        ]


gridView : Matrix.Matrix Cell -> Color -> Html Msg
gridView grid color' =
    div
        [ style <| List.concat [ flexStyle ] ]
        [ grid
            |> Matrix.map (tileView color')
            |> matrixToDivs
        ]


tileView : Color -> Cell -> Html Msg
tileView color' cell =
    let
        cellColor =
            case cell.content of
                Nothing ->
                    ( "background", "#444444" )

                Just color' ->
                    ( "background", getHexColor color' )
    in
        div
            [ style <|
                List.concat
                    [ flexStyle
                    , cellStyle
                    , [ cellColor ]
                    ]
            , onClick <| SetTile cell color'
            ]
            []


matrixToDivs : Matrix.Matrix (Html.Html Msg) -> Html.Html Msg
matrixToDivs matrix =
    let
        makeRow y =
            Matrix.getRow y matrix
                |> Maybe.map (Array.toList)
                |> Maybe.withDefault []
                |> Html.div [ style <| List.concat [ flexStyle, rowStyle ] ]

        height =
            Matrix.height matrix
    in
        [0..height]
            |> List.map makeRow
            |> Html.div [ style <| List.concat [ flexStyle, boardStyle ] ]
