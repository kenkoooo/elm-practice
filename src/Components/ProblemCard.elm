module Components.ProblemCard exposing (view)

import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Html exposing (Html, a, text)
import Html.Attributes exposing (href, target)
import Types exposing (ProblemCardInfo)


view : ProblemCardInfo -> Html msg
view info =
    Card.config []
        |> Card.block []
            [ Block.titleH4 [] [ a [ href info.url, target "_blank" ] [ text info.title ] ]
            , Block.text [] [ text "text" ]
            ]
        |> Card.view
