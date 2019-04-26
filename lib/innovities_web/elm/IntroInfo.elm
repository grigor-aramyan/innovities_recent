module IntroInfo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)
import CountriesList as CL exposing (..)
import LangLocals as LL exposing (..)



mobileMenuScreenView : Model -> Html Msg
mobileMenuScreenView model =
  let
    menuVisible =
      if model.mobileMenuView then
        ("display", "block")
      else
        ("display", "none")

    toggleVisible =
      if model.mobilePricingToggleOpen then
        ("display", "initial")
      else
        ("display", "none")

    bgColor =
      if model.mobilePricingToggleOpen then
        ("background-color", "rgba(192,192,192,0.8)")
      else
        ("background-color", "rgba(119,136,153,0.8)")
  in
    div [ style [ menuVisible ] ]
      [ p [ style [("visibility", "hidden")] ] [ text "par" ]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block"), ("margin-bottom", "1em")], href "#innovators-m", onClick OnMobileIdeaGeneratorsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text (LL.getLocal "Idea generators" model) ] ]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block"), ("margin-bottom", "1em")], href "#organizations-m", onClick OnMobileOrganizationsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text (LL.getLocal "Organizations" model) ] ]
      --, a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block")], onClick OnMobilePricingToggle ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), bgColor, ("color", "white"), ("width", "80vw")] ] [ text "Pricing", span [ attribute "uk-icon" "triangle-down" ] [] ] ]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block")], href "#tarrif-plans-m", onClick OnMobileTarrifPlansViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text (LL.getLocal "Pricing " model) ] ]
      --, div [ style [ toggleVisible ] ]
        --[ a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block")], href "#innovators-pricing-m", onClick OnMobilePricingIdeaGeneratorsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(255,215,0,0.4)"), ("color", "white"), ("width", "80vw")] ] [ text "Idea Generators" ] ]
        --, a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block")], href "#organizations-pricing-m", onClick OnMobilePricingOrganizationsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(255,215,0,0.4)"), ("color", "white"), ("width", "80vw")] ] [ text "Organizations" ] ]
        --]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block"), ("margin-top", "1em"), ("margin-bottom", "1em")], href "#about-us-m", onClick OnMobileAboutUsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text (LL.getLocal "About Us" model) ] ]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block"), ("margin-bottom", "1em")], href "#contacts-m", onClick OnMobileContactUsViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text (LL.getLocal "Contact" model) ] ]
      , a [ style [("width", "80vw"), ("margin-left", "8vw"), ("display", "block"), ("margin-bottom", "1em")], href "#faq-m", onClick OnMobileFaqViewOpen ] [ button [ style [("padding", "0.8em 0"), ("border", "none"), ("background-color", "rgba(119,136,153,0.8)"), ("color", "white"), ("width", "80vw")] ] [ text "FAQ" ] ]
      ]


