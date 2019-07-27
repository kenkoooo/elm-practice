module Types exposing (Msg(..), ProblemCardInfo)

import Bootstrap.Navbar as Navbar


type alias ProblemCardInfo =
    { title : String
    }


type Msg
    = NavbarMsg Navbar.State
    | Input String
    | Submit
