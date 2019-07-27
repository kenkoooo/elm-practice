module Components.ProblemCard exposing (view)

import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Html exposing (Html, text)
import Html.Attributes exposing (href)
import Types exposing (ProblemCardInfo)


view : ProblemCardInfo -> Html msg
view info =
    Card.config []
        |> Card.block []
            [ Block.titleH4 [] [ text info.title ]
            , Block.text [] [ text "text" ]
            , Block.link [ href "#" ] [ text "Card link" ]
            ]
        |> Card.view
