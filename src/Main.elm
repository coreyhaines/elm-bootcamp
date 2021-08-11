module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


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
    | AddTaskClicked



-- Type inference


init : Flags -> ( Model, Cmd Message )
init _ =
    ( { tasks = []
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

        AddTaskClicked ->
            ( addTask model
            , Cmd.none
            )


addTask : Model -> Model
addTask model =
    if String.isEmpty model.newTaskName then
        model

    else
        { model
            | tasks = { name = model.newTaskName } :: model.tasks
            , newTaskName = ""
        }


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
        [ input [ onInput NewTaskNameInput, value model.newTaskName ] []
        , button [ onClick AddTaskClicked ] [ text "Add" ]
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
