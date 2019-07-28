module Types exposing (Msg(..), ProblemCardInfo)

import Bootstrap.Navbar as Navbar


type alias ProblemCardInfo =
    { title : String
    , lastSolvedTime : Int
    , remindTime : Int
    }


type Msg
    = NavbarMsg Navbar.State
    | Input String
    | Submit
