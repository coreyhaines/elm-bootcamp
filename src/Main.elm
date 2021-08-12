module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


type alias Flags =
    {}


type alias Task =
    { name : TaskName
    , id : TaskId
    , description : TaskDescription
    }


type TaskName
    = TaskName String


type TaskDescription
    = TaskDescription String


type TaskId
    = Id Int


type alias Model =
    { tasks : List Task
    , newTaskName : TaskName
    , newTaskDescription : TaskDescription
    , nextTaskId : TaskId
    }


type Msg
    = AddTaskName String
    | AddTaskDescription String
    | AddTask
    | DeleteTask TaskId


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { tasks = []
      , newTaskName = TaskName ""
      , newTaskDescription = TaskDescription ""
      , nextTaskId = Id 1
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTaskName newContent ->
            ( { model | newTaskName = TaskName newContent }, Cmd.none )

        AddTaskDescription inputTaskDescription ->
            ( { model
                | newTaskDescription = TaskDescription inputTaskDescription
              }
            , Cmd.none
            )

        AddTask ->
            if
                String.isEmpty (taskNameToString model.newTaskName)
                    || String.isEmpty (taskDescriptionToString model.newTaskDescription)
            then
                ( model, Cmd.none )

            else
                ( { model
                    | tasks =
                        { id = model.nextTaskId
                        , name = model.newTaskName
                        , description = model.newTaskDescription
                        }
                            :: model.tasks
                    , newTaskName = TaskName ""
                    , newTaskDescription = TaskDescription ""
                    , nextTaskId = newTaskId model.nextTaskId
                  }
                , Cmd.none
                )

        DeleteTask taskIdToDelete ->
            ( { model
                | tasks = List.filter (\task -> task.id /= taskIdToDelete) model.tasks
              }
            , Cmd.none
            )


taskNameToString : TaskName -> String
taskNameToString (TaskName name) =
    name


taskDescriptionToString : TaskDescription -> String
taskDescriptionToString (TaskDescription description) =
    description


newTaskId : TaskId -> TaskId
newTaskId currentTaskId =
    case currentTaskId of
        Id id ->
            Id (id + 1)


view : Model -> Browser.Document Msg
view model =
    { title = "Hello, Elm!"
    , body =
        [ div [] [ text "Welcome! Here are your tasks for today:" ]
        , div []
            [ input
                [ value (taskNameToString model.newTaskName)
                , onInput AddTaskName
                ]
                []
            , input
                [ value (taskDescriptionToString model.newTaskDescription)
                , onInput AddTaskDescription
                ]
                []
            , button [ onClick AddTask ] [ text "Add" ]
            ]
        , div [] [ viewTaskList model ]
        ]
    }


viewTaskList : Model -> Html Msg
viewTaskList model =
    div [] (List.map viewTask model.tasks)


viewTask : Task -> Html Msg
viewTask task =
    div []
        [ span [ onClick (DeleteTask task.id) ] [ text "x" ]
        , text " - "
        , text (taskNameToString task.name)
        , text ": "
        , text (taskDescriptionToString task.description)
        ]


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