infoView : Model -> Html Msg
infoView model =
  let
    registerCompanyOpened = model.registerCompanyOpened
    registerIdeaGeneratorOpened = model.registerIdeaGeneratorOpened
    phoneGetStartedViewOpened = model.mobileGetStartedOpened
    phoneLoginOpened = model.loginOpened
    par =
      if not phoneGetStartedViewOpened && not phoneLoginOpened then
        p [ class "responsiveHideMobile introInfoWidthResponsive", style [ ("position", "absolute"), ("bottom", "17vh"), ("left", "0"), ("font-size", "1em"), ("width", "90vw"), ("text-align", "left"), ("color", "gold"), ("padding-left", "2.8em")] ] [ text "Innovities is a social platform where innovative ideas are found by those who need them."]
      else
        p [] []
    defaultViewVisible =
      if (not model.mobileRegisterCompanyOpened) && (not model.mobileRegisterIdeaGeneratorOpened) then
        True
      else
        False

    mobileRegisterCompanyViewVisible = model.mobileRegisterCompanyOpened
    mobileRegisterIdeaGeneratorViewVisible = model.mobileRegisterIdeaGeneratorOpened

    mobileGeneralDefaultView =
      if model.mobileDefaultView then
        ("display", "initial")
      else
        ("display", "none")

    companyRegData = model.companyUnderRegistration
    companyRegError = companyRegData.registrationError

    innovatorRegData = model.innovatorUnderRegistration
    innovatorRegError = innovatorRegData.registrationError

    currentUser = model.loggedInMember
    loginPanelView =
      if (currentUser.id == 0) then
        div [ class "uk-width-1-3" ]
          [ if registerCompanyOpened then registerCompanyView model companyRegError
              else if registerIdeaGeneratorOpened then registerIdeaGeneratorView model innovatorRegError
              else defaultView model
          ]
      else
        div [ class "uk-width-1-3 responsiveVisibilityNotMobile" ]
          [ h4 [ style [("font-style", "italic"), ("color", "white")] ] [ text currentUser.email ]
          , a [ onClick OnSwitchToDashboard, style [("color", "orange")] ] [ text "Dashboard" ]
          ]

    mobileLoginPanelView =
      if (currentUser.id == 0) then
        phoneButtonsView model
      else
        div [ class "responsiveVisibilityMobile", style [("margin-left", "-25vw"), ("position", "absolute"), ("bottom", "10px")] ]
          [ h5 [ style [("font-style", "italic"), ("color", "white")] ] [ text currentUser.email ]
          , a [ onClick OnSwitchToDashboard, style [("color", "orange")] ] [ text "Dashboard" ]
          ]

  in
    div [ style [ mobileGeneralDefaultView ] ]
      [ div [ class "uk-flex uk-flex-middle" ]
        [ div [ class "uk-width-2-3" ]
          [ h1 [ class "responsiveHide marginTopResponsive headerInfoStyleResponsive", style [ ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "INNOVITIES WE TRUST" ]
          , if (phoneLoginOpened || mobileRegisterCompanyViewVisible || mobileRegisterIdeaGeneratorViewVisible) then span [][] else h1 [ class "responsiveHideMobile marginTopResponsive headerInfoStyleResponsive", style [ ("font-weight", "bold"), ("text-align", "left"), ("padding-left", "0.5em"), ("padding-top", "0.5em") ] ] [ text "INNOVITIES WE TRUST" ]
          , par
          , p [ class "responsiveHide introInfoWidthResponsive", style [ ("font-size", "1em"), ("text-align", "left"), ("color", "gold"), ("padding-left", "2.8em")] ] [ text (LL.getLocal "Innovities is a social platform where innovative ideas are found by those who need them." model) ]
          ]
        , loginPanelView
        ]
      , if (defaultViewVisible) then
          mobileLoginPanelView
        else if mobileRegisterCompanyViewVisible then
          registerCompanyMobileView model companyRegError
        else if mobileRegisterIdeaGeneratorViewVisible then
          registerIdeaGeneratorMobileView model innovatorRegError
        else
          p[][]
      ]


phoneButtonsView : Model -> Html Msg
phoneButtonsView model =
  let
    getStartedOpened = model.mobileGetStartedOpened
    getStartedButtonStyle =
      if getStartedOpened then
        style [("background", "grey"), ("margin-top", "15vh")]
      else
        style [("background", "orange")]

    loginOpened = model.loginOpened
  in
    div [ class "responsiveVisibilityStyle uk-flex uk-flex-column", style [("width", "80vw"), ("margin-left", "8vw"), ("position", "absolute"), ("bottom", "10px")] ]
      [ if loginOpened then div [][] else button [ style [("border", "none"), ("font-size", "110%")], onClick OnMobileGetStartedViewOpen, class "uk-margin-small-right uk-margin-small-bottom startButtonsStyle", getStartedButtonStyle ] [ text (LL.getLocal "GET STARTED!" model) ]
      , if getStartedOpened && (not loginOpened) then getStartedMobileView model else span [][]
      , if loginOpened then loginViewMobile model else button [ style [("border", "none"), ("font-size", "110%")], onClick OnLoginButtonSwitch, class "uk-margin-small-right startButtonsStyle", style [("background", "cornflowerblue")] ] [ text (LL.getLocal "LOG IN" model) ]
      ]


registerCompanyView : Model -> String -> Html Msg
registerCompanyView model registerError =
  div []
    [ img [ style [("width", "12%"), ("height", "20%")], src "/images/case.png" ] []
    , p [ style [("font-size", "small"), ("margin-top", "3%")] ] [ text (LL.getLocal "Company" model) ]
    , div [ class "uk-flex uk-child-width-1-2" ]
      [ div []
        [ input [ onInput OnCompanyRegistrationNameInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "Company Name" model) ] []
        , input [ onInput OnCompanyRegistrationPasswordInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", placeholder (LL.getLocal "Password" model) ] []
        ]
      , div []
        [ input [ onInput OnCompanyRegistrationEmailInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "E-mail" model) ] []
        , select [ onInput OnCompanyRegistrationCountryInput, style [("color", "cornflowerblue"), ("padding", "0.2em"), ("width", "90%")], class "uk-margin-small-top" ] ( countriesOptionsListMobile model )
        ]
      ]
    , label [ onClick OnCompanyRegistrationTSAgreementCheck, class "uk-margin-small-top", style [("margin-left", "1em"), ("font-size", "80%"), ("color", "gold")] ]
      [ input [ type_ "checkbox", style [("margin-right", "0.3em")] ] []
      , span [ onClick OnCompanyRegistrationTSAgreementCheck ] [ text (LL.getLocal "I agree to the Terms of Service and understand the Privacy statement." model) ]
      ]
    , label [ onClick OnCompanyRegistrationReceiveNewletterCheck, style [("font-size", "80%"), ("color", "gold"), ("margin-right", "5.5em")] ]
      [ input [ type_ "checkbox", style [("margin-right", "0.3em")] ] []
      , span [ onClick OnCompanyRegistrationReceiveNewletterCheck ] [ text "Please email me your free weekly Innovation Newsletter." ]
      ]
    , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-0.3em"), ("margin-bottom", "-0.3em")] ] [ text registerError ]
    , button [ onClick OnCompanyRegistrationSubmit, class "subscribeButtonStyle uk-margin-small-top", style [("padding", "2.5em"), ("padding-top", "0.3em"), ("padding-bottom", "0.3em")] ] [ text (LL.getLocal "Sign-Up" model) ]
    --, p [ style [("font-size", "small")] ] [ text "OR CONNECT WITH" ]
    --, img [ style [("margin-right", "0.8em"), ("width", "2.5em"), ("height", "2.5em")], src "/images/facebook_trans_icon.png" ] []
    --, img [ style [("width", "2.5em"), ("height", "2.5em")], src "/images/google_plus_trans_icon.png" ] []
    ]

