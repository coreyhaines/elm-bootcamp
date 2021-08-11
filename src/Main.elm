module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


type alias Flags =
    {}


type alias Model =
    { tasks : List Task
    , newTaskName : String
    }


type alias Task =
    { name : String
    }


type Message
    = NewTaskNameInput String



-- Type inference


initialTasks =
    [ { name = "Clean my fridge" }
    , { name = "Feed cats" }
    , { name = "Change cat's water" }
    ]


init : Flags -> ( Model, Cmd Message )
init _ =
    ( { tasks = initialTasks
      , newTaskName = ""
      }
    , Cmd.none
    )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        NewTaskNameInput userInput ->
            ( { model
                | newTaskName = userInput
              }
            , Cmd.none
            )


view : Model -> Browser.Document Message
view model =
    { title = "Hello, Elm!"
    , body =
        [ div [] [ text "Hello, FOLKS! Let's build a TODO app!" ]
        , addNewTaskView model
        , taskListView model
        ]
    }


addNewTaskView model =
    div []
        [ input [ onInput NewTaskNameInput ] []
        ]


taskListView model =
    div [] (List.map taskView model.tasks)


taskView task =
    div [] [ text task.name ]


{-| Browser.document : { init : Flags -> ( Model, Cmd Message )
, update : Message -> Model -> ( Model, Cmd Message )
, view : Model -> Document Message
, subscriptions : Model -> Sub Message
} -> Program Flags Model Message
-}
main : Program Flags Model Message
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
