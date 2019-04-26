module LandingPageView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode exposing (string)

import Messages exposing (..)
import Models exposing (..)


landingView : Model -> Html Msg
landingView model =
  let
    mobileSignUpVisible = model.landingSignUpMobileVisible
    vis =
      if mobileSignUpVisible then
        ("visibility", "visible")
      else
        ("visibility", "hidden")

    nonVis =
      if not mobileSignUpVisible then
        ("visibility", "visible")
      else
        ("visibility", "hidden")

    dis =
      if not mobileSignUpVisible then
        ("visibility", "visible")
      else
        ("display", "none")
  in
    div []
      [ div [ class "headerLogo", style [("margin-top", "-2em")] ] []
      , div [ class "uk-flex uk-flex-middle", style [("margin-top", "3em")] ]
        [ motoDesc dis
        , motoDescDesktop
        , div [ class "uk-margin-large-left@m uk-width-1-2@m uk-visible@m" ]
          [ registerView model ]
        ]
      , div [ class "uk-width-1-1@mini uk-flex uk-flex-center uk-hidden@m" ]
        [ div [ class "uk-width-2-3@s uk-visible@s" ] [ registerViewTab model ] ]
      , button [ style [ ("position", "absolute"), ("bottom", "5px"), ("width", "80vw"), ("left", "0"), ("margin-right", "10vw"), ("margin-left", "10vw"), dis ], onClick OnLandingSignUpMobileClick, class "uk-margin-large-left@s uk-hidden@s uk-width-1-1@s subscribeButtonStyle uk-margin-small-top" ] [ text "ԳՐԱՆՑՎԵԼ" ]
      , div [ style [ vis ] ]
        [ registerViewMobile model ]
      ]

motoDescDesktop : Html Msg
motoDescDesktop =
  div [ class "uk-visible@m uk-margin-large-right uk-width-1-1@s uk-width-3-5@m uk-width-1-2@l" ]
    [ p [ style [ ("margin-top", "-1em"), ("font-size", "250%"), ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "INNOVITIES" ]
    , p [ style [ ("margin-top", "-1em"), ("font-size", "250%"), ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "WE TRUST" ]
    , p [ class "responsiveRightMargin", style [("padding-left", "2.1em"), ("font-size", "100%"), ("text-align", "left")] ] [ text "Innovities-ը սոցիալական հարթակ է, որտեղ ցանկացած օգտատեր հնարավորություն ունի իր գաղափարներն առաջարկել կազմակերպություններին, որոնք փնտրում են նորարական լուծումներ իրենց բիզնեսի համար:" ]
    --, p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "100%"), ("text-align", "left")] ] [ text "Մինչև նոյեմբերի 15-ը նախնական գրանցված օգտատերերին կտրամադրվի ", a [ href "#premium-info-dialog-id", attribute "uk-toggle" "", style [("display", "inline"), ("color", "gold")] ] [ text "Պրեմիում սակագնային պլանից" ],  text " 3 ամիս անվճար օգտվելու արտոնություն:" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "100%"), ("text-align", "left")] ] [ text "Գրանցվելուց կարող եք նշել, թե որ կազմակերպությանը կցանկանայիք տեսնել մեր կայքում, և մենք կանենք հնարավոր ամեն ինչ՝ նրանց ներգրավելու համար: Նաև, ցանկության դեպքում, կարող եք համառոտ գրել Ձեր գաղափարի մասին:" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "100%"), ("text-align", "left")] ] [ text "Եթե ունեք հարցեր կամ առաջարկություններ՝" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("margin-top", "-1em"), ("font-size", "100%"), ("text-align", "left")] ] [ text "կարող եք կապվել մեզ հետ ", a [ href "https://www.facebook.com/innovities/", target "_blank", style [("display", "inline"), ("color", "gold")] ] [ text "facebook" ], text "-յան էջի միջոցով:" ]
    , premiumPlanInfoDialog
    ]


