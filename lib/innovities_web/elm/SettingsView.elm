module SettingsView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



dashboardSettingsPageView : Model -> Html Msg
dashboardSettingsPageView model =
  let
    fieldsEditable = model.innovatorSettingsFieldsEditable

    settingsFieldsForInput = model.innovatorSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")

  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body" ]
        [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "General Account Settings" ]
        , br[][]
        , settingsItem "Username" settingsFieldsForInput.username OnSettingsUsernameEditable fieldsEditable.username OnInnovatorSettingsUsernameInput
        , settingsItem "Name" settingsFieldsForInput.name OnSettingsNameEditable fieldsEditable.name OnInnovatorSettingsNameInput
        , settingsItem "Surname" settingsFieldsForInput.surname OnSettingsSurnameEditable fieldsEditable.surname OnInnovatorSettingsSurnameInput
        , div [ style [("width", "100%")], class "uk-flex uk-child-width-1-3" ]
          [ span [ style [("text-align", "left"), ("color", "black")] ] [ text "Photo" ]
          , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "center"), ("color", "grey"), ("border", "none")] ] []
          , a [ style [("text-align", "right"), ("color", "gold")] ]
            [ label [ style [("font-weight", "normal")], for "innovator-pic" ] [ text "browse" ]
            , input [ id "innovator-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
            ]
          ]
        , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
        , settingsItem "Phone number" settingsFieldsForInput.phone OnSettingsPhoneEditable fieldsEditable.phone OnInnovatorSettingsPhoneInput
        , settingsItem "E-mail address" settingsFieldsForInput.email OnSettingsEmailEditable fieldsEditable.email OnInnovatorSettingsEmailInput
        , settingsItem "About Me" settingsFieldsForInput.about_me OnSettingsAboutEditable fieldsEditable.about OnInnovatorSettingsAboutInput
        , settingsItem "Education" settingsFieldsForInput.education OnSettingsEducationEditable fieldsEditable.education OnInnovatorSettingsEducationInput
        , settingsItem "Experience" settingsFieldsForInput.experience OnSettingsExperienceEditable fieldsEditable.experience OnInnovatorSettingsExperienceInput
        , settingsItem "Country" settingsFieldsForInput.country OnSettingsCountryEditable fieldsEditable.country OnInnovatorSettingsCountryInput
        , settingsItem "Change Password" settingsFieldsForInput.changePassword OnSettingsChangePasswordEditable fieldsEditable.changePassword OnInnovatorSettingsChangePasswordInput
        , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
        , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
        , br[][], br[][], br[][]
        , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
        , button [ onClick OnInnovatorSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
        ]
      ]


dashboardOrganizationSettingsPageView : Model -> Html Msg
dashboardOrganizationSettingsPageView model =
  let
    fieldsEditable = model.organizationSettingsFieldsEditable

    settingsFieldsForInput = model.organizationSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")
  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "General Account Settings" ]
      , br[][]
      , settingsItem "Username" settingsFieldsForInput.username OnOrgSettingsUsernameEditable fieldsEditable.username OnOrganizationSettingsUsernameInput
      , settingsItem "Name" settingsFieldsForInput.name OnOrgSettingsNameEditable fieldsEditable.name OnOrganizationSettingsNameInput
      , div [ style [("width", "100%")], class "uk-flex uk-child-width-1-3" ]
        [ span [ style [("text-align", "left"), ("color", "black")] ] [ text "Photo" ]
        , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "center"), ("color", "grey"), ("border", "none")] ] []
        , a [ style [("text-align", "right"), ("color", "gold")] ]
          [ label [ style [("font-weight", "normal")], for "organization-pic" ] [ text "browse" ]
          , input [ id "organization-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
          ]
        ]
      , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
      , settingsItem "Phone number" settingsFieldsForInput.phone OnOrgSettingsPhoneEditable fieldsEditable.phone OnOrganizationSettingsPhoneInput
      , settingsItem "E-mail address" settingsFieldsForInput.email OnOrgSettingsEmailEditable fieldsEditable.email OnOrganizationSettingsEmailInput
      , settingsItem "Webpage" settingsFieldsForInput.webpage OnOrgSettingsWebpageEditable fieldsEditable.webpage OnOrganizationSettingsWebpageInput
      , settingsItem "About Us" settingsFieldsForInput.about_us OnOrgSettingsAboutEditable fieldsEditable.about_us OnOrganizationSettingsAboutInput
      , settingsItem "Description" settingsFieldsForInput.description OnOrgSettingsDescriptionEditable fieldsEditable.description OnOrganizationSettingsDescriptionInput
      , settingsItem "Industry" settingsFieldsForInput.industry OnOrgSettingsIndustryEditable fieldsEditable.industry OnOrganizationSettingsIndustryInput
      , settingsItem "Interested Industries" settingsFieldsForInput.interested_industries OnOrgSettingsInterestedIndustriesEditable fieldsEditable.interested_industries OnOrganizationSettingsInterestedIndustriesInput
      , settingsItem "Country" settingsFieldsForInput.country OnOrgSettingsCountryEditable fieldsEditable.country OnOrganizationSettingsCountryInput
      , settingsItem "Change Password" settingsFieldsForInput.changePassword OnOrgSettingsChangePasswordEditable fieldsEditable.changePassword OnOrganizationSettingsChangePasswordInput
      , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
      , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
      , br[][], br[][], br[][]
      , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
      , button [ onClick OnOrganizationSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
      ]
    ]


