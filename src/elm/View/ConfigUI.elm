module View.ConfigUI exposing (configUI)

import Html exposing (Html, Attribute, div, h1, h3, text, p, a, input)
import Html.Attributes exposing (style, class, href, type')
import Html.Events exposing (onInput, onClick)
import Types exposing (..)
import View.Util exposing (..)


configUI : ConfigState -> Html Action
configUI cfg =
    div
        [ class "config-container"
        , styleList [ flexStyle, containerStyle ]
        ]
        [ div
            [ class "config-top-container"
            , styleList [ flexStyle, topContainerStyle ]
            ]
            [ h1 [ style titleStyle ] [ text "Entropy" ]
            , div
                [ class "config-form"
                , styleList [ flexStyle, formStyle ]
                ]
                [ div
                    [ class "config-leftside"
                    , styleList [ flexStyle, centerStyle, sidesStyle ]
                    ]
                    [ h3 [] [ text "Player 1 Name:" ]
                    , input
                        [ type' "text"
                        , onInput SetPlayer1
                        ]
                        []
                    ]
                , div
                    [ class "config-centerside"
                    , styleList [ flexStyle, centerStyle, centerSideStyle ]
                    ]
                    [ div
                        [ class "game-start-btn"
                        , styleList [ btnStyle, startGameBtnStyle ]
                        , onClick StartGame
                        ]
                        [ text "Start Game" ]
                    ]
                , div
                    [ class "config-rightside"
                    , styleList [ flexStyle, centerStyle, sidesStyle ]
                    ]
                    [ h3 [] [ text "Player 2 Name:" ]
                    , input
                        [ type' "text"
                        , onInput SetPlayer2
                        ]
                        []
                    ]
                ]
            ]
        , div
            [ class "config-instructions"
            , styleList [ flexStyle, infoStyle ]
            ]
            [ h3
                [ class "config-instructions-link" ]
                [ text "From "
                , a
                    [ style anchorStyle
                    , href "https://boardgamegeek.com/boardgame/1329/hyle"
                    ]
                    [ text "BoardGameGeek" ]
                ]
            , instructions
            ]
        ]


instructions : Html Action
instructions =
    div
        [ class "config-instructions-block" ]
        [ p [] [ text "Hyle (or Entropy) is played on a board with 5x5 spaces. During each round one player (Chaos) randomly draws and places colored wooden disks on a vinyl/cloth map. After a disk is placed, the other player (Order) may move any disk on the grid horizontally or vertically in order to form palindromes (sequences of colors that run the same forward as backward, for example, red/blue/yellow/blue/red)." ]
        , p [] [ text "The game is played over two rounds (so that each player assumes each role once) and points are awarded to Order equal to the length of the palindromes formed: blue/blue=2 points, blue/red/blue=3 points, etc. (Note that blue/blue/blue is worth 7 points because it contains two 2-point palindromes and one 3-point palindrome.)" ]
        ]


centerSideStyle : List Attr
centerSideStyle =
    [ "flex" => "1 0 auto" ]


sidesStyle : List Attr
sidesStyle =
    [ "flex" => "2 0 auto"
    , "flex-direction" => "column"
    ]


containerStyle : List Attr
containerStyle =
    [ "height" => "100%"
    , "width" => "100%"
    , "flex-direction" => "column"
    ]


formStyle : List Attr
formStyle =
    [ "justify-content" => "space-between"
    , "flex" => "1 0 auto"
    ]


infoStyle : List Attr
infoStyle =
    [ "flex" => "1 0 auto"
    , "flex-direction" => "column"
    , "background" => "#1e0812"
    , "color" => "#d8d8d8"
    ]


startGameBtnStyle : List Attr
startGameBtnStyle =
    [ "box-sizing" => "border-box"
    , "padding" => "5px"
    , "background" => "#b61e64"
    , "color" => "white"
    , "border-radius" => "5px"
    ]


anchorStyle : List Attr
anchorStyle =
    [ "color" => "#fcdfed"
    , "text-decoration" => "none"
    ]


titleStyle : List Attr
titleStyle =
    [ "color" => "#b61e64"
    , "background" => "#d8d8d8"
    , "position" => "relative"
    , "left" => "20px"
    , "font-size" => "3em"
    , "font-weight" => "bold"
    ]


topContainerStyle : List Attr
topContainerStyle =
    [ "flex-direction" => "column"
    , "flex" => "3 0 auto"
    , "box-shadow" => "inset 0px -2px 2px 0px #1e0812"
    , "background" => "#d8d8d8"
    ]