registerCompanyMobileView : Model -> String -> Html Msg
registerCompanyMobileView model registerError =
  let
    currentCompany = model.companyUnderRegistration

    tsChecked =
      if currentCompany.termsOfServiceAgreemant then
        attribute "checked" "checked"
      else
        attribute "unchecked" ""

    receiveNL =
      if currentCompany.receiveNewsletterAgreement then
        attribute "checked" "checked"
      else
        attribute "unchecked" ""
  in
    div [ class "uk-flex", style [("position", "absolute"), ("bottom", "10px")] ]
      [ div [ class "uk-width-1-5 uk-margin-medium-top" ]
        [ img [ style [("width", "28%"), ("height", "16%")], src "/images/case.png" ] []
        , p [ style [("font-size", "small"), ("margin-top", "3%")] ] [ text (LL.getLocal "Company" model) ]
        ]
      , div [ class "uk-flex uk-flex-column uk-width-3-5 uk-margin-small-right" ]
        [ input [ onInput OnCompanyRegistrationNameInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "Company Name" model), value currentCompany.name ] []
        , input [ onInput OnCompanyRegistrationPasswordInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", placeholder (LL.getLocal "Password" model), value currentCompany.password ] []
        , input [ onInput OnCompanyRegistrationEmailInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "E-mail" model), class "uk-margin-small-top", value currentCompany.email ] []
        , select [ onInput OnCompanyRegistrationCountryInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", value currentCompany.country ] ( countriesOptionsListMobile model )
        , label [ onClick OnCompanyRegistrationTSAgreementCheck, class "uk-margin-small-top", style [("font-size", "80%"), ("color", "gold")] ]
          [ input [ type_ "checkbox", style [("margin-right", "0.3em")], tsChecked ] []
          , span [ onClick OnCompanyRegistrationTSAgreementCheck ] [ text (LL.getLocal "I agree to the Terms of Service and understand the Privacy statement." model) ]
          ]
        , label [ onClick OnCompanyRegistrationReceiveNewletterCheck, style [("margin-left", "0"), ("padding-left", "0"), ("font-size", "80%"), ("color", "gold")] ]
          [ input [ type_ "checkbox", style [("margin-right", "0.3em")], receiveNL ] []
          , span [ onClick OnCompanyRegistrationReceiveNewletterCheck ] [ text "Please email me your free weekly Innovation Newsletter." ]
          ]
        , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-0.3em"), ("margin-bottom", "-0.3em")] ] [ text registerError ]
        , div [ class "uk-flex uk-margin-small-top" ]
          [ button [ onClick OnCompanyRegistrationSubmitMobile, class "uk-width-2-3 subscribeButtonStyle", style [("font-size", "90%"), ("margin-right", "0.3em"), ("padding", "2.5em"), ("padding-top", "0.3em"), ("padding-bottom", "0.3em")] ] [ text (LL.getLocal "Sign-Up" model) ]
          --, div [ class "uk-flex uk-flex-column", style [("margin-top", "1em"), ("margin-left", "0.3em")] ]
            --[ div [ class "uk-flex" ]
              --[ img [ style [("margin-left", "0.5em"), ("margin-right", "0.8em"), ("width", "2em"), ("height", "2em")], src "/images/facebook_trans_icon.png" ] []
              --, img [ style [("width", "2em"), ("height", "2em")], src "/images/google_plus_trans_icon.png" ] []
              --]
            --, p [ style [("font-size", "70%"), ("margin-top", "-0.2em")] ] [ text "OR CONNECT WITH" ]
            --]
          ]
        ]
      ]


