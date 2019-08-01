port module Main exposing (main)

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
import Json.Decode exposing (Value)
import Model exposing (Model)
import Services.AtCoder as AtCoder
import Task
import Types exposing (AtCoderProblem, Msg(..), ParsedProblem(..), ProblemCardInfo)
import UrlParser


port storeCache : Maybe Value -> Cmd msg


port onStoreChange : (Value -> msg) -> Sub msg


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState NavbarMsg
    in
    ( { navbarState = navbarState
      , problems = []
      , input = ""
      , atcoderProblems = []
      , errMsg = Nothing
      }
    , navbarCmd
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )

        Input input ->
            ( { model | input = input }, Cmd.none )

        Submit ->
            case createCard model.input of
                Just newCard ->
                    let
                        newCmd =
                            case newCard.parsedProblem of
                                AtCoder _ _ ->
                                    if List.isEmpty model.atcoderProblems then
                                        Task.attempt GotAtCoderProblems AtCoder.getProblems

                                    else
                                        Cmd.none

                                _ ->
                                    Cmd.none
                    in
                    ( { model
                        | input = ""
                        , problems =
                            List.map (updateProblemCardInfo model) (newCard :: model.problems)
                      }
                    , newCmd
                    )

                Nothing ->
                    ( model, Cmd.none )

        GotAtCoderProblems result ->
            case result of
                Err _ ->
                    ( { model | errMsg = Just "Failed fetching the problem list of AtCoder" }, Cmd.none )

                Ok problems ->
                    let
                        updatedModel =
                            { model | atcoderProblems = problems }
                    in
                    ( { updatedModel | problems = List.map (updateProblemCardInfo updatedModel) updatedModel.problems }
                    , Cmd.none
                    )


createCard : String -> Maybe ProblemCardInfo
createCard url =
    UrlParser.parseUrl url
        |> Maybe.map
            (\parsedProblem ->
                { title = url
                , lastSolvedTime = 0
                , remindTime = 0
                , parsedProblem = parsedProblem
                , url = url
                }
            )


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


updateProblemCardInfo : Model -> ProblemCardInfo -> ProblemCardInfo
updateProblemCardInfo model info =
    case info.parsedProblem of
        AtCoder _ problemId ->
            let
                x =
                    List.filter (\problem -> problem.id == problemId) model.atcoderProblems
                        |> List.head
            in
            case x of
                Just p ->
                    { info | title = p.title }

                Nothing ->
                    info

        _ ->
            info
