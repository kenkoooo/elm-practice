module UrlParser exposing (parseUrl)

import Regex
import Types exposing (JudgeService(..), ParsedProblem)
import Utils exposing (maybeOrElse)


parseUrl : String -> Maybe ParsedProblem
parseUrl url =
    parseAtCoderProblemUrl url
        |> maybeOrElse (\_ -> parseAizuProblemUrl url)


parseAtCoderProblemUrl : String -> Maybe ParsedProblem
parseAtCoderProblemUrl url =
    parseUrlWithRegex "atcoder\\.jp/contests/[\\w_\\-]+/tasks/(.+)$" url
        |> Maybe.map (\id -> { id = id, judge = AtCoder })


parseAizuProblemUrl : String -> Maybe ParsedProblem
parseAizuProblemUrl url =
    parseUrlWithRegex "judge\\.u\\-aizu\\.ac\\.jp/onlinejudge/description\\.jsp\\?id=(.+)$" url
        |> Maybe.map (\id -> { id = id, judge = Aizu })


parseUrlWithRegex : String -> String -> Maybe String
parseUrlWithRegex regex url =
    Regex.fromString regex
        |> Maybe.andThen
            (\re ->
                Regex.findAtMost 1 re url
                    |> List.head
                    |> Maybe.andThen (\match -> List.head match.submatches)
                    |> Maybe.andThen (\a -> a)
            )
