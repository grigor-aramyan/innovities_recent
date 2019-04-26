module BackButtonView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



backButtonView : Model -> Html Msg
backButtonView model =
  let
    pageHistory = model.pageHistory

    arrowColor =
      if ((List.length pageHistory) > 0) then
        ("color", "gold")
      else
        ("color", "white")

    backDisabled =
      if ((List.length pageHistory) > 0) then
        ("pointer-events", "auto")
      else
        ("pointer-events", "none")
  in
    div [ class "backButtonClass" ]
    [ a [ onClick OnBackButtonPressed, class "uk-icon-button", style [ ("background", "rgba(220,220,220,0.7)"), arrowColor, backDisabled ], attribute "uk-icon" "icon: arrow-left; ratio: 2" ] [] ]



backButtonViewMobile : Model -> Html Msg
backButtonViewMobile model =
  let
    pageHistory = model.mobilePageHistory

    arrowColor =
      if ((List.length pageHistory) > 0) then
        ("color", "gold")
      else
        ("color", "white")

    backDisabled =
      if ((List.length pageHistory) > 0) then
        ("pointer-events", "auto")
      else
        ("pointer-events", "none")
  in
    div [ class "backButtonClassMobile" ]
    [ a [ onClick OnBackButtonPressedMobile, class "uk-icon-button", style [ ("background", "rgba(220,220,220,0.7)"), arrowColor, backDisabled ], attribute "uk-icon" "icon: arrow-left; ratio: 2" ] [] ]