countriesOptionsListMobile : Model -> List (Html Msg)
countriesOptionsListMobile model =
  let
    lang = model.language

    countries =
      case lang of
        Models.Eng -> CL.countries
        Models.Arm -> CL.countriesArmSorted
  in
    List.map (countriesOptionItemMobile model) countries


countriesOptionItemMobile : Model -> String -> Html Msg
countriesOptionItemMobile model country =
  let
    lang = model.language

    val =
      case lang of
        Models.Eng -> country
        Models.Arm -> getEngLocal country
  in
    option [ value val ] [ text country ]


registerIdeaGeneratorView : Model -> String -> Html Msg
registerIdeaGeneratorView model registerError =
  div []
    [ img [ style [("width", "8%"), ("height", "16%")], src "/images/head.png" ] []
    , p [ style [("font-size", "small"), ("margin-top", "3%")] ] [ text (LL.getLocal "Idea Generator" model) ]
    , div [ class "uk-flex uk-child-width-1-2" ]
      [ div []
        [ input [ onInput OnInnovatorRegistrationNameInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "Name Surname" model) ] []
        , input [ onInput OnInnovatorRegistrationPasswordInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", placeholder (LL.getLocal "Password" model) ] []
        ]
      , div []
        [ input [ onInput OnInnovatorRegistrationEmailInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "E-mail" model) ] []
        , select [ onInput OnInnovatorRegistrationCountryInput, style [("color", "cornflowerblue"), ("padding", "0.2em"), ("width", "90%")], class "uk-margin-small-top" ] ( countriesOptionsListMobile model )
        ]
      ]
    , label [ onClick OnInnovatorRegistrationTSAgreementCheck, class "uk-margin-small-top", style [("margin-left", "1em"), ("font-size", "80%"), ("color", "gold")] ]
      [ input [ type_ "checkbox", style [("margin-right", "0.3em")] ] []
      , span [ onClick OnInnovatorRegistrationTSAgreementCheck ] [ text (LL.getLocal "I agree to the Terms of Service and understand the Privacy statement." model) ]
      ]
    , label [ onClick OnInnovatorRegistrationReceiveNewletterCheck, style [("font-size", "80%"), ("color", "gold"), ("margin-right", "5.5em")] ]
      [ input [ type_ "checkbox", style [("margin-right", "0.3em")] ] []
      , span [ onClick OnInnovatorRegistrationReceiveNewletterCheck ] [ text "Please email me your free weekly Innovation Newsletter." ]
      ]
    , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-0.3em"), ("margin-bottom", "-0.3em")] ] [ text registerError ]
    , button [ onClick OnInnovatorRegistrationSubmit, class "subscribeButtonStyle uk-margin-small-top", style [("padding", "2.5em"), ("padding-top", "0.3em"), ("padding-bottom", "0.3em")] ] [ text (LL.getLocal "Sign-Up" model) ]
    --, p [ style [("font-size", "small")] ] [ text "OR CONNECT WITH" ]
    --, img [ style [("margin-right", "0.8em"), ("width", "2.5em"), ("height", "2.5em")], src "/images/facebook_trans_icon.png" ] []
    --, img [ style [("width", "2.5em"), ("height", "2.5em")], src "/images/google_plus_trans_icon.png" ] []
    ]

