module ContactUsView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)


contactUsView : Model -> Html Msg
contactUsView model =
  let
    inputedData = model.contactUsData
    name = inputedData.name
    email = inputedData.email
    message = inputedData.message
    error = inputedData.error

    errorColor =
      if (String.contains "message has been submitted" error) then
        ("color", "lime")
      else
        ("color", "red")
  in
    div [ class "responsiveVisibility", id "contacts", style [("margin", "auto"), ("width", "50vw")] ]
      [ h3 [ style [("color", "gold")] ] [ text "Contact us" ]
      , span []
        [ input [ onInput OnContactUsNameInput, style [("color", "black"), ("padding", "0.5em"), ("width", "24vw"), ("margin-right", "1vw")], placeholder "First Name", value name ] []
        , input [ onInput OnContactUsEmailInput, style [("color", "black"), ("padding", "0.5em"), ("width", "24vw"), ("margin-left", "1vw")], placeholder "E-mail", value email ] []
        ]
      , textarea [ onInput OnContactUsMessageInput, style [("width", "50vw"), ("color", "black"), ("padding", "0.5em"), ("margin-top", "1em")], placeholder "Message", rows 4, value message ] []
      , br[][]
      , p [ style [ errorColor, ("font-size", "110%"), ("margin-top", "-0.3em") ] ] [ text error ]
      , button [ onClick OnContactUsFormSubmit, class "subscribeButtonStyle", style [("padding", "1.5em"), ("padding-top", "0.5em"), ("padding-bottom", "0.5em")] ] [ text "Send" ]
      ]

contactUsViewTab : Model -> Html Msg
contactUsViewTab model =
  let
    inputedData = model.contactUsData
    name = inputedData.name
    email = inputedData.email
    message = inputedData.message
    error = inputedData.error

    errorColor =
      if (String.contains "message has been submitted" error) then
        ("color", "lime")
      else
        ("color", "red")
  in
    div [ class "responsiveVisibilityTab", id "contacts-t", style [("margin", "auto"), ("width", "70vw")] ]
      [ h3 [ style [("color", "gold")] ] [ text "Contact us" ]
      , span []
        [ input [ onInput OnContactUsNameInput,  style [("color", "black"), ("padding", "0.5em"), ("width", "34vw"), ("margin-right", "1vw")], placeholder "First Name", value name ] []
        , input [ onInput OnContactUsEmailInput, style [("color", "black"), ("padding", "0.5em"), ("width", "34vw"), ("margin-left", "1vw")], placeholder "E-mail", value email ] []
        ]
      , textarea [ onInput OnContactUsMessageInput, style [("width", "70vw"), ("color", "black"), ("padding", "0.5em"), ("margin-top", "1em")], placeholder "Message", rows 4, value message ] []
      , br[][]
      , p [ style [ errorColor, ("font-size", "110%"), ("margin-top", "-0.3em") ] ] [ text error ]
      , button [ onClick OnContactUsFormSubmit, class "subscribeButtonStyle", style [("padding", "1.5em"), ("padding-top", "0.5em"), ("padding-bottom", "0.5em")] ] [ text "Send" ]
      ]

contactUsViewMobile : Model -> Html Msg
contactUsViewMobile model =
  let
    vis =
      if model.mobileContactView then
        ("display", "initial")
      else
        ("display", "none")

    inputedData = model.contactUsData
    name = inputedData.name
    email = inputedData.email
    message = inputedData.message
    error = inputedData.error

    errorColor =
      if (String.contains "message has been submitted" error) then
        ("color", "green")
      else
        ("color", "red")

  in
    div [ class "responsiveVisibilityMobile", id "contacts", style [ vis, ("position", "absolute"), ("bottom", "10px"), ("left", "0"), ("width", "100vw")] ]
      [ div [ style [("margin", "auto"), ("width", "80%")] ]
        [ h5 [ style [("font-weight", "bold"), ("color", "gold")] ] [ text "Contact us" ]
        , input [ onInput OnContactUsNameInput, style [("text-align", "center"), ("color", "black"), ("padding", "0.3em"), ("width", "50vw")], placeholder "First Name", value name ] []
        , input [ onInput OnContactUsEmailInput, style [("text-align", "center"), ("color", "black"), ("padding", "0.3em"), ("width", "50vw"), ("margin-top", "1em")], placeholder "E-mail", value email ] []
        , textarea [ onInput OnContactUsMessageInput, style [("width", "80vw"), ("color", "black"), ("padding", "0.3em"), ("margin-top", "1.5em")], placeholder "Message", rows 4, value message ] []
        , p [ style [ errorColor, ("font-size", "110%"), ("margin-top", "-0.3em") ] ] [ text error ]
        , button [ onClick OnContactUsFormSubmit, class "subscribeButtonStyle", style [("margin-top", "1em"), ("width", "50vw"), ("padding-top", "0.3em"), ("padding-bottom", "0.3em")] ] [ text "Send" ]
        ]
      ]
