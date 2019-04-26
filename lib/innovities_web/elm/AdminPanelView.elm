module AdminPanelView exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



adminView : Model -> Html Msg
adminView model =
  if model.adminPanelSignedIn then
    registeredDataListView model
  else
    adminPanelLoginView model



registeredDataListView : Model -> Html Msg
registeredDataListView model =
  let
    ll = List.length model.adminPanelRegDataList
  in
    if ll == 0 then
      div [ style [("margin-top", "50%")] ] [ p [ style [("color", "blue")] ] [ text "Գրանցված տվյալներ չկան" ] ]
    else
      div []
        [ ul [ style [("height", "80vh"), ("overflow", "auto")] ] (List.map registeredDataWrapper (List.reverse model.adminPanelRegDataList)) ]


registeredDataWrapper : PromoRegData -> Html Msg
registeredDataWrapper data =
  li [ class "uk-flex uk-flex-column uk-margin-small-bottom", style [("border", "2px solid skyblue"), ("border-radius", "25px")] ]
    [ div [ class "uk-child-width-1-3" ]
      [ span [] [ text (toString data.id) ]
      , span [ style [("color", "yellow"), ("font-size", "120%")] ] [ text "   |   " ]
      , span [] [ text data.full_name ]
      , span [ style [("color", "yellow"), ("font-size", "120%")] ] [ text "   |   " ]
      , span [] [ text data.email ]
      , span [ style [("color", "yellow"), ("font-size", "120%")] ] [ text "   |   " ]
      , span [] [ text data.prefered_organization ]
      ]
    , div []
      [ p [ style [("font-size", "100%")] ] [ text data.short_description ] ]
    , div []
      [ p [ style [("font-size", "100%"), ("margin-top", "-1em")] ] [ text data.register_date ] ]
    ]


adminPanelLoginView : Model -> Html Msg
adminPanelLoginView model =
  div [ class "uk-flex uk-flex-column uk-flex-middle", style [("margin-top", "10%")] ]
    [ input [ style [("color", "black")], class "uk-margin-small-bottom", onInput OnAdminPanelFirstPasswordInput, placeholder "First Password" ] []
    , input [ style [("color", "black")], onInput OnAdminPanelSecondPasswordInput, placeholder "Second Password" ] []
    , p [ style [("color", "red"), ("font-size", "100%")] ] [ text model.adminPanelSignInError ]
    , button [ onClick OnAdminPanelSignIn, class "uk-button-primary" ] [ text "Մուտք" ]
    ]
