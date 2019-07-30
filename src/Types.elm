module Types exposing (JudgeService(..), Msg(..), ParsedProblem, ProblemCardInfo)

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


type alias ParsedProblem =
    { id : String
    , judge : JudgeService
    }


type JudgeService
    = AtCoder
    | Aizu
