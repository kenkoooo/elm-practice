module UrlParserTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import Types exposing (JudgeService(..))
import UrlParser


suite : Test
suite =
    describe "Parse URLs of problems."
        [ test "Parse URLs of AtCoder problems" <|
            \_ ->
                "https://atcoder.jp/contests/tkppc4-1/tasks/tkppc4_1_h"
                    |> UrlParser.parseUrl
                    |> Expect.equal (Just { id = "tkppc4_1_h", judge = AtCoder })
        , test "Parse URLs of Aizu Online Judge" <|
            \_ ->
                "http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=3022"
                    |> UrlParser.parseUrl
                    |> Expect.equal (Just { id = "3022", judge = Aizu })
        ]
