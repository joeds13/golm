module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)


-- MODEL


type alias Model =
    { count : Int
    , mdl :
        Material.Model
    }


model : Model
model =
    { count = 0
    , mdl =
        Material.model
    }



-- ACTION, UPDATE


type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ text ("Current count: " ++ toString model.count)
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Options.onClick Increase
            , css "margin" "0 24px"
            ]
            [ text "Increase" ]
        , Button.render Mdl
            [ 1 ]
            model.mdl
            [ Options.onClick Reset ]
            [ text "Reset" ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