settingsItem : String -> String -> Msg -> Bool -> (String -> Msg) -> Html Msg
settingsItem label val onClickMsg editable onInputMsg =
  let
    inputBorder =
      if editable then
        ("border", "1px solid skyblue")
      else
        ("border", "none")

    inputDisabled =
      if editable then
        attribute "enabled" ""
      else
        attribute "disabled" ""
  in
    div [ style [("width", "100%")] ]
    [ div [ style [("width", "100%")], class "uk-flex uk-child-width-1-3" ]
      [ span [ style [("text-align", "left"), ("color", "black")] ] [ text label ]
      , input [ onInput onInputMsg, inputDisabled, style [("background", "white"), ("text-align", "center"), ("color", "grey"), inputBorder], value val ] []
      , a [ onClick onClickMsg, style [("text-align", "right"), ("color", "gold")] ] [ text "edit" ]
      ]
    , img [ style [("margin-top", "-1em"), ("margin-bottom", "-0.7em")], src "/images/grey_divider.png" ] []
    ]


dashboardTariffPlansPageView : Model -> Html Msg
dashboardTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "3,790"
        Models.Eng -> "8"

    by =
      case lang of
        Models.Arm -> "42,590"
        Models.Eng -> "88"

    bs =
      case lang of
        Models.Arm -> "2,890"
        Models.Eng -> "8"

    pm =
      case lang of
        Models.Arm -> "6,690"
        Models.Eng -> "14"

    py =
      case lang of
        Models.Arm -> "76,590"
        Models.Eng -> "158"

    ps =
      case lang of
        Models.Arm -> "3,690"
        Models.Eng -> "10"

    pmm =
      case lang of
        Models.Arm -> "10,090"
        Models.Eng -> "21"

    pmy =
      case lang of
        Models.Arm -> "115,390"
        Models.Eng -> "238"

    pms =
      case lang of
        Models.Arm -> "5,690"
        Models.Eng -> "14"
  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , div [ class "uk-flex", style [("width", "100%")] ]
        [ span [ style [("width", "10%"), ("color", "grey")] ] [ text "" ]
        , span [ style [("width", "10%"), ("color", "grey")] ] [ text "Ideas" ]
        , span [ style [("width", "25%"), ("color", "grey")] ] [ text "Connect to" ]
        , span [ style [("width", "25%"), ("color", "grey")] ] [ text "Region" ]
        , span [ style [("width", "30%"), ("color", "grey")] ] [ text "Price" ]
        ]
      , img [ style [("margin-top", "-1em"), ("margin-bottom", "-0.7em")], src "/images/grey_divider.png" ] []
      , div [ class "uk-flex", style [("width", "100%")] ]
        [ a [ onClick (OnSelectTariffPlan "Free"), style [("width", "10%"), ("text-align", "left")] ] [ span [ style [("width", "10%"), ("font-weight", "bold"), ("font-size", "90%"), ("color", "gold"), ("text-align", "left")] ] [ text "Free" ] ]
        , span [ style [("width", "10%"), ("font-size", "90%"), ("color", "black")] ] [ text "Up to 2" ]
        , span [ style [("width", "25%"), ("font-size", "90%"), ("color", "black")] ] [ text "1 organization" ]
        , span [ style [("width", "25%"), ("font-size", "90%"), ("color", "black")] ] [ text "Current Country" ]
        , span [ style [("width", "30%"), ("font-size", "90%"), ("color", "blue")] ] [ text "Free" ]
        ]
      , tariffPlanItem model "Basic" 3 "3 organizations" "Current Region" bm by bs
      , tariffPlanItem model "Plus" 6 "5 organizations" "Current Continent" pm py ps
      , tariffPlanItem model "Premium" 8 "8 organizations" "Worldwide" pmm pmy pms
      ]
    , p [ style [("color", "red"), ("font-size", "100%")] ] [ text model.tariffPlanSubError ]
    ]


