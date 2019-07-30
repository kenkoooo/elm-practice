module Types exposing (Msg(..), ParsedProblem(..), ProblemCardInfo)

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


type ParsedProblem
    = AtCoder String String
    | Aizu (Maybe Int)
    | Other String
