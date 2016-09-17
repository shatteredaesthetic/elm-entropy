module Styles exposing (flexStyle, devModelStyle, fullScreenStyle, cellStyle, rowStyle, boardStyle)


type alias Styl =
    ( String, String )


(=>) : String -> String -> Styl
(=>) =
    (,)


flexStyle : List Styl
flexStyle =
    [ "display" => "flex" ]


devModelStyle : List Styl
devModelStyle =
    [ "border" => "5px solid green"
    , "align-self" => "flex-end"
    ]


fullScreenStyle : List Styl
fullScreenStyle =
    [ "height" => "85vh"
    , "width" => "100vw"
    ]


cellStyle : List Styl
cellStyle =
    [ "flex" => "1 1 25%"
    , "width" => "94px"
    , "height" => "94px"
    , "border" => "3px solid #000000"
    ]


rowStyle : List Styl
rowStyle =
    [ "flex" => "1 1 25%"
    , "flex-direction" => "row"
    ]


boardStyle : List Styl
boardStyle =
    [ "width" => "500px"
    , "height" => "500px"
    , "border" => "4px dashed blue"
    , "flex-wrap" => "wrap"
    ]


highlightStyle : List Styl
highlightStyle =
    [ "border" => "3px dashed white"
    ]
