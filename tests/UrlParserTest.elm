module UrlParserTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import Types exposing (ParsedProblem(..))
import UrlParser


suite : Test
suite =
    describe "Parse URLs of problems."
        [ test "Parse URLs of AtCoder problems" <|
            \_ ->
                "https://atcoder.jp/contests/tkppc4-1/tasks/tkppc4_1_h"
                    |> UrlParser.parseUrl
                    |> Expect.equal (Just (AtCoder "tkppc4-1" "tkppc4_1_h"))
        , test "Parse URLs of Aizu Online Judge" <|
            \_ ->
                "http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=3022"
                    |> UrlParser.parseUrl
                    |> Expect.equal (Just (Aizu (Just 3022)))
        , test "Parse URLs of others" <|
            \_ ->
                "http://example.com/"
                    |> UrlParser.parseUrl
                    |> Expect.equal (Just (Other "http://example.com/"))
        ]