tariffPlanItem : Model -> String -> Int -> String -> String -> String -> String -> String -> Html Msg
tariffPlanItem model name ideasCount connectToOrgsCount region priceMth priceYear discount =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "ամիս / "
        Models.Eng -> "mth / "

    year =
      case lang of
        Models.Arm -> "տարի "
        Models.Eng -> "yr "

    save =
      case lang of
        Models.Arm -> " խնայեք D "
        Models.Eng -> " save $"
  in
    div [ style [("width", "100%")] ]
    [ img [ style [("margin-top", "-1em"), ("margin-bottom", "-0.7em")], src "/images/grey_divider.png" ] []
    , div [ class "uk-flex", style [("width", "100%")] ]
      [ a [ onClick (OnSelectTariffPlan name), style [("width", "10%"), ("text-align", "left")] ] [ span [ style [("font-weight", "bold"), ("width", "10%"), ("font-size", "90%"), ("color", "gold"), ("text-align", "left")] ] [ text name ] ]
      , span [ style [("width", "10%"), ("font-size", "90%"), ("color", "black")] ] [ text ("Up to " ++ (toString ideasCount)) ]
      , span [ style [("width", "25%"), ("font-size", "90%"), ("color", "black")] ] [ text connectToOrgsCount ]
      , span [ style [("width", "25%"), ("font-size", "90%"), ("color", "black")] ] [ text region ]
      , span [ style [("width", "30%"), ("font-size", "90%"), ("color", "blue")] ] [ text (currency ++ priceMth ++ month ++ currency ++ priceYear ++ year), span [ style [("color", "gold")] ] [ text (save ++ discount) ] ]
      ]
    ]



dashboardOrganizationTariffPlansPageView : Model -> Html Msg
dashboardOrganizationTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "23,190"
        Models.Eng -> "48"

    by =
      case lang of
        Models.Arm -> "265,690"
        Models.Eng -> "548"

    bs =
      case lang of
        Models.Arm -> "12,590"
        Models.Eng -> "28"

    pm =
      case lang of
        Models.Arm -> "36,790"
        Models.Eng -> "76"

    py =
      case lang of
        Models.Arm -> "418,090"
        Models.Eng -> "864"

    ps =
      case lang of
        Models.Arm -> "23,390"
        Models.Eng -> "48"

    pmm =
      case lang of
        Models.Arm -> "61,990"
        Models.Eng -> "128"

    pmy =
      case lang of
        Models.Arm -> "715,290"
        Models.Eng -> "1475"

    pms =
      case lang of
        Models.Arm -> "28,590"
        Models.Eng -> "61"

    mm =
      case lang of
        Models.Arm -> "104,690"
        Models.Eng -> "216"

    my =
      case lang of
        Models.Arm -> "1,210,490"
        Models.Eng -> "2496"

    ms =
      case lang of
        Models.Arm -> "45,790"
        Models.Eng -> "96"
  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("float", "left"), ("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , div [ class "uk-flex", style [("width", "100%")] ]
        [ span [ style [("width", "10%"), ("color", "grey")] ] [ text "" ]
        , span [ style [("width", "10%"), ("color", "grey")] ] [ text "Ideas" ]
        , span [ style [("width", "25%"), ("color", "grey")] ] [ text "Connect to" ]
        , span [ style [("width", "25%"), ("color", "grey")] ] [ text "Region" ]
        , span [ style [("width", "30%"), ("color", "grey")] ] [ text "Price" ]
        ]
      , tariffPlanItem model "Basic" 5 "15 idea generators" "Current country" bm by bs
      , tariffPlanItem model "Plus" 10 "30 idea generators" "Current region" pm py ps
      , tariffPlanItem model "Premium" 20 "50 idea generators" "Current continent" pmm pmy pms
      , tariffPlanItem model "Max" 50 "Unlimited" "Worldwide" mm my ms
      ]
    ]


-- TAB


tabDashboardSettingsPageView : Model -> Html Msg
tabDashboardSettingsPageView model =
  let
    currentUser = model.loggedInMember
    mainPage =
      if (model.desktopPage == Models.TariffPlansPage) then
        if currentUser.isOrganization then tabOrganizationTariffPlansPageView model else tabInnovatorTariffPlansPageView model
      else if (model.desktopPage == Models.SettingsPage) then
        if currentUser.isOrganization then tabDashboardOrganizationSettingsPageView model else tabDashboardInnovatorSettingsPageView model
      else
        span[][]

  in
    mainPage