motoDesc : (String, String) -> Html Msg
motoDesc displayStyle =
  div [ style [ displayStyle ], class "uk-hidden@m uk-margin-large-right uk-width-1-1@s uk-width-3-5@m uk-width-1-2@l" ]
    [ p [ style [ ("margin-top", "-1em"), ("font-size", "200%"), ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "INNOVITIES" ]
    , p [ style [ ("margin-top", "-1em"), ("font-size", "200%"), ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "WE TRUST" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-1em"), ("padding-left", "2.1em"), ("font-size", "75%"), ("text-align", "left")] ] [ text "Innovities-ը սոցիալական հարթակ է, որտեղ ցանկացած օգտատեր հնարավորություն ունի իր գաղափարներն առաջարկել կազմակերպություններին, որոնք փնտրում են նորարական լուծումներ իրենց բիզնեսի համար:" ]
    --, p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "75%"), ("text-align", "left")] ] [ text "Մինչև նոյեմբերի 15-ը նախնական գրանցված օգտատերերին կտրամադրվի ", a [ href "#premium-info-dialog-mobile-id", attribute "uk-toggle" "", style [("display", "inline"), ("color", "gold")] ] [ text "Պրեմիում սակագնային պլանից" ],  text " 3 ամիս անվճար օգտվելու արտոնություն:" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "75%"), ("text-align", "left")] ] [ text "Գրանցվելուց կարող եք նշել, թե որ կազմակերպությանը կցանկանայիք տեսնել մեր կայքում, և մենք կանենք հնարավոր ամեն ինչ՝ նրանց ներգրավելու համար: Նաև, ցանկության դեպքում, կարող եք համառոտ գրել Ձեր գաղափարի մասին:" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("font-size", "75%"), ("text-align", "left")] ] [ text "Եթե ունեք հարցեր կամ առաջարկություններ՝" ]
    , p [ class "responsiveRightMargin", style [("margin-top", "-0.5em"), ("padding-left", "2.1em"), ("margin-top", "-1em"), ("font-size", "75%"), ("text-align", "left")] ] [ text "կարող եք կապվել մեզ հետ ", a [ href "https://www.facebook.com/innovities/", target "_blank", style [("display", "inline"), ("color", "gold")] ] [ text "facebook" ], text "-յան էջի միջոցով:" ]
    , premiumPlanInfoDialogMobile
    ]


