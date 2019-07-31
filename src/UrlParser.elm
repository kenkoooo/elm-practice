module UrlParser exposing (parseUrl)

import Types exposing (ParsedProblem(..))
import Url
import Url.Parser exposing ((</>), (<?>), Parser, map, oneOf, parse, s, string)
import Url.Parser.Query as Query


problemParser : Parser (ParsedProblem -> a) a
problemParser =
    oneOf
        [ map AtCoder (s "contests" </> string </> s "tasks" </> string)
        , map Aizu (s "onlinejudge" </> s "description.jsp" <?> Query.int "id")
        ]


parseUrl : String -> Maybe ParsedProblem
parseUrl url =
    Url.fromString url
        |> Maybe.map (\u -> Maybe.withDefault (Other url) (parse problemParser u))