registerIdeaGeneratorMobileView : Model -> String -> Html Msg
registerIdeaGeneratorMobileView model registerError =
  let
    currentInnovator = model.innovatorUnderRegistration

    tsChecked =
      if currentInnovator.termsOfServiceAgreemant then
        attribute "checked" "checked"
      else
        attribute "unchecked" ""

    receiveNL =
      if currentInnovator.receiveNewsletterAgreement then
        attribute "checked" "checked"
      else
        attribute "unchecked" ""
  in
    div [ class "uk-flex", style [("position", "absolute"), ("bottom", "10px")] ]
      [ div [ class "uk-width-1-5 uk-margin-medium-top", style [("margin-right", "0.3em")] ]
        [ img [ style [("width", "28%"), ("height", "16%")], src "/images/head.png" ] []
        , p [ style [("font-size", "80%"), ("margin-top", "3%")] ] [ text (LL.getLocal "Idea Generator" model) ]
        ]
      , div [ class "uk-flex uk-flex-column uk-width-3-5 uk-margin-small-right" ]
        [ input [ onInput OnInnovatorRegistrationNameInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "Name Surname" model), value currentInnovator.full_name ] []
        , input [ onInput OnInnovatorRegistrationPasswordInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", placeholder (LL.getLocal "Password" model), value currentInnovator.password ] []
        , input [ onInput OnInnovatorRegistrationEmailInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], placeholder (LL.getLocal "E-mail" model), class "uk-margin-small-top", value currentInnovator.email ] []
        , select [ onInput OnInnovatorRegistrationCountryInput, style [("color", "cornflowerblue"), ("padding", "0.2em")], class "uk-margin-small-top", value currentInnovator.country ] ( countriesOptionsListMobile model )
        , label [ onClick OnInnovatorRegistrationTSAgreementCheck, class "uk-margin-small-top", style [("font-size", "80%"), ("color", "gold")] ]
          [ input [ type_ "checkbox", style [("float", "left"), ("margin-right", "0.3em")], tsChecked ] []
          , span [ onClick OnInnovatorRegistrationTSAgreementCheck, style [("float", "left")] ] [ text (LL.getLocal "I agree to the Terms of Service and understand the Privacy statement." model) ]
          ]
        , label [ onClick OnInnovatorRegistrationReceiveNewletterCheck, style [("font-size", "80%"), ("color", "gold")] ]
          [ input [ type_ "checkbox", style [("float", "left"), ("margin-right", "0.3em")], receiveNL ] []
          , span [ onClick OnInnovatorRegistrationReceiveNewletterCheck, style [("margin-top", "0.5em"), ("float", "left")] ] [ text "Please email me your free weekly Innovation Newsletter." ]
          ]
        , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-0.3em"), ("margin-bottom", "-0.3em")] ] [ text registerError ]
        , div [ class "uk-flex uk-margin-small-top" ]
          [ button [ onClick OnInnovatorRegistrationSubmitMobile, class "uk-width-2-3 subscribeButtonStyle", style [("font-size", "90%"), ("margin-right", "0.3em"), ("padding", "2.5em"), ("padding-top", "0.3em"), ("padding-bottom", "0.3em")] ] [ text (LL.getLocal "Sign-Up" model) ]
          --, div [ class "uk-flex uk-flex-column", style [("margin-top", "1em"), ("margin-left", "0.3em")] ]
            --[ div [ class "uk-flex" ]
              --[ img [ style [("margin-left", "0.5em"), ("margin-right", "0.8em"), ("width", "2em"), ("height", "2em")], src "/images/facebook_trans_icon.png" ] []
              --, img [ style [("width", "2em"), ("height", "2em")], src "/images/google_plus_trans_icon.png" ] []
              --]
            --, p [ style [("font-size", "70%"), ("margin-top", "-0.2em")] ] [ text "OR CONNECT WITH" ]
            --]
          ]
        ]
      ]