registerView : Model -> Html Msg
registerView model =
  let
    usernameError = model.landingUsernameError
    emailError = model.landingEmailError
    companyError = model.landingCompanyError
    ideaError = model.landingShortIdeaError
    regError = model.landingPromoRegisterError

    inputsVisible =
      if model.landingInputFieldsVisible then
        ("visibility", "visible")
      else
        ("visibility", "hidden")
  in
    div [ style [ inputsVisible ], class "uk-margin-medium-left" ]
      [ img [ style [("width", "5%"), ("height", "9%")], src "/images/head.png" ] []
      , p [ style [("font-size", "small"), ("margin-top", "3%")] ] [ text "Idea Generator" ]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ div [ class "uk-flex uk-flex-column", style [("margin-right", "0.5%")] ]
          [ input [ onInput OnLandingUsernameType, style [("font-size", "100%"), ("padding", "0.3em"), ("color", "black")], placeholder "Օգտատիրոջ անուն*" ] []
          , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text usernameError ]
          ]
        , div [ class "uk-flex uk-flex-column" ]
          [ input [ onInput OnLandingEmailType, style [("font-size", "100%"), ("padding", "0.3em"), ("color", "black")], placeholder "Էլ. հասցե*" ] []
          , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text emailError ]
          ]
        ]
      , div [ class "uk-flex uk-flex-column" ]
        [ input [ onInput OnLandingCompanyType, class "uk-margin-small-top", style [("font-size", "100%"), ("padding", "0.3em"), ("color", "black")], placeholder "Կազմակերպություն, որին կցանկանայիք տեսնել մեր կայքում" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text companyError ]
        , textarea [ onInput OnLandingShortIdeaType, rows 4, style [("resize", "none"), ("font-size", "100%"), ("padding", "0.3em"), ("color", "black")], class "uk-margin-small-top", placeholder "2-3 նախադասությամբ կարող եք գրել Ձեր գաղափարի մասին" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text ideaError ]
        , button [ onClick OnLandingSignUp, class "subscribeButtonStyle uk-margin-small-top" ] [ text "ԳՐԱՆՑՎԵԼ" ]
        , p [ style [("font-size", "105%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text regError ]
        , confirmDialog
        ]
      ]

registerViewTab : Model -> Html Msg
registerViewTab model =
  let
    usernameError = model.landingUsernameError
    emailError = model.landingEmailError
    companyError = model.landingCompanyError
    ideaError = model.landingShortIdeaError
    regError = model.landingPromoRegisterError

    inputsVisible =
      if model.landingInputFieldsVisible then
        ("visibility", "visible")
      else
        ("visibility", "hidden")
  in
    div [ style [ inputsVisible ] ]
      [ img [ style [("width", "5%"), ("height", "9%")], src "/images/head.png" ] []
      , p [ style [("font-size", "83%"), ("margin-top", "2%")] ] [ text "Idea Generator" ]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ div [ class "uk-flex uk-flex-column uk-margin-small-right" ]
          [ input [ onInput OnLandingUsernameType, style [("font-size", "100%"), ("height", "1.8em"), ("padding", "0.3em"), ("color", "black")], placeholder "Օգտատիրոջ անուն*" ] []
          , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text usernameError ]
          ]
        , div [ class "uk-flex uk-flex-column" ]
          [ input [ onInput OnLandingEmailType, style [("font-size", "100%"), ("height", "1.8em"), ("padding", "0.3em"), ("color", "black")], placeholder "Էլ. հասցե*" ] []
          , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text emailError ]
          ]
        ]
      , div [ class "uk-flex uk-flex-column" ]
        [ input [ onInput OnLandingCompanyType, class "uk-margin-small-top", style [("font-size", "100%"), ("height", "1.8em"), ("width", "100%"), ("padding", "0.3em"), ("color", "black")], placeholder "Կազմակերպություն, որին կցանկանայիք տեսնել մեր կայքում" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text companyError ]
        , textarea [ onInput OnLandingShortIdeaType, rows 2, style [("resize", "none"), ("overflow", "hidden"), ("font-size", "100%"), ("width", "100%"), ("padding", "0.3em"), ("color", "black")], class "uk-margin-small-top", placeholder "2-3 նախադասությամբ կարող եք գրել Ձեր գաղափարի մասին" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text ideaError ]
        , button [ onClick OnLandingSignUp, class "subscribeButtonStyle uk-margin-small-top" ] [ text "ԳՐԱՆՑՎԵԼ" ]
        , p [ style [("font-size", "105%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text regError ]
        , confirmDialog
        ]
      ]


registerViewMobile : Model -> Html Msg
registerViewMobile model =
  let
    usernameError = model.landingUsernameError
    emailError = model.landingEmailError
    companyError = model.landingCompanyError
    ideaError = model.landingShortIdeaError
    regError = model.landingPromoRegisterError

    inputsVisible =
      if model.landingInputFieldsVisible then
        ("visibility", "visible")
      else
        ("visibility", "hidden")
  in
    div [ class "uk-hidden@s", style [("margin-top", "-2em")] ]
      [ img [ style [("width", "7%"), ("height", "12%")], src "/images/head.png" ] []
      , p [ style [("font-size", "small"), ("margin-top", "3%")] ] [ text "Idea Generator" ]
      , div [ class "uk-flex uk-flex-column" ]
        [ input [ onInput OnLandingUsernameType, style [("padding", "0.3em"), ("color", "black")], placeholder "Օգտատիրոջ անուն*" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text usernameError ]
        , input [ onInput OnLandingEmailType, class "uk-margin-small-top", style [("padding", "0.3em"), ("color", "black")], placeholder "Էլ. հասցե*" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text emailError ]
        , input [ onInput OnLandingCompanyType, class "uk-margin-small-top", style [("padding", "0.3em"), ("color", "black")], placeholder "Նախընտրած կազմակերպություն" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text companyError ]
        , textarea [ onInput OnLandingShortIdeaType, rows 4, style [("resize", "none"), ("padding", "0.3em"), ("color", "black")], class "uk-margin-small-top", placeholder "2-3 նախադասությամբ կարող եք գրել Ձեր գաղափարի մասին" ] []
        , p [ style [("font-size", "95%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text ideaError ]
        , button [ onClick OnLandingSignUp, class "subscribeButtonStyle uk-width-1-1 uk-margin-small-top" ] [ text "ԳՐԱՆՑՎԵԼ" ]
        , p [ style [("font-size", "105%"), ("margin-top", "-0.05em"), ("margin-bottom", "-0.05em"), ("color", "red")] ] [ text regError ]
        , confirmDialog
        ]
      ]


premiumPlanInfoDialogMobile : Html Msg
premiumPlanInfoDialogMobile =
  div [ id "premium-info-dialog-mobile-id", class "uk-flex-top", attribute "uk-modal" "" ]
    [ div [ style [("background", "rgb(62,63,77)")], class "uk-width-1-1@s uk-width-1-2@m uk-width-1-3@l uk-modal-dialog uk-modal-body uk-margin-auto-vertical" ]
      [ div [ style [("border", "0.2em solid gold")] ]
        [ h4 [ style [("width", "50%"), ("background", "rgb(62,63,77)"), ("color", "white"), ("text-align", "center"), ("margin-left", "25%"), ("margin-top", "-1em")] ] [ text "Պրեմիում" ]
        , p [ style [("margin-top", "-1em"), ("text-align", "center")] ] [ span [ property "innerHTML" (string "&#1423;") ] [], span [ style [("font-weight", "bold"), ("font-size", "110%")] ] [ text "10,500" ], span [ style [("font-size", "small")] ] [ text "/ամս" ] ]
        , p [ style [("margin-top", "-1.5em"), ("text-align", "center")] ] [ span [ property "innerHTML" (string "&#1423;") ] [], span [ style [("font-weight", "bold"), ("font-size", "110%")] ] [ text "115,500" ], span [ style [("font-size", "small")] ] [ text "/տար*" ] ]
        , p [ style [("margin-top", "-1.5em"), ("text-align", "center")] ] [ span [ style [("font-size", "110%"), ("color", "gold")] ] [ text "*խնայեք " ], span [ style [("color", "gold")], property "innerHTML" (string "&#1423;") ] [], span [ style [("color", "gold"), ("font-weight", "bold")] ] [ text "10,500" ] ]
        , div [ class "uk-flex uk-child-width-1-2" ]
          [ div [ style [("margin-right", "0.5em")] ]
            [ p [ style [("text-align", "center"), ("font-size", "70%")] ] [ text "Գաղափարների ներմուծման քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "90%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "8" ]
            , p [ style [("text-align", "center"), ("font-size", "70%")] ] [ text "Հաղորդագրություններ ստանալու քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "90%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "Անսահմանափակ" ]
            ]
          , div [ style [("margin-left", "0.5em")] ]
            [ p [ style [("text-align", "center"), ("font-size", "70%")] ] [ text "Հաղորդագրություններ ուղարկելու քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "90%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "8" ]
            , p [ style [("padding-top", "1em"), ("text-align", "center"), ("font-size", "70%")] ] [ text "Տարածաշրջան" ]
            , p [ style [("margin-top", "-0.5em"), ("font-size", "90%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "Բոլոր երկրները" ]
            ]
          ]
        , button [ attribute "uk-close" "", class "uk-modal-close-default" ] []
        ]
      ]
    ]


premiumPlanInfoDialog : Html Msg
premiumPlanInfoDialog =
  div [ id "premium-info-dialog-id", class "uk-flex-top", attribute "uk-modal" "" ]
    [ div [ style [("background", "rgb(62,63,77)")], class "uk-width-1-1@s uk-width-1-2@m uk-width-1-3@l uk-modal-dialog uk-modal-body uk-margin-auto-vertical" ]
      [ div [ style [("border", "0.2em solid gold")] ]
        [ h4 [ style [("width", "50%"), ("background", "rgb(62,63,77)"), ("color", "white"), ("text-align", "center"), ("margin-left", "25%"), ("margin-top", "-1em")] ] [ text "Պրեմիում" ]
        , p [ style [("margin-top", "-1em"), ("text-align", "center")] ] [ span [ property "innerHTML" (string "&#1423;") ] [], span [ style [("font-weight", "bold"), ("font-size", "110%")] ] [ text "10,500" ], span [ style [("font-size", "small")] ] [ text "/ամս" ] ]
        , p [ style [("margin-top", "-1.5em"), ("text-align", "center")] ] [ span [ property "innerHTML" (string "&#1423;") ] [], span [ style [("font-weight", "bold"), ("font-size", "110%")] ] [ text "115,500" ], span [ style [("font-size", "small")] ] [ text "/տար*" ] ]
        , p [ style [("margin-top", "-1.5em"), ("text-align", "center")] ] [ span [ style [("font-size", "110%"), ("color", "gold")] ] [ text "*խնայեք " ], span [ style [("color", "gold")], property "innerHTML" (string "&#1423;") ] [], span [ style [("color", "gold"), ("font-weight", "bold")] ] [ text "10,500" ] ]
        , div [ class "uk-flex uk-child-width-1-2" ]
          [ div []
            [ p [ style [("text-align", "center"), ("font-size", "small")] ] [ text "Գաղափարների ներմուծման քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "110%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "8" ]
            , p [ style [("text-align", "center"), ("font-size", "small")] ] [ text "Հաղորդագրություններ ստանալու քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "110%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "Անսահմանափակ" ]
            ]
          , div []
            [ p [ style [("text-align", "center"), ("font-size", "90%")] ] [ text "Հաղորդագրություններ ուղարկելու քանակ" ]
            , p [ style [("margin-top", "-1em"), ("font-size", "110%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "8" ]
            , p [ style [("padding-top", "1em"), ("text-align", "center"), ("font-size", "90%")] ] [ text "Տարածաշրջան" ]
            , p [ style [("margin-top", "-0.5em"), ("font-size", "110%"), ("text-align", "center"), ("color", "skyblue")] ] [ text "Բոլոր երկրները" ]
            ]
          ]
        , button [ attribute "uk-close" "", class "uk-modal-close-default" ] []
        ]
      ]
    ]

confirmDialog : Html Msg
confirmDialog =
  div [ id "confirm-dialog-id", class "uk-flex-top", attribute "uk-modal" "" ]
    [ div [ class "uk-width-1-1@s uk-width-1-2@m uk-width-1-4@l uk-modal-dialog uk-modal-body uk-margin-auto-vertical" ]
      [ h3 [ style [("color", "skyblue"), ("text-align", "center")] ] [ text "ՇՆՈՐՀԱԿԱԼՈւԹՅՈւՆ՝" ]
      , p [ style [("font-size", "110%"), ("color", "black"), ("margin-top", "-1em"), ("text-align", "center")] ] [ text "մեր հարթակում գրանցվելու համար: Մենք լրացուցիչ կկապվենք Ձեզ հետ և կտեղեկացնենք հետագա քայլերի մասին:" ]
      , p [ style [("margin-right", "5%"), ("margin-left", "5%"), ("font-size", "small"), ("color", "black"), ("text-align", "center")] ] [ text "Եթե ունեք հարցեր կամ առաջարկություններ, կարող եք կապվել մեզ հետ ", a [ href "https://www.facebook.com/innovities/", target "_blank", style [("color", "skyblue"), ("display", "inline")] ] [ text "facebook" ], text "-յան էջի միջոցով:" ]
      , p [ style [("font-size", "small"), ("color", "black"), ("text-align", "center")] ] [ text "Հետևեք մեզ՝" ]
      , div [ style [("margin-top", "-1em")] ]
        [ a [ href "https://www.facebook.com/innovities/", target "_blank" ] [ div [ style [ ("display", "inline") ] ] [ img [ style [("width", "10%"), ("height", "10%"), ("margin-left", "33%"),  ("margin-right", "0.3em")], src "/images/fb_skyblue.png" ] [] ] ]
        , a [ href "https://twitter.com/innovities", target "_blank" ] [ div [ style [ ("display", "inline") ] ] [ img [ style [("width", "10%"), ("height", "10%"), ("margin-right", "0.3em")], src "/images/twitter_skyblue.png" ] []  ] ]
        , a [ href "https://www.linkedin.com/company/innovities/", target "_blank" ] [ div [ style [ ("display", "inline") ] ] [ img [ style [("width", "10%"), ("height", "10%")], src "/images/in_skyblue.png" ] [] ] ]
        ]
      , button [ attribute "uk-close" "", class "uk-modal-close-default" ] []
      ]
    ]
