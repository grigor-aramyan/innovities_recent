module HeaderView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)
import LangLocals exposing (..)


headerView : Model -> Html Msg
headerView model =
  let
    po = model.pricingOpened

    mobileGeneralDefaultView =
      if model.mobileDefaultView then
        ("display", "inline-block")
      else
        ("visibility", "hidden")

  in
    div [ class "headerStyle" ]
      [ div []
        [ div [ style [ mobileGeneralDefaultView ], class "headerLogo" ] []
        , mobileMenuView
        , div [ class "responsiveVisibility", style [ ("float", "right"), ("margin-right", "1em") ] ]
            [ a [ onClick (OnSwitchLang Arm), style [ ("color", "white") ] ] [ text "arm" ]
              , text " | "
              , a [ onClick (OnSwitchLang Eng), style [ ("color", "white") ] ] [ text "eng" ]
            ]
        ]
      , headerNavigationView po model
      , headerNavigationViewTab po model
      ]


mobileMenuView : Html Msg
mobileMenuView =
  span [ style [("margin-bottom", "2em")], class "responsiveVisibilityMobile" ]
    [ div [ style [("float", "left"), ("margin-left", "1em")] ]
      [ a [ onClick (OnSwitchLang Arm), style [ ("color", "white") ] ] [ text "arm" ]
        , text " | "
        , a [ onClick (OnSwitchLang Eng), style [ ("color", "white") ] ] [ text "eng" ]
      ]
    , a [ onClick OnMobileMenuOpen, href "#menu-m" ] [ div [ style [("display", "inline")] ] [ img [ style [("width", "10%"), ("heigh", "10%"), ("float", "right"), ("margin-right", "1em")], src "/images/menu_toggler_trans.png" ] [] ] ]
    ]


headerNavigationView : PricingOpen -> Model -> Html Msg
headerNavigationView po model =
  ul [ class "headerNavigationStyle responsiveVisibility" ]
    [ li [ style [ ("float", "left") ] ]
      [ a [ href "#innovators" ] [ text (getLocal "Idea generators" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#organizations" ] [ text (getLocal "Organizations" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick OnPricingOpen ] [ text (getLocal "Pricing " model), span [ attribute "uk-icon" "icon: triangle-down" ] [] ]
      , pricingULView po
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#about-us" ] [ text (getLocal "About us" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#contacts" ] [ text (getLocal "Contact" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#faq" ] [ text "FAQ" ]
      , span [ class "headerNavigationBar" ] [ text "" ]
      ]
    ]


headerNavigationViewTab : PricingOpen -> Model -> Html Msg
headerNavigationViewTab po model =
  ul [ class "responsiveVisibilityTab headerNavigationStyle" ]
    [ li [ style [ ("float", "left") ] ]
      [ a [ href "#innovators-t" ] [ text (getLocal "Idea generators" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#organizations-t" ] [ text (getLocal "Organizations" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick OnPricingOpen ] [ text (getLocal "Pricing " model), span [ attribute "uk-icon" "icon: triangle-down" ] [] ]
      , pricingULViewTab po
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#about-us-t" ] [ text (getLocal "About us" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#contacts-t" ] [ text (getLocal "Contact" model) ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ href "#faq-t" ] [ text "FAQ" ]
      , span [ class "headerNavigationBar" ] [ text "" ]
      ]
    ]

pricingULView : PricingOpen -> Html Msg
pricingULView po =
  let
    v =
      case po of
        Opened -> "visible"
        Closed -> "hidden"
  in
    ul [ style [ ("visibility", v), ("listStyleType", "none"), ("position", "absolute"), ("right", "47%"), ("top", "105%") ] ]
      [ li [] [ a [ onClick OnPricingClose, style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#innovators-pricing" ] [ text "Idea Generators" ] ]
      , div [ class "whiteDividerStyle" ] []
      , li [] [ a [ onClick OnPricingClose, style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#organizations-pricing" ] [ text "Organizations" ] ]
      ]

pricingULViewTab : PricingOpen -> Html Msg
pricingULViewTab po =
  let
    v =
      case po of
        Opened -> "visible"
        Closed -> "hidden"
  in
    ul [ style [ ("visibility", v), ("listStyleType", "none"), ("position", "absolute"), ("right", "42%"), ("top", "105%") ] ]
      [ li [] [ a [ onClick OnPricingClose, style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#innovators-pricing-t" ] [ text "Idea Generators" ] ]
      , div [ class "whiteDividerStyle" ] []
      , li [] [ a [ onClick OnPricingClose, style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#organizations-pricing-t" ] [ text "Organizations" ] ]
      ]
