module Main exposing (main)

import Bootstrap.CDN as CDN
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Browser
import Components.Navbar as Navbar
import Components.ProblemCard as ProblemCard
import Html exposing (Html, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput, onSubmit)
import Http
import Model exposing (Model)
import Types exposing (Msg(..), ProblemCardInfo)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type UserInfoState
    = Init
    | Waiting
    | Loaded UserInfo
    | Failed Http.Error


type alias UserInfo =
    { userId : String
    , acceptedCount : Int
    , acceptedCountRank : Int
    , ratedPointSum : Int
    , ratedPointSumRank : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState NavbarMsg
    in
    ( { navbarState = navbarState, problems = [], input = "" }, navbarCmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )

        Input input ->
            ( { model | input = input }, Cmd.none )

        Submit ->
            ( { model | input = "", problems = { title = model.input } :: model.problems }, Cmd.none )


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet
        , Navbar.view model
        , Grid.row []
            [ Grid.col []
                [ Form.form [ onSubmit Submit ]
                    [ Form.group []
                        [ Form.label [] [ text "" ]
                        , Input.text [ Input.attrs [ placeholder "aaa", onInput Input, value model.input ] ]
                        ]
                    ]
                ]
            ]
        , Grid.row []
            [ Grid.col []
                (List.map
                    (\info -> ProblemCard.view info)
                    model.problems
                )
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navbarState NavbarMsg
