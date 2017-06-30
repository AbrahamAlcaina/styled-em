module State exposing (update, subscriptions, init)

import Json.Decode exposing (decodeString)
import Time
import Types exposing (..)
import Api exposing (decoder)
import Ports exposing (load, doload)


subscriptions : Types.Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every
            (Time.second * 30)
            SaveModelTick
        , Ports.load Types.LoadModel
        ]


update : Msg -> Types.Model -> ( Types.Model, Cmd Msg )
update msg model =
    case msg of
        SaveModelTick _ ->
            ( model, Ports.save model )

        LoadModel value ->
            case decodeString Api.decoder value of
                Err msg ->
                    ( { model | click = 99 }, Cmd.none )

                Ok val ->
                    ( { model | click = val.click }, Cmd.none )

        SaveModel ->
            ( model, Ports.save model )

        Increment ->
            ( { model | click = model.click + 1 }, Cmd.none )

        Decrement ->
            ( { model | click = model.click - 1 }, Cmd.none )


init : ( Types.Model, Cmd Types.Msg )
init =
    ( { click = 0
      }
    , Ports.doload ()
    )
