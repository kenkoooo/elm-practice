module Services.AtCoder exposing (getProblems)

import Http
import Json.Decode as D exposing (Decoder)
import Task exposing (Task)
import Types exposing (AtCoderProblem, Error(..))


problemDecoder : Decoder AtCoderProblem
problemDecoder =
    D.map3 AtCoderProblem
        (D.field "id" D.string)
        (D.field "contest_id" D.string)
        (D.field "title" D.string)


problemUrl : String
problemUrl =
    "https://kenkoooo.com/atcoder/resources/problems.json"


getProblems : Task Error (List AtCoderProblem)
getProblems =
    Http.task
        { method = "GET"
        , headers = []
        , url = problemUrl
        , body = Http.emptyBody
        , resolver = Http.stringResolver <| handleJsonResponse <| D.list problemDecoder
        , timeout = Nothing
        }
        |> Task.mapError HttpError


handleJsonResponse : Decoder a -> Http.Response String -> Result Http.Error a
handleJsonResponse decoder response =
    case response of
        Http.BadUrl_ url ->
            Err (Http.BadUrl url)

        Http.Timeout_ ->
            Err Http.Timeout

        Http.BadStatus_ { statusCode } _ ->
            Err (Http.BadStatus statusCode)

        Http.NetworkError_ ->
            Err Http.NetworkError

        Http.GoodStatus_ _ body ->
            case D.decodeString decoder body of
                Err _ ->
                    Err (Http.BadBody body)

                Ok result ->
                    Ok result