tabOrganizationTariffPlansPageView : Model -> Html Msg
tabOrganizationTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "23,190"
        Models.Eng -> "48"

    by =
      case lang of
        Models.Arm -> "265,690"
        Models.Eng -> "548"

    bs =
      case lang of
        Models.Arm -> "12,590"
        Models.Eng -> "28"

    pm =
      case lang of
        Models.Arm -> "36,790"
        Models.Eng -> "76"

    py =
      case lang of
        Models.Arm -> "418,090"
        Models.Eng -> "864"

    ps =
      case lang of
        Models.Arm -> "23,390"
        Models.Eng -> "48"

    pmm =
      case lang of
        Models.Arm -> "61,990"
        Models.Eng -> "128"

    pmy =
      case lang of
        Models.Arm -> "715,290"
        Models.Eng -> "1475"

    pms =
      case lang of
        Models.Arm -> "28,590"
        Models.Eng -> "61"

    mm =
      case lang of
        Models.Arm -> "104,690"
        Models.Eng -> "216"

    my =
      case lang of
        Models.Arm -> "1,210,490"
        Models.Eng -> "2496"

    ms =
      case lang of
        Models.Arm -> "45,790"
        Models.Eng -> "96"
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "10vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ tabTariffPlanItem model "Basic" 5 "15 idea generators" "Current country" bm by bs
        , tabTariffPlanItem model "Plus" 10 "30 idea generators" "Current region" pm py ps
        ]
      , br[][], br[][], br[][]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ tabTariffPlanItem model "Premium" 20 "50 idea generators" "Current continent" pmm pmy pms
        , tabTariffPlanItem model "Max" 50 "Unlimited" "Worldwide" mm my ms
        ]
      ]
    ]



tabInnovatorTariffPlansPageView : Model -> Html Msg
tabInnovatorTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "3,790"
        Models.Eng -> "8"

    by =
      case lang of
        Models.Arm -> "42,590"
        Models.Eng -> "88"

    bs =
      case lang of
        Models.Arm -> "2,890"
        Models.Eng -> "8"

    pm =
      case lang of
        Models.Arm -> "6,690"
        Models.Eng -> "14"

    py =
      case lang of
        Models.Arm -> "76,590"
        Models.Eng -> "158"

    ps =
      case lang of
        Models.Arm -> "3,690"
        Models.Eng -> "10"

    pmm =
      case lang of
        Models.Arm -> "10,090"
        Models.Eng -> "21"

    pmy =
      case lang of
        Models.Arm -> "115,390"
        Models.Eng -> "238"

    pms =
      case lang of
        Models.Arm -> "5,690"
        Models.Eng -> "14"
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "10vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ div [ class "uk-flex-column" ]
          [ span [ style [("display", "block"), ("color", "gold"), ("font-weight", "bold")] ] [ text "Free" ]
          , span [ style [("display", "block"), ("color", "grey")] ] [ text "Ideas: ", span [ style [("color", "black")] ] [ text "Up to 2" ] ]
          , span [ style [("display", "block"), ("color", "grey")] ] [ text "Connect to: ", span [ style [("color", "black")] ] [ text "1 Organization" ] ]
          , span [ style [("display", "block"), ("color", "grey")] ] [ text "Region: ", span [ style [("color", "black")] ] [ text "Current Country" ] ]
          , span [ style [("display", "block"), ("color", "blue")] ] [ text "Free" ]
          , br[][]
          , button [ onClick (OnSelectTariffPlan "Free"), style [("font-weight", "bold"), ("font-size", "90%"), ("padding-left", "2em"), ("padding-right", "2em"), ("background", "white"), ("color", "black"), ("border", "2px solid gold")] ] [ text "Choose" ]
          ]
        , tabTariffPlanItem model "Basic" 3 "3 Organization" "Current Region" bm by bs
        ]
      , br[][], br[][], br[][]
      , div [ class "uk-flex uk-child-width-1-2" ]
        [ tabTariffPlanItem model "Plus" 6 "5 organizations" "Current Continent" pm py ps
        , tabTariffPlanItem model "Premium" 8 "8 organizations" "Worldwide" pmm pmy pms
        ]
      ]
    ]


tabTariffPlanItem : Model -> String -> Int -> String -> String -> String -> String -> String -> Html Msg
tabTariffPlanItem model name ideasCount connectToOrgsCount region priceMth priceYear discount =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> " ամիս / "
        Models.Eng -> " mth / "

    year =
      case lang of
        Models.Arm -> "տարի "
        Models.Eng -> "yr "

    save =
      case lang of
        Models.Arm -> " խնայեք D "
        Models.Eng -> " save $"
  in
    div [ class "uk-flex-column" ]
      [ span [ style [("display", "block"), ("color", "gold"), ("font-weight", "bold")] ] [ text name ]
      , span [ style [("display", "block"), ("color", "grey")] ] [ text "Ideas: ", span [ style [("color", "black")] ] [ text ("Up to " ++ toString(ideasCount)) ] ]
      , span [ style [("display", "block"), ("color", "grey")] ] [ text "Connect to: ", span [ style [("color", "black")] ] [ text connectToOrgsCount ] ]
      , span [ style [("display", "block"), ("color", "grey")] ] [ text "Region: ", span [ style [("color", "black")] ] [ text region ] ]
      , span [ style [("display", "block"), ("color", "blue")] ] [ text (currency ++ priceMth ++ month ++ currency ++ priceYear ++ year), span [ style [("color", "gold")] ] [ text (save ++ discount) ] ]
      , br[][]
      , button [ onClick (OnSelectTariffPlan name), style [("font-weight", "bold"), ("font-size", "90%"), ("padding-left", "2em"), ("padding-right", "2em"), ("background", "white"), ("color", "black"), ("border", "2px solid gold")] ] [ text "Choose" ]
      ]


