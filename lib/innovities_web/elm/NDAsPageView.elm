module NDAsPageView exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Messages exposing (..)



ndasPageView : Model -> Html Msg
ndasPageView model =
  let
    ndas = model.signedNDAs

    view =
      if (List.length ndas > 0) then
        ul [ style [("list-style-type", "none"), ("margin", "0"), ("padding", "0")] ]
          (List.map signedNdasListItem ndas)
      else
        p [ style [("color", "black")] ] [ text "No signed NDAs!" ]
  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "Signed NDAs" ]
      , br[][], br[][], br[][]
      , view
      ]
    ]


signedNdasListItem : SignedNDA -> Html Msg
signedNdasListItem item =
  li []
    [ div [ class "uk-flex uk-child-width-1-5" ]
      [ span [ style [("color", "black"), ("text-align", "center")] ] [ text item.signing_date ]
      , span [ style [("color", "black"), ("text-align", "center")] ] [ text item.idea_name ]
      , span [ style [("color", "black"), ("text-align", "center")] ] [ text item.idea_industry ]
      , span [ style [("color", "black"), ("text-align", "center")] ] [ text item.idea_price ]
      , a [ onClick (OnOpenNDAsIdea item.idea_id), style [("color", "skyblue"), ("text-decoration", "underline"), ("text-align", "center")] ] [ text "View" ]
      ]
    , span [ style [("color", "orange"), ("font-weight", "bold")] ] [ text "______________" ]
    ]



signedNdasListItemForMobile : SignedNDA -> Html Msg
signedNdasListItemForMobile item =
  li []
    [ div [ class "uk-flex uk-flex-column" ]
      [ span [ style [("color", "black"), ("text-align", "center")] ] [ text item.signing_date ]
      , span [ style [("color", "black"), ("text-align", "center")] ] [ text item.idea_name ]
      , span [ style [("color", "black"), ("text-align", "center")] ] [ text item.idea_industry ]
      , span [ style [("color", "black"), ("text-align", "center"), ("font-style", "italic")] ] [ text item.idea_price ]
      , a [ onClick (OnOpenNDAsIdea item.idea_id), style [("color", "skyblue"), ("text-decoration", "underline"), ("text-align", "center")] ] [ text "View" ]
      , span [ style [("color", "orange"), ("font-weight", "bold")] ] [ text "______________" ]
      ]
    ]



ndasPageViewTab : Model -> Html Msg
ndasPageViewTab model =
  let
    ndas = model.signedNDAs

    view =
      if (List.length ndas > 0) then
        ul [ style [("list-style-type", "none"), ("margin", "0"), ("padding", "0")] ]
          (List.map signedNdasListItem ndas)
      else
        p [ style [("color", "black")] ] [ text "No signed NDAs!" ]
  in
    div []
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "10vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "Signed NDAs" ]
      , br[][], br[][], br[][]
      , view
      ]
    ]



ndasPageViewMobile : Model -> Html Msg
ndasPageViewMobile model =
  let
    ndas = model.signedNDAs

    view =
      if (List.length ndas > 0) then
        ul [ style [("list-style-type", "none"), ("margin", "0"), ("padding", "0")] ]
          (List.map signedNdasListItemForMobile ndas)
      else
        p [ style [("color", "black")] ] [ text "No signed NDAs!" ]
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "5vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "Signed NDAs" ]
      , br[][], br[][], br[][]
      , view
      ]
    ]
