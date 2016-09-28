module View.BoardUI exposing (gameView)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Array
import Maybe
import Matrix exposing (Matrix)
import Types exposing (..)
import View.Util exposing (..)


gameView : InGameState -> Html Action
gameView state =
    div
        [ class "game-container"
        , styleList [ flexStyle, containerStyle ]
        ]
        [ header state
        , div [ styleList [ flexStyle, centerStyle ] ] [ board state.board ]
        , footer state.message
        ]


header : InGameState -> Html Action
header state =
    div
        [ class "game-header"
        , styleList [ flexStyle, headerStyle ]
        ]
        [ div
            [ class "header-player1"
            , styleList [ flexStyle, playerHeaderStyle ]
            ]
            [ playerToken state.player1
            , div
                [ class "player-name"
                , styleList
                    [ flexStyle
                    , playerNameStyle
                    , [ "justify-content" => "flex-start", "padding-left" => "20px" ]
                    ]
                ]
                [ text state.player1.name ]
            ]
        , div
            [ class "selected-tile"
            , styleList [ flexStyle, centerStyle, selectedTileStyle ]
            ]
            [ div
                [ style <| currentTileStyle state ]
                []
            ]
        , div
            [ class "header-player2"
            , styleList [ flexStyle, playerHeaderStyle ]
            ]
            [ div
                [ class "player-name"
                , styleList
                    [ flexStyle
                    , playerNameStyle
                    , [ "justify-content" => "flex-end", "padding-right" => "20px" ]
                    ]
                ]
                [ text state.player2.name ]
            , playerToken state.player2
            ]
        ]


playerToken : Player -> Html Action
playerToken player =
    let
        token =
            case player.role of
                Chaos ->
                    "C"

                Order ->
                    "O"
    in
        div
            [ class "token-container"
            , styleList [ flexStyle, centerStyle ]
            ]
            [ div
                [ class "player-token"
                , style tokenStyle
                ]
                [ text token ]
            ]


board : Matrix Cell -> Html Action
board board =
    let
        board' =
            Matrix.map cellView board
    in
        [0..4]
            |> List.map (makeBoardRow board')
            |> div
                [ class "game-board-container"
                , styleList [ flexStyle, boardContainerStyle ]
                ]


cellView : Cell -> Html Action
cellView cell =
    let
        bgColor =
            case cell.colour of
                Nothing ->
                    [ ( "background", "#1e0812" ) ]

                Just colour ->
                    [ ( "background", tileToString colour ) ]
    in
        div
            [ class "board-cell"
            , styleList [ bgColor, tileStyle ]
            , onClick (Choose cell.x cell.y)
            ]
            []


makeBoardRow : Matrix (Html Action) -> Int -> Html Action
makeBoardRow board y =
    Matrix.getRow y board
        |> Maybe.map Array.toList
        |> Maybe.withDefault []
        |> div
            [ class "board-row"
            , styleList [ flexStyle, boardRowStyle ]
            ]


footer : String -> Html Action
footer message =
    div
        [ class "game-footer"
        , styleList [ flexStyle, centerStyle, footerStyle ]
        ]
        [ div
            [ class "game-footer-inner" ]
            [ text <| ">  " ++ message ]
        ]


makePlayerHeader : Player -> Html Action
makePlayerHeader player =
    div
        [ class "header-player" ]
        [ div
            [ class "player-token" ]
            []
        , div
            [ class "player-name" ]
            [ text player.name ]
        ]


currentTileStyle : InGameState -> List Attr
currentTileStyle state =
    let
        bg =
            case state.tiles.current of
                Nothing ->
                    [ "background" => "#1e0812" ]

                Just colour ->
                    [ "background" => tileToString colour ]

        base =
            [ "width" => "80%"
            , "height" => "80%"
            ]
    in
        List.concat [ bg, base ]


containerStyle : List Attr
containerStyle =
    [ "width" => "100%"
    , "height" => "100%"
    , "flex-direction" => "column"
    ]


tileStyle : List Attr
tileStyle =
    [ "flex" => "1 0 auto"
    , "border" => "2px solid #fcdfed"
    , "border-radius" => "3px"
    ]


boardRowStyle : List Attr
boardRowStyle =
    [ "flex-direction" => "column"
    , "flex" => "1 0 auto"
    ]


boardContainerStyle : List Attr
boardContainerStyle =
    [ "flex" => "8 0 auto"
    , "height" => "60vh"
    , "width" => "60vh"
    ]


headerStyle : List Attr
headerStyle =
    [ "flex" => "1 0 auto"
    , "background" => "#d8d8d8"
    ]


footerStyle : List Attr
footerStyle =
    [ "flex" => "1 0 auto"
    , "background" => "#1e0812"
    , "color" => "#fafafa"
    , "font-family" => "Monospace"
    , "box-shadow" => "inset 0px 3px 3px 0px #d8d8d8"
    ]


playerHeaderStyle : List Attr
playerHeaderStyle =
    [ "flex" => "1 0 auto" ]


selectedTileStyle : List Attr
selectedTileStyle =
    [ "flex" => "1 0 auto" ]


playerNameStyle : List Attr
playerNameStyle =
    [ "flex" => "2 0 auto"
    , "font-size" => "5em"
    , "align-items" => "center"
    , "color" => "#1e0812"
    , "font-weight" => "bold"
    ]


tokenStyle : List Attr
tokenStyle =
    [ "box-sizing" => "border-box"
    , "flex" => "1 0 auto"
    , "border" => "5px solid #1e0812"
    , "font-size" => "7em"
    , "font-weight" => "bolder"
    , "padding" => "5px"
    , "color" => "#b61e64"
    ]