tabDashboardOrganizationSettingsPageView : Model -> Html Msg
tabDashboardOrganizationSettingsPageView model =
  let
    fieldsEditable = model.organizationSettingsFieldsEditable

    settingsFieldsForInput = model.organizationSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "10vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "General Account Settings" ]
      , br[][]
      , settingsItem "Username" settingsFieldsForInput.username OnOrgSettingsUsernameEditable fieldsEditable.username OnOrganizationSettingsUsernameInput
      , settingsItem "Name" settingsFieldsForInput.name OnOrgSettingsNameEditable fieldsEditable.name OnOrganizationSettingsNameInput
      , div [ style [("width", "100%")], class "uk-flex uk-child-width-1-3" ]
        [ span [ style [("text-align", "left"), ("color", "black")] ] [ text "Photo" ]
        , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "center"), ("color", "grey"), ("border", "none")] ] []
        , a [ style [("text-align", "right"), ("color", "gold")] ]
          [ label [ style [("font-weight", "normal")], for "organization-pic" ] [ text "browse" ]
          , input [ id "organization-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
          ]
        ]
      , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
      , settingsItem "Phone number" settingsFieldsForInput.phone OnOrgSettingsPhoneEditable fieldsEditable.phone OnOrganizationSettingsPhoneInput
      , settingsItem "E-mail address" settingsFieldsForInput.email OnOrgSettingsEmailEditable fieldsEditable.email OnOrganizationSettingsEmailInput
      , settingsItem "Webpage" settingsFieldsForInput.webpage OnOrgSettingsWebpageEditable fieldsEditable.webpage OnOrganizationSettingsWebpageInput
      , settingsItem "About Us" settingsFieldsForInput.about_us OnOrgSettingsAboutEditable fieldsEditable.about_us OnOrganizationSettingsAboutInput
      , settingsItem "Description" settingsFieldsForInput.description OnOrgSettingsDescriptionEditable fieldsEditable.description OnOrganizationSettingsDescriptionInput
      , settingsItem "Industry" settingsFieldsForInput.industry OnOrgSettingsIndustryEditable fieldsEditable.industry OnOrganizationSettingsIndustryInput
      , settingsItem "Interested Industries" settingsFieldsForInput.interested_industries OnOrgSettingsInterestedIndustriesEditable fieldsEditable.interested_industries OnOrganizationSettingsInterestedIndustriesInput
      , settingsItem "Country" settingsFieldsForInput.country OnOrgSettingsCountryEditable fieldsEditable.country OnOrganizationSettingsCountryInput
      , settingsItem "Change Password" settingsFieldsForInput.changePassword OnOrgSettingsChangePasswordEditable fieldsEditable.changePassword OnOrganizationSettingsChangePasswordInput
      , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
      , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
      , br[][], br[][], br[][]
      , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
      , button [ onClick OnOrganizationSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
      ]
    ]



tabDashboardInnovatorSettingsPageView : Model -> Html Msg
tabDashboardInnovatorSettingsPageView model =
  let
    fieldsEditable = model.innovatorSettingsFieldsEditable

    settingsFieldsForInput = model.innovatorSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ style [("width", "80vw"), ("margin-left", "10vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
        [ h5 [ style [("color", "grey")] ] [ text "General Account Settings" ]
        , br[][]
        , settingsItem "Username" settingsFieldsForInput.username OnSettingsUsernameEditable fieldsEditable.username OnInnovatorSettingsUsernameInput
        , settingsItem "Name" settingsFieldsForInput.name OnSettingsNameEditable fieldsEditable.name OnInnovatorSettingsNameInput
        , settingsItem "Surname" settingsFieldsForInput.surname OnSettingsSurnameEditable fieldsEditable.surname OnInnovatorSettingsSurnameInput
        , div [ style [("width", "100%")], class "uk-flex uk-child-width-1-3" ]
          [ span [ style [("text-align", "left"), ("color", "black")] ] [ text "Photo" ]
          , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "center"), ("color", "grey"), ("border", "none")] ] []
          , a [ style [("text-align", "right"), ("color", "gold")] ]
            [ label [ style [("font-weight", "normal")], for "innovator-pic" ] [ text "browse" ]
            , input [ id "innovator-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
            ]
          ]
        , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
        , settingsItem "Phone number" settingsFieldsForInput.phone OnSettingsPhoneEditable fieldsEditable.phone OnInnovatorSettingsPhoneInput
        , settingsItem "E-mail address" settingsFieldsForInput.email OnSettingsEmailEditable fieldsEditable.email OnInnovatorSettingsEmailInput
        , settingsItem "About Me" settingsFieldsForInput.about_me OnSettingsAboutEditable fieldsEditable.about OnInnovatorSettingsAboutInput
        , settingsItem "Education" settingsFieldsForInput.education OnSettingsEducationEditable fieldsEditable.education OnInnovatorSettingsEducationInput
        , settingsItem "Experience" settingsFieldsForInput.experience OnSettingsExperienceEditable fieldsEditable.experience OnInnovatorSettingsExperienceInput
        , settingsItem "Country" settingsFieldsForInput.country OnSettingsCountryEditable fieldsEditable.country OnInnovatorSettingsCountryInput
        , settingsItem "Change Password" settingsFieldsForInput.changePassword OnSettingsChangePasswordEditable fieldsEditable.changePassword OnInnovatorSettingsChangePasswordInput
        , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
        , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
        , br[][], br[][], br[][]
        , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
        , button [ onClick OnInnovatorSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
        ]
      ]


