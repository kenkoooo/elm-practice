module Types exposing (AtCoderProblem, Error(..), Msg(..), ParsedProblem(..), ProblemCardInfo)

import Bootstrap.Navbar as Navbar
import Http


type alias ProblemCardInfo =
    { title : String
    , lastSolvedTime : Int
    , remindTime : Int
    , parsedProblem : ParsedProblem
    , url : String
    }


type ParsedProblem
    = AtCoder String String
    | Aizu (Maybe Int)
    | Other String


type Msg
    = NavbarMsg Navbar.State
    | Input String
    | Submit
    | GotAtCoderProblems (Result Error (List AtCoderProblem))


type Error
    = HttpError Http.Error


type alias AtCoderProblem =
    { id : String, contestId : String, title : String }
