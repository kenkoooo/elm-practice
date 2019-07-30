module Utils exposing (maybeOrElse)


maybeOrElse : (() -> Maybe a) -> Maybe a -> Maybe a
maybeOrElse f maybe =
    case maybe of
        Just _ ->
            maybe

        Nothing ->
            f ()