-- MOBILE


settingsMobileItem : String -> String -> Msg -> Bool -> (String -> Msg) -> Html Msg
settingsMobileItem label val onClickMsg editable onInputMsg =
  let
    inputBorder =
      if editable then
        ("border", "1px solid skyblue")
      else
        ("border", "none")

    inputDisabled =
      if editable then
        attribute "enabled" ""
      else
        attribute "disabled" ""
  in
    div [ style [("width", "100%")] ]
    [ div [ style [("width", "100%")], class "uk-flex" ]
      [ div [ class "uk-width-2-3 uk-flex-column" ]
        [ span [ style [("font-size", "90%"), ("text-align", "left"), ("float", "left"), ("color", "black")] ] [ text label ]
        , input [ onInput onInputMsg, inputDisabled, style [("font-size", "80%"), ("background", "white"), ("text-align", "left"), ("color", "grey"), inputBorder], value val ] []
        ]
      , a [ class "uk-width-1-3", onClick onClickMsg, style [("font-size", "90%"), ("text-align", "right"), ("color", "gold")] ] [ text "edit" ]
      ]
    , img [ style [("margin-top", "-2em"), ("margin-bottom", "-2em")], src "/images/grey_divider.png" ] []
    ]



mobileDashboardSettingsPageView : Model -> Html Msg
mobileDashboardSettingsPageView model =
  let
    currentUser = model.loggedInMember
    mainPage =
      if (model.desktopPage == Models.TariffPlansPage) then
        if currentUser.isOrganization then mobileOrganizationTariffPlansPageView model else mobileInnovatorTariffPlansPageView model
      else if (model.desktopPage == Models.SettingsPage) then
        if currentUser.isOrganization then mobileDashboardOrganizationSettingsPageView model else mobileDashboardInnovatorSettingsPageView model
      else
        span[][]

  in
    div []
    [ mainPage ]



mobileDashboardInnovatorSettingsPageView : Model -> Html Msg
mobileDashboardInnovatorSettingsPageView model =
  let
    fieldsEditable = model.innovatorSettingsFieldsEditable

    settingsFieldsForInput = model.innovatorSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")
  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ style [("width", "80vw"), ("margin-left", "5vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
        [ h5 [ style [("color", "grey")] ] [ text "General Account Settings" ]
        , br[][]
        , settingsMobileItem "Username" settingsFieldsForInput.username OnSettingsUsernameEditable fieldsEditable.username OnInnovatorSettingsUsernameInput
        , settingsMobileItem "Name" settingsFieldsForInput.name OnSettingsNameEditable fieldsEditable.name OnInnovatorSettingsNameInput
        , settingsMobileItem "Surname" settingsFieldsForInput.surname OnSettingsSurnameEditable fieldsEditable.surname OnInnovatorSettingsSurnameInput
        , div [ style [("width", "100%")], class "uk-flex" ]
          [ div [ class "uk-width-2-3 uk-flex-column" ]
            [ span [ style [("text-align", "left"), ("float", "left"), ("color", "black")] ] [ text "Photo" ]
            , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "left"), ("color", "grey"), ("border", "none")] ] []
            ]
          , a [ class "uk-width-1-3", style [("text-align", "right"), ("color", "gold")] ]
            [ label [ style [("font-weight", "normal")], for "innovator-pic" ] [ text "browse" ]
            , input [ id "innovator-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
            ]
          ]
        , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
        , settingsMobileItem "Phone number" settingsFieldsForInput.phone OnSettingsPhoneEditable fieldsEditable.phone OnInnovatorSettingsPhoneInput
        , settingsMobileItem "E-mail address" settingsFieldsForInput.email OnSettingsEmailEditable fieldsEditable.email OnInnovatorSettingsEmailInput
        , settingsMobileItem "About Me" settingsFieldsForInput.about_me OnSettingsAboutEditable fieldsEditable.about OnInnovatorSettingsAboutInput
        , settingsMobileItem "Education" settingsFieldsForInput.education OnSettingsEducationEditable fieldsEditable.education OnInnovatorSettingsEducationInput
        , settingsMobileItem "Experience" settingsFieldsForInput.experience OnSettingsExperienceEditable fieldsEditable.experience OnInnovatorSettingsExperienceInput
        , settingsMobileItem "Country" settingsFieldsForInput.country OnSettingsCountryEditable fieldsEditable.country OnInnovatorSettingsCountryInput
        , settingsMobileItem "Change Password" settingsFieldsForInput.changePassword OnSettingsChangePasswordEditable fieldsEditable.changePassword OnInnovatorSettingsChangePasswordInput
        , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
        , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
        , br[][], br[][], br[][]
        , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
        , button [ onClick OnInnovatorSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
        ]
      ]