defaultView : Model -> Html Msg
defaultView model =
  let
    getStartedOpened = model.getStartedOpened
    getStartedButtonStyle =
      if getStartedOpened then
        style [("background", "grey")]
      else
        style [("background", "orange")]

    loginOpened = model.loginOpened
  in
    div [ class "responsiveVisibilityStyleInverse" ]
      [ if loginOpened then div[][] else button [ onClick OnGetStartedButtonsSwitch, class "startButtonsStyle", getStartedButtonStyle ] [ text (LL.getLocal "GET STARTED!" model) ]
      , if getStartedOpened && (not loginOpened) then getStartedView model else br[][], br[][]
      , if loginOpened then loginView model else button [ onClick OnLoginButtonSwitch, class "startButtonsStyle", style [("background", "cornflowerblue")] ] [ text (LL.getLocal "LOG IN" model) ]
      ]


loginView : Model -> Html Msg
loginView model =
  let
    loggingInData = model.loggingInMember
    loggingInError = loggingInData.loginError
  in
    div []
      [ input [ onInput OnLoggingInMemberUsernameInput, style [("color", "cornflowerblue"), ("padding", "0.5em")], placeholder (LL.getLocal "Username" model) ] []
      , br[][]
      , input [ onInput OnLoggingInMemberPasswordInput, style [("margin-top", "0.3em"), ("color", "cornflowerblue"), ("padding", "0.5em")], placeholder (LL.getLocal "Password" model) ] []
      , br[][], br[][]
      , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-1em"), ("margin-bottom", "-0.1em")] ] [ text loggingInError ]
      , button [ onClick OnLoggingInMemberLogin, class "startButtonsStyle", style [("border", "none"), ("margin-left", "2em"), ("width", "10em"), ("background", "cornflowerblue")] ] [ text (LL.getLocal "LOG IN" model) ]
      --, p [ style [("font-size", "small"), ("margin-left", "3.8em"), ("margin-top", "2em")] ] [ text "OR CONNECT WITH" ]
      --, img [ style [("margin-left", "7em"), ("margin-right", "0.8em"), ("width", "2.5em"), ("height", "2.5em")], src "/images/facebook_icon.png" ] []
      --, img [ style [("width", "2.5em"), ("height", "2.5em")], src "/images/linkedin_icon.png" ] []
      ]

