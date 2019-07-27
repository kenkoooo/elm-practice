module Components.Navbar exposing (initialState, subscriptions, view)

import Bootstrap.Navbar as Navbar
import Html exposing (Html, text)
import Html.Attributes exposing (href)
import Model exposing (Model)
import Types exposing (Msg(..))


view : Model -> Html Msg
view model =
    Navbar.config NavbarMsg
        |> Navbar.withAnimation
        |> Navbar.brand [ href "#" ] [ text "Brand" ]
        |> Navbar.items
            [ Navbar.itemLink [] [ text "a" ]
            , Navbar.itemLink [] []
            , Navbar.dropdown
                { id = "dropdown"
                , toggle = Navbar.dropdownToggle [] [ text "drop" ]
                , items =
                    [ Navbar.dropdownHeader [ text "header" ]
                    , Navbar.dropdownItem [ href "#" ] [ text "item" ]
                    ]
                }
            ]
        |> Navbar.view model.navbarState


initialState toMsg =
    Navbar.initialState toMsg


subscriptions =
    Navbar.subscriptions