mobileDashboardOrganizationSettingsPageView : Model -> Html Msg
mobileDashboardOrganizationSettingsPageView model =
  let
    fieldsEditable = model.organizationSettingsFieldsEditable

    settingsFieldsForInput = model.organizationSettingsFields

    errorsColor =
      if (settingsFieldsForInput.error == "Saved!") then
        ("color", "green")
      else
        ("color", "red")
  in
    div []
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "5vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "General Account Settings" ]
      , br[][]
      , settingsMobileItem "Username" settingsFieldsForInput.username OnOrgSettingsUsernameEditable fieldsEditable.username OnOrganizationSettingsUsernameInput
      , settingsMobileItem "Name" settingsFieldsForInput.name OnOrgSettingsNameEditable fieldsEditable.name OnOrganizationSettingsNameInput
      , div [ style [("width", "100%")], class "uk-flex" ]
        [ div [ class "uk-flex uk-flex-column uk-width-2-3" ]
          [ span [ style [("float", "left"), ("text-align", "left"), ("color", "black")] ] [ text "Photo" ]
          , input [ value settingsFieldsForInput.pic_name, attribute "disabled" "", style [("background", "white"), ("text-align", "left"), ("color", "grey"), ("border", "none")] ] []
          ]
        , a [ class "uk-width-1-3", style [("text-align", "right"), ("color", "gold")] ]
          [ label [ style [("font-weight", "normal")], for "organization-pic" ] [ text "browse" ]
          , input [ id "organization-pic", style [("display", "none")], type_ "file", accept "image/*" ] []
          ]
        ]
      , img [ style [("margin-top", "-1em")], src "/images/grey_divider.png" ] []
      , settingsMobileItem "Phone number" settingsFieldsForInput.phone OnOrgSettingsPhoneEditable fieldsEditable.phone OnOrganizationSettingsPhoneInput
      , settingsMobileItem "E-mail address" settingsFieldsForInput.email OnOrgSettingsEmailEditable fieldsEditable.email OnOrganizationSettingsEmailInput
      , settingsMobileItem "Webpage" settingsFieldsForInput.webpage OnOrgSettingsWebpageEditable fieldsEditable.webpage OnOrganizationSettingsWebpageInput
      , settingsMobileItem "About Us" settingsFieldsForInput.about_us OnOrgSettingsAboutEditable fieldsEditable.about_us OnOrganizationSettingsAboutInput
      , settingsMobileItem "Description" settingsFieldsForInput.description OnOrgSettingsDescriptionEditable fieldsEditable.description OnOrganizationSettingsDescriptionInput
      , settingsMobileItem "Industry" settingsFieldsForInput.industry OnOrgSettingsIndustryEditable fieldsEditable.industry OnOrganizationSettingsIndustryInput
      , settingsMobileItem "Interested Industries" settingsFieldsForInput.interested_industries OnOrgSettingsInterestedIndustriesEditable fieldsEditable.interested_industries OnOrganizationSettingsInterestedIndustriesInput
      , settingsMobileItem "Country" settingsFieldsForInput.country OnOrgSettingsCountryEditable fieldsEditable.country OnOrganizationSettingsCountryInput
      , settingsMobileItem "Change Password" settingsFieldsForInput.changePassword OnOrgSettingsChangePasswordEditable fieldsEditable.changePassword OnOrganizationSettingsChangePasswordInput
      , a [ onClick OnSwitchTariffPlansPage, style [("margin-top", "-0.7em"), ("font-size", "100%"), ("color", "gold"), ("float", "left"), ("text-decoration", "underline")] ] [ text "Select your tariff plan" ]
      , a [ onClick OnSwitchNDAsPage, style [("color", "skyblue"), ("float", "right"), ("text-decoration", "underline"), ("margin-top", "-0.7em"), ("font-size", "100%")] ] [ text "NDAs" ]
      , br[][], br[][], br[][]
      , p [ style [ errorsColor, ("font-size", "90%")] ] [ text settingsFieldsForInput.error ]
      , button [ onClick OnOrganizationSettingsSaveChanges, style [("padding-right", "2em"), ("padding-left", "2em"), ("background", "gold"), ("color", "black"), ("border", "none")] ] [ text "Save Changes" ]
      ]
    ]