loginViewMobile : Model -> Html Msg
loginViewMobile model =
  let
    loggingInData = model.loggingInMember
    loggingInError = loggingInData.loginError
  in
    div [ style [("position", "absolute"), ("bottom", "60px")] ]
      [ input [ onInput OnLoggingInMemberUsernameInput, style [("width", "80vw"), ("margin-bottom", "1em"), ("color", "cornflowerblue")], placeholder (LL.getLocal "Username" model) ] []
      , input [ onInput OnLoggingInMemberPasswordInput, style [("width", "80vw"), ("margin-top", "0.3em"), ("color", "cornflowerblue")], placeholder (LL.getLocal "Password" model) ] []
      , br[][], br[][]
      , p [ style [("color", "red"), ("font-size", "110%"), ("margin-top", "-1em"), ("margin-bottom", "-0.1em")] ] [ text loggingInError ]
      , button [ onClick OnLoggingInMemberLogin, class "startButtonsStyle", style [("margin-left", "4vw"), ("border", "none"), ("width", "10em"), ("background", "cornflowerblue")] ] [ text (LL.getLocal "LOG IN" model) ]
      --, p [ style [("margin-left", "4vw"), ("font-size", "70%"), ("margin-top", "2em")] ] [ text "OR CONNECT WITH" ]
      --, img [ style [("margin-left", "4vw"), ("margin-right", "0.8em"), ("width", "2.5em"), ("height", "2.5em")], src "/images/facebook_icon.png" ] []
      --, img [ style [("width", "2.5em"), ("height", "2.5em")], src "/images/linkedin_icon.png" ] []
      ]


getStartedView : Model -> Html Msg
getStartedView model =
  div [ class "uk-flex uk-flex-center" ]
    [ a [ onClick OnIdeaGeneratorRegistrationOpen, class "uk-width-1-4", style [("margin-left", "1.5em")] ]
      [ div []
        [ img [ style [("width", "20%"), ("height", "40%"), ("margin-top", "10%")], src "/images/head.png" ] []
        , p [ style [("font-size", "small")] ] [ text (LL.getLocal "Idea Generator" model) ]
        ]
      ]
    , a [ onClick OnCompanyRegistrationOpen, class "uk-width-1-4", style [("margin-left", "1.5em")] ]
      [ div []
        [ img [ style [("width", "24%"), ("height", "40%"), ("margin-top", "21%")], src "/images/case.png" ] []
        , p [ style [("font-size", "small") ] ] [ text (LL.getLocal "Company" model) ]
        ]
      ]
    ]

getStartedMobileView : Model -> Html Msg
getStartedMobileView model =
  div [ class "uk-flex uk-flex-center" ]
    [ a [ onClick OnMobileRegisterIdeaGeneratorViewOpen, class "uk-width-1-4", style [("margin-left", "1.5em")] ]
      [ div []
        [ img [ style [("width", "20%"), ("height", "40%"), ("margin-top", "10%")], src "/images/head.png" ] []
        , p [ style [("font-size", "small")] ] [ text (LL.getLocal "Idea Generator" model) ]
        ]
      ]
    , a [ onClick OnMobileRegisterCompanyViewOpen, class "uk-width-1-4", style [("margin-left", "1.5em")] ]
      [ div []
        [ img [ style [("width", "24%"), ("height", "40%"), ("margin-top", "21%")], src "/images/case.png" ] []
        , p [ style [("font-size", "small") ] ] [ text (LL.getLocal "Company" model) ]
        ]
      ]
    ]
