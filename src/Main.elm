module Main exposing (main)

import Browser
import Html exposing (Html, div, text)


type alias Flags =
    {}


type alias Model =
    {}


type Msg
    = Noop


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Hello, Elm!"
    , body = [ div [] [ text "Hello, eSpark! Let's build a TODO app!" ] ]
    }


{-| Browser.document : { init : Flags -> ( Model, Cmd Msg )
, update : Msg -> Model -> ( Model, Cmd Msg )
, view : Model -> Document Msg
, subscriptions : Model -> Sub Msg
} -> Program Flags Model Msg
-}
main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