mobileOrganizationTariffPlansPageView : Model -> Html Msg
mobileOrganizationTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "23,190"
        Models.Eng -> "48"

    by =
      case lang of
        Models.Arm -> "265,690"
        Models.Eng -> "548"

    bs =
      case lang of
        Models.Arm -> "12,590"
        Models.Eng -> "28"

    pm =
      case lang of
        Models.Arm -> "36,790"
        Models.Eng -> "76"

    py =
      case lang of
        Models.Arm -> "418,090"
        Models.Eng -> "864"

    ps =
      case lang of
        Models.Arm -> "23,390"
        Models.Eng -> "48"

    pmm =
      case lang of
        Models.Arm -> "61,990"
        Models.Eng -> "128"

    pmy =
      case lang of
        Models.Arm -> "715,290"
        Models.Eng -> "1475"

    pms =
      case lang of
        Models.Arm -> "28,590"
        Models.Eng -> "61"

    mm =
      case lang of
        Models.Arm -> "104,690"
        Models.Eng -> "216"

    my =
      case lang of
        Models.Arm -> "1,210,490"
        Models.Eng -> "2496"

    ms =
      case lang of
        Models.Arm -> "45,790"
        Models.Eng -> "96"
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "5vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , tabTariffPlanItem model "Basic" 5 "15 idea generators" "Current country" bm by bs
      , br[][], br[][]
      , tabTariffPlanItem model "Plus" 10 "30 idea generators" "Current region" pm py ps
      , br[][], br[][]
      , tabTariffPlanItem model "Premium" 20 "50 idea generators" "Current continent" pmm pmy pms
      , br[][], br[][]
      , tabTariffPlanItem model "Max" 50 "Unlimited" "Worldwide" mm my ms
      ]
    ]

mobileInnovatorTariffPlansPageView : Model -> Html Msg
mobileInnovatorTariffPlansPageView model =
  let
    lang = model.language

    bm =
      case lang of
        Models.Arm -> "3,790"
        Models.Eng -> "8"

    by =
      case lang of
        Models.Arm -> "42,590"
        Models.Eng -> "88"

    bs =
      case lang of
        Models.Arm -> "2,890"
        Models.Eng -> "8"

    pm =
      case lang of
        Models.Arm -> "6,690"
        Models.Eng -> "14"

    py =
      case lang of
        Models.Arm -> "76,590"
        Models.Eng -> "158"

    ps =
      case lang of
        Models.Arm -> "3,690"
        Models.Eng -> "10"

    pmm =
      case lang of
        Models.Arm -> "10,090"
        Models.Eng -> "21"

    pmy =
      case lang of
        Models.Arm -> "115,390"
        Models.Eng -> "238"

    pms =
      case lang of
        Models.Arm -> "5,690"
        Models.Eng -> "14"
  in
    div []
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ style [("width", "80vw"), ("margin-left", "5vw"), ("margin-top", "-3em")], class "uk-card uk-card-default uk-card-body" ]
      [ h5 [ style [("color", "grey")] ] [ text "Select Your Tariff Plan" ]
      , br[][]
      , div [ class "uk-flex-column" ]
        [ span [ style [("display", "block"), ("color", "gold"), ("font-weight", "bold")] ] [ text "Free" ]
        , span [ style [("display", "block"), ("color", "grey")] ] [ text "Ideas: ", span [ style [("color", "black")] ] [ text "Up to 2" ] ]
        , span [ style [("display", "block"), ("color", "grey")] ] [ text "Connect to: ", span [ style [("color", "black")] ] [ text "1 Organization" ] ]
        , span [ style [("display", "block"), ("color", "grey")] ] [ text "Region: ", span [ style [("color", "black")] ] [ text "Current Country" ] ]
        , span [ style [("display", "block"), ("color", "blue")] ] [ text "Free" ]
        , br[][]
        , button [ onClick (OnSelectTariffPlan "Free"), style [("font-weight", "bold"), ("font-size", "90%"), ("padding-left", "2em"), ("padding-right", "2em"), ("background", "white"), ("color", "black"), ("border", "2px solid gold")] ] [ text "Choose" ]
        ]
      , br[][], br[][]
      , tabTariffPlanItem model "Basic" 3 "3 Organization" "Current Region" bm by bs
      , br[][], br[][]
      , tabTariffPlanItem model "Plus" 6 "5 organizations" "Current Continent" pm py ps
      , br[][], br[][]
      , tabTariffPlanItem model "Premium" 8 "8 organizations" "Worldwide" pmm pmy pms
      ]
    ]
