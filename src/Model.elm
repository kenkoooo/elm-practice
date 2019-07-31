module Model exposing (Model)

import Bootstrap.Navbar as Navbar
import Types exposing (AtCoderProblem, ProblemCardInfo)


type alias Model =
    { navbarState : Navbar.State
    , input : String
    , problems : List ProblemCardInfo
    , atcoderProblems : List AtCoderProblem
    , errMsg : Maybe String
    }
