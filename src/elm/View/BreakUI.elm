module View.BreakUI exposing (breakUI)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Types exposing (..)


breakUI : InGameState -> Html Action
breakUI gameState =
    div
        []
        [ scoreBox gameState.player1
        , div
            [ class "scoreboard-center" ]
            [ gameBtn gameState ]
        , scoreBox gameState.player2
        ]


scoreBox : Player -> Html Action
scoreBox player =
    div
        [ class "scoreboard-left" ]
        [ h3 [] [ text (player.name ++ " score:") ]
        , div [] [ text <| toString player.score ]
        ]


gameBtn : InGameState -> Html Action
gameBtn state =
    if state.round < 2 then
        div
            [ class "game-start-btn"
            , onClick NextRound
            ]
            [ text "Next Round" ]
    else
        div
            [ class "game-start-btn"
            , onClick NewGame
            ]
            [ text "New Game" ]
