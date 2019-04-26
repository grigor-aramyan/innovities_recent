module DashboardView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)
import TopMembersList exposing (ratingStarsView)
import HeaderView exposing (pricingULView)
import IndustriesList as IL exposing (..)
import Suggestions exposing (..)
import SettingsView exposing (..)
import ChatWindowView exposing (..)
import NotificationsView exposing (..)
import IdeaPageView exposing (..)
import SearchedPageView exposing (..)
import NDAsPageView exposing (..)
import BackButtonView exposing (..)



dashboardView : Model -> Html Msg
dashboardView model =
  let
    loggedMember = model.loggedInMember

    mainPage =
      case model.desktopPage of
        HomePage ->
          leftAndMiddleColumnsView model
        NewsfeedPage ->
          leftAndMiddleColumnsView model
        ProfilePage ->
          if loggedMember.isOrganization then profilePageView model else innovatorProfilePageView model
        NewIdeaPage ->
          newIdeaPageView model
        SettingsPage ->
          if loggedMember.isOrganization then dashboardOrganizationSettingsPageView model else dashboardSettingsPageView model
        TariffPlansPage ->
          if loggedMember.isOrganization then dashboardOrganizationTariffPlansPageView model else dashboardTariffPlansPageView model
        SearchPage ->
          searchedPageView model
        SeeOtherInnovatorPage ->
          seeOtherInnovatorProfilePageView model model.seeOtherInnovator
        SeeOtherOrganizationPage ->
          seeOtherOrganizationProfilePageView model model.seeOtherOrganization
        ViewIdeaPage ->
          viewIdeaPage model
        ViewFullIdeaPage ->
          viewFullIdeaPage model
        NDAsPage ->
          ndasPageView model


  in
    div [ style [("background", "white")] ]
    [ backButtonView model
    , backButtonViewMobile model
    , headerComplexView model
    , headerComplexViewTab model
    , headerComplexViewMobile model
    , mainPageViewTab model
    , mainPageViewMobile model
    , img [ class "responsiveVisibility", src "/images/header_dashboard.png" ] []
    , div [ class "uk-flex" ]
      [ mainPage
      , chatWindowView model
      , div [ class "uk-width-1-5 responsiveVisibility", style [("border", "1px solid red")] ]
        [ rightColumnView model ]
      ]
    ]



mainPageViewTab : Model -> Html Msg
mainPageViewTab model =
  let
    user = model.loggedInMember

    mainPage =
      case model.dashboardMobilePage of
        MobileHomePage -> mobileDashboardHomePageView True model
        MobileNewsfeedPage -> mobileDashboardHomePageView True model
        MobileProfilePage -> if user.isOrganization then mobileDashboardProfilePageView model else mobileDashboardInnovatorProfilePageView model
        MobileSettingsPage -> tabDashboardSettingsPageView model
        MobilePostAnIdeaPage -> newIdeaPageTabView model
        MobileSearchPage -> searchedPageViewTab model
        MobileSeeOtherInnovatorPage -> seeOtherInnovatorProfilePageViewTab model model.seeOtherInnovator
        MobileSeeOtherOrganizationPage -> seeOtherOrganizationProfilePageViewTab model model.seeOtherOrganization
        MobileViewIdeaPage -> viewIdeaPage model
        MobileViewFullIdeaPage -> viewFullIdeaPageMobile model
        MobileNDAsPage -> ndasPageViewTab model


    searchProgress = model.searchProgress

    searchBox =
      if (model.mobileSearchVisible) then
        div [ class "responsiveVisibilityTab", style [("padding", "0.5em 0.1em 0.5em 0.1em"), ("background", "white"), ("border", "1px solid grey"), ("height", "1.8em")] ] [ span [ onClick OnSubmitSearch, style [("color", "gold")], attribute "uk-icon" "search" ] [], input [ onInput OnInputSearch, style [("padding", "0.3em 0.1em 0.3em 0.1em"), ("width", "30vw"), ("color", "grey"), ("border", "none")], placeholder "Search", value searchProgress.typedSearch ] [] ]
      else
        span [][]
  in
    div [ class "responsiveVisibilityTab" ]
      [ searchBox
      , mainPage
      ]


mainPageViewMobile : Model -> Html Msg
mainPageViewMobile model =
  let
    user = model.loggedInMember

    mainPage =
      case model.dashboardMobilePage of
        MobileHomePage -> mobileDashboardHomePageView False model
        MobileNewsfeedPage -> mobileDashboardHomePageView False model
        MobileProfilePage -> if user.isOrganization then mobileDashboardProfilePageViewSmall model else mobileDashboardInnovatorProfilePageViewSmall model
        MobileSettingsPage -> mobileDashboardSettingsPageView model
        MobilePostAnIdeaPage -> newIdeaPageMobileView model
        MobileSearchPage -> searchedPageViewMobile model
        MobileSeeOtherInnovatorPage -> seeOtherInnovatorProfilePageViewMobile model model.seeOtherInnovator
        MobileSeeOtherOrganizationPage -> seeOtherOrganizationProfilePageViewMobile model model.seeOtherOrganization
        MobileViewIdeaPage -> viewIdeaPage model
        MobileViewFullIdeaPage -> viewFullIdeaPageMobile model
        MobileNDAsPage -> ndasPageViewMobile model


    searchProgress = model.searchProgress

    searchBox =
      if (model.mobileSearchVisible) then
        div [ class "responsiveVisibilityMobile", style [("padding", "0.5em 0.1em 0.5em 0.1em"), ("background", "white"), ("border", "1px solid grey"), ("height", "1.8em")] ] [ span [ onClick OnSubmitSearch, style [("color", "gold")], attribute "uk-icon" "search" ] [], input [ onInput OnInputSearch, style [("padding", "0.3em 0.1em 0.3em 0.1em"), ("width", "30vw"), ("color", "grey"), ("border", "none")], placeholder "Search", value searchProgress.typedSearch ] [] ]
      else
        span [][]

  in
    div [ class "responsiveVisibilityMobile" ]
      [ searchBox
      , mainPage ]



mobileDashboardHomePageView : Bool -> Model -> Html Msg
mobileDashboardHomePageView forTab model =
  let
    middleColumn =
      if forTab then
        middleColumnTabView model
      else
        middleColumnMobileView model
  in
    div []
      [ middleColumn ]


middleColumnMobileView : Model -> Html Msg
middleColumnMobileView model =
  let
    user = model.loggedInMember
    extendedInnovator = model.currentInnovatorExtended
    extendedOrg = model.currentOrganizationExtended

    pic =
      if (user.isOrganization && (String.isEmpty extendedOrg.pic_uri)) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else if (user.isOrganization) then
        extendedOrg.pic_uri
      else if ((not user.isOrganization) && (String.isEmpty extendedInnovator.pic_uri)) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        extendedInnovator.pic_uri

    postData = model.postData

    errors =
      if (not (String.isEmpty postData.error)) then
        div []
        [ br[][]
        , p [ style [("color", "red"), ("font-size", "90%")] ] [ text postData.error ]
        ]
      else
        span [][]

    report =
      if (not (String.isEmpty postData.mediaFileName)) then
        div []
        [ br[][]
        , p [ style [("color", "green"), ("font-size", "90%")] ] [ text postData.mediaFileName ]
        ]
      else
        span [][]

    posts = model.postList
    postsWrapped =
      List.map (ideasListItem model) posts

    postsView =
      if ((List.length postsWrapped) > 0) then
        div [] (postsWrapped)
      else
        div [ style [("color", "grey")] ] [ br[][], text "No posts were fetched!" ]
  in
    div [ style [("width", "100vw")] ]
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ div [ class "uk-child-width-1-4" ]
          [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "7%"), ("height", "auto")], class "marginedUpRoundedImage", src pic ] []
          , p [ style [("margin-top", "-0.4em"), ("margin-left", "-1em"), ("display", "inline"), ("text-align", "left"), ("float", "left"), ("font-weight", "bold"), ("color", "black"), ("font-size", "70%")] ] [ text "Name Surename" ]
          ]
        , textarea [ value postData.message, onInput OnPostMessageInput, style [("resize", "none"), ("background", "white"), ("width", "100%"), ("border", "none")], rows 1, placeholder "Lorem ipsum" ] []
        , img [ src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ]
          [ a [ style [("color", "grey"), ("float", "left")] ]
            [ span [ style [("margin-right", "1px")], attribute "uk-icon" "image" ] []
            , label [ class "btn", for "files" ] [ text "Photo/Video" ]
            , input [ id "files", style [("display", "none")], type_ "file" ] []
            ]
          , button [ onClick OnSubmitPost, style [("margin-top", "0.4em"), ("background", "gold"), ("float", "right"), ("border", "none"), ("color", "black"), ("padding", "0 1em")] ] [ text "Post" ]
          , errors
          , report
          ]
        ]
      , postsView
      ]


middleColumnTabView : Model -> Html Msg
middleColumnTabView model =
  let
    user = model.loggedInMember
    extendedInnovator = model.currentInnovatorExtended
    extendedOrg = model.currentOrganizationExtended

    pic =
      if (user.isOrganization && (String.isEmpty extendedOrg.pic_uri)) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else if (user.isOrganization) then
        extendedOrg.pic_uri
      else if ((not user.isOrganization) && (String.isEmpty extendedInnovator.pic_uri)) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        extendedInnovator.pic_uri

    postData = model.postData

    errors =
      if (not (String.isEmpty postData.error)) then
        div []
        [ br[][]
        , p [ style [("color", "red"), ("font-size", "90%")] ] [ text postData.error ]
        ]
      else
        span [][]

    report =
      if (not (String.isEmpty postData.mediaFileName)) then
        div []
        [ br[][]
        , p [ style [("color", "green"), ("font-size", "90%")] ] [ text postData.mediaFileName ]
        ]
      else
        span [][]

    posts = model.postList
    postsWrapped =
      List.map (ideasListItem model) posts

    postsView =
      if ((List.length postsWrapped) > 0) then
        div [ style [("height", "50vh")] ] (postsWrapped)
      else
        div [ style [("color", "grey")] ] [ br[][], text "No posts were fetched!" ]

  in
    div [ style [("width", "80vw"), ("margin-left", "10vw")] ]
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ div [ class "uk-child-width-1-4" ]
          [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "7%"), ("height", "auto")], class "marginedUpRoundedImage", src pic ] []
          , p [ style [("margin-top", "0.1em"), ("margin-left", "-1em"), ("display", "inline"), ("text-align", "left"), ("float", "left"), ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ text "Name Surename" ]
          ]
        , textarea [ value postData.message, onInput OnPostMessageInput, style [("resize", "none"), ("background", "white"), ("width", "100%"), ("border", "none")], rows 2, placeholder "Lorem ipsum" ] []
        , img [ src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ]
          [ a [ style [("color", "grey"), ("float", "left")] ]
            [ span [ style [("margin-right", "1px")], attribute "uk-icon" "image" ] []
            , label [ class "btn", for "files" ] [ text "Photo/Video" ]
            , input [ id "files", style [("display", "none")], type_ "file" ] []
            ]
          , button [ onClick OnSubmitPost, style [("margin-top", "0.4em"), ("background", "gold"), ("float", "right"), ("border", "none"), ("color", "black"), ("padding", "0 1em")] ] [ text "Post" ]
          , errors
          , report
          ]
        ]
      , postsView
      ]


mobileDashboardProfilePageView : Model -> Html Msg
mobileDashboardProfilePageView model =
  let
    user = model.loggedInMember

    currentOrganization = model.currentOrganizationExtended

    pic =
      if (String.isEmpty currentOrganization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        currentOrganization.pic_uri

    profileInfo = "Name: " ++ currentOrganization.name ++ "\n" ++ "Short info: "
      ++ currentOrganization.description ++ "\n" ++ "Username: " ++ currentOrganization.username
      ++ "\n" ++ "Webpage: " ++ currentOrganization.webpage
      ++ "\n" ++ "Email: " ++ currentOrganization.email ++ "\n"
      ++ "About us: " ++ currentOrganization.about_us ++ "\n" ++ "Industry: "
      ++ currentOrganization.industry ++ "\n" ++ "Interested industries: "
      ++ currentOrganization.interested_industries
  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-2em"), ("margin-right", "0.7em"), ("width", "7%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-0.5em"), ("margin-bottom", "-1em")] ] [ text currentOrganization.name ]
        , p [ style [("color", "grey"), ("margin-right", "20%"), ("margin-left", "20%"), ("font-size", "90%")] ] [ text currentOrganization.description ]
        , a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text currentOrganization.webpage ]
        , div [ class "uk-flex", style [("margin-left", "33%"), ("margin-top", "1em")] ]
          [ button [ onClick OnDashboardMobileSettingsPageOpen, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text "Share profile" ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkTab "About us:" currentOrganization.about_us
        , infoChunkTab "Industry:" currentOrganization.industry
        , infoChunkTab "Industries we are interested in:" currentOrganization.interested_industries
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentOrganization.connections_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentOrganization.rating) ],  (ratingStarsView currentOrganization.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsTabView model ]
      ]


seeOtherOrganizationProfilePageViewTab : Model -> OrganizationExtended -> Html Msg
seeOtherOrganizationProfilePageViewTab model organization =
  let
    user = model.loggedInMember

    currentOrganization = model.currentOrganizationExtended

    pic =
      if (String.isEmpty organization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        organization.pic_uri


    receiverData = (ChatMessageReceiverData organization.id organization.name True)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(organization.id)) && (c.value == "true")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-2em"), ("margin-right", "0.7em"), ("width", "7%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-0.5em"), ("margin-bottom", "-1em")] ] [ text organization.name ]
        , p [ style [("color", "grey"), ("margin-right", "20%"), ("margin-left", "20%"), ("font-size", "90%")] ] [ text organization.description ]
        , a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text organization.webpage ]
        , div [ class "uk-flex", style [("margin-left", "33%"), ("margin-top", "1em")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated organization.id True), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text connectBtnText ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkTab "About us:" organization.about_us
        , infoChunkTab "Industry:" organization.industry
        , infoChunkTab "Industries we are interested in:" organization.interested_industries
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString organization.connections_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString organization.rating) ],  (ratingStarsView organization.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsTabView model ]
      ]


seeOtherInnovatorProfilePageViewTab : Model -> InnovatorExtended -> Html Msg
seeOtherInnovatorProfilePageViewTab model innovator =
  let
    user = model.loggedInMember

    currentInnovator = model.currentInnovatorExtended

    pic =
      if (String.isEmpty innovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        innovator.pic_uri


    receiverData = (ChatMessageReceiverData innovator.id innovator.name False)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(innovator.id)) && (c.value == "false")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-2em"), ("margin-right", "0.7em"), ("width", "7%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-0.5em"), ("margin-bottom", "-1em")] ] [ text innovator.name ]
        , p [ style [("color", "grey"), ("margin-right", "20%"), ("margin-left", "20%"), ("font-size", "90%")] ] [ text innovator.description ]
        --, a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , div [ class "uk-flex", style [("margin-left", "33%"), ("margin-top", "1em")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated innovator.id False), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text connectBtnText ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkTab "About me:" innovator.about_me
        , infoChunkTab "Education:" innovator.education
        , infoChunkTab "Experience:" innovator.experience
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.connections_count) ] ]
        --, button [ onClick OnMobileDashboardNewIdeaPageVisible, style [("background", "gold"), ("color", "black"), ("float", "right"), ("border", "none")] ] [ text "Post an Idea" ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.ideas_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString innovator.rating) ],  (ratingStarsView innovator.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsTabView model ]
      ]



seeOtherOrganizationProfilePageViewMobile : Model -> OrganizationExtended -> Html Msg
seeOtherOrganizationProfilePageViewMobile model organization =
  let
    user = model.loggedInMember

    currentOrganization = model.currentOrganizationExtended

    pic =
      if (String.isEmpty organization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        organization.pic_uri


    receiverData = (ChatMessageReceiverData organization.id organization.name True)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(organization.id)) && (c.value == "true")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "50%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-3em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-1.5em"), ("margin-bottom", "-1em")] ] [ text organization.name ]
        , p [ style [("color", "grey"), ("margin-right", "10%"), ("margin-left", "10%"), ("font-size", "70%")] ] [ text organization.description ]
        , a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text organization.webpage ]
        , div [ class "uk-flex", style [("margin-top", "1em"), ("margin-left", "5%")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em"), ("font-size", "65%")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated organization.id True), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black"), ("font-size", "65%")] ] [ text connectBtnText ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkMobile "About us:" organization.about_us
        , infoChunkMobile "Industry:" organization.industry
        , infoChunkMobile "Industries we are interested in:" organization.interested_industries
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString organization.connections_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString organization.rating) ],  (ratingStarsView organization.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsMobileView model ]
      ]


seeOtherInnovatorProfilePageViewMobile : Model -> InnovatorExtended -> Html Msg
seeOtherInnovatorProfilePageViewMobile model innovator =
  let
    user = model.loggedInMember

    currentInnovator = model.currentInnovatorExtended

    pic =
      if (String.isEmpty innovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        innovator.pic_uri

    receiverData = (ChatMessageReceiverData innovator.id innovator.name False)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(innovator.id)) && (c.value == "false")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "50%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-3em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-1.5em"), ("margin-bottom", "-1em")] ] [ text innovator.name ]
        , p [ style [("color", "grey"), ("margin-right", "10%"), ("margin-left", "10%"), ("font-size", "70%")] ] [ text innovator.description ]
        --, a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , div [ class "uk-flex", style [("margin-top", "1em"), ("margin-left", "5%")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em"), ("font-size", "65%")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated innovator.id False), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black"), ("font-size", "65%")] ] [ text connectBtnText ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkMobile "About me:" innovator.about_me
        , infoChunkMobile "Education:" innovator.education
        , infoChunkMobile "Experience:" innovator.experience
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.connections_count) ] ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.ideas_count) ] ]
        --, br[][]
        --, button [ onClick OnMobileDashboardNewIdeaPageVisible, style [("margin-top", "0.5em"), ("background", "gold"), ("color", "black"), ("float", "left"), ("border", "none")] ] [ text "Post an Idea" ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString innovator.rating) ],  (ratingStarsView innovator.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsMobileView model ]
      ]



mobileDashboardInnovatorProfilePageView : Model -> Html Msg
mobileDashboardInnovatorProfilePageView model =
  let
    user = model.loggedInMember

    currentInnovator = model.currentInnovatorExtended

    pic =
      if (String.isEmpty currentInnovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        currentInnovator.pic_uri

    profileInfo = "Name: " ++ currentInnovator.name ++ "\n" ++ "Short info: "
      ++ currentInnovator.description ++ "\n" ++ "Username: " ++ currentInnovator.username
      ++ "\n" ++ "Email: " ++ currentInnovator.email ++ "\n"
      ++ "About me: " ++ currentInnovator.about_me ++ "\n" ++ "Education: "
      ++ currentInnovator.education ++ "\n" ++ "Experience: "
      ++ currentInnovator.experience ++ "\n" ++ "Rating: "
      ++ (toString currentInnovator.rating)
  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-2em"), ("margin-right", "0.7em"), ("width", "7%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-0.5em"), ("margin-bottom", "-1em")] ] [ text currentInnovator.name ]
        , p [ style [("color", "grey"), ("margin-right", "20%"), ("margin-left", "20%"), ("font-size", "90%")] ] [ text currentInnovator.description ]
        --, a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , div [ class "uk-flex", style [("margin-left", "33%"), ("margin-top", "1em")] ]
          [ button [ onClick OnDashboardMobileSettingsPageOpen, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text "Share profile" ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkTab "About me:" currentInnovator.about_me
        , infoChunkTab "Education:" currentInnovator.education
        , infoChunkTab "Experience:" currentInnovator.experience
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.connections_count) ] ]
        , button [ onClick OnMobileDashboardNewIdeaPageVisible, style [("background", "gold"), ("color", "black"), ("float", "right"), ("border", "none")] ] [ text "Post an Idea" ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.ideas_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentInnovator.rating) ],  (ratingStarsView currentInnovator.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsTabView model ]
      ]


mobileDashboardProfilePageViewSmall : Model -> Html Msg
mobileDashboardProfilePageViewSmall model =
  let
    user = model.loggedInMember

    currentOrganization = model.currentOrganizationExtended

    pic =
      if (String.isEmpty currentOrganization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        currentOrganization.pic_uri

    profileInfo = "Name: " ++ currentOrganization.name ++ "\n" ++ "Short info: "
      ++ currentOrganization.description ++ "\n" ++ "Username: " ++ currentOrganization.username
      ++ "\n" ++ "Webpage: " ++ currentOrganization.webpage
      ++ "\n" ++ "Email: " ++ currentOrganization.email ++ "\n"
      ++ "About us: " ++ currentOrganization.about_us ++ "\n" ++ "Industry: "
      ++ currentOrganization.industry ++ "\n" ++ "Interested industries: "
      ++ currentOrganization.interested_industries
  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "50%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-3em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-1.5em"), ("margin-bottom", "-1em")] ] [ text currentOrganization.name ]
        , p [ style [("color", "grey"), ("margin-right", "10%"), ("margin-left", "10%"), ("font-size", "70%")] ] [ text currentOrganization.description ]
        , a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text currentOrganization.webpage ]
        , div [ class "uk-flex", style [("margin-top", "1em"), ("margin-left", "5%")] ]
          [ button [ onClick OnDashboardMobileSettingsPageOpen, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em"), ("font-size", "65%")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black"), ("font-size", "65%")] ] [ text "Share profile" ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkMobile "About us:" currentOrganization.about_us
        , infoChunkMobile "Industry:" currentOrganization.industry
        , infoChunkMobile "Industries we are interested in:" currentOrganization.interested_industries
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentOrganization.connections_count) ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentOrganization.rating) ],  (ratingStarsView currentOrganization.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsMobileView model ]
      ]


mobileDashboardInnovatorProfilePageViewSmall : Model -> Html Msg
mobileDashboardInnovatorProfilePageViewSmall model =
  let
    user = model.loggedInMember

    currentInnovator = model.currentInnovatorExtended

    pic =
      if (String.isEmpty currentInnovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        currentInnovator.pic_uri

    profileInfo = "Name: " ++ currentInnovator.name ++ "\n" ++ "Short info: "
      ++ currentInnovator.description ++ "\n" ++ "Username: " ++ currentInnovator.username
      ++ "\n" ++ "Email: " ++ currentInnovator.email ++ "\n"
      ++ "About me: " ++ currentInnovator.about_me ++ "\n" ++ "Education: "
      ++ currentInnovator.education ++ "\n" ++ "Experience: "
      ++ currentInnovator.experience ++ "\n" ++ "Rating: "
      ++ (toString currentInnovator.rating)
  in
    div []
      [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
        [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
        , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "50%"), ("height", "auto")], src pic ] []
        , img [ style [("margin-top", "-3em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
        , h6 [ style [("font-weight", "bold"), ("margin-top", "-1.5em"), ("margin-bottom", "-1em")] ] [ text currentInnovator.name ]
        , p [ style [("color", "grey"), ("margin-right", "10%"), ("margin-left", "10%"), ("font-size", "70%")] ] [ text currentInnovator.description ]
        --, a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , div [ class "uk-flex", style [("margin-top", "1em"), ("margin-left", "5%")] ]
          [ button [ onClick OnDashboardMobileSettingsPageOpen, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em"), ("font-size", "65%")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black"), ("font-size", "65%")] ] [ text "Share profile" ]
          ]
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , infoChunkMobile "About me:" currentInnovator.about_me
        , infoChunkMobile "Education:" currentInnovator.education
        , infoChunkMobile "Experience:" currentInnovator.experience
        , img [ style [("width", "100%")], src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.connections_count) ] ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.ideas_count) ] ]
        , br[][]
        , button [ onClick OnMobileDashboardNewIdeaPageVisible, style [("font-size", "80%"), ("margin-top", "0.5em"), ("background", "gold"), ("color", "black"), ("float", "left"), ("border", "none")] ] [ text "Post an Idea" ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentInnovator.rating) ],  (ratingStarsView currentInnovator.rating True) ]
        ]
      , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "2em") ] ]
        [ suggestionsMobileView model ]
      ]



leftAndMiddleColumnsView : Model -> Html Msg
leftAndMiddleColumnsView model =
  let
    loggedMember = model.loggedInMember
    leftColumn =
      if loggedMember.isOrganization then
        leftColumnView model
      else
        leftColumnInnovatorView model
  in
    div [ class "uk-width-3-5 uk-flex responsiveVisibility" ]
      [ div [ class "uk-width-1-3", style [("border", "1px solid red"), ("margin-left", "10vw"), ("margin-right", "0.5em")] ]
        [ leftColumn ]
      , div [ class "uk-width-2-3", style [("border", "1px solid red"), ("margin-right", "0.5em")] ]
        [ middleColumnView model ]
      ]


profilePageView : Model -> Html Msg
profilePageView model =
  let
    currentOrganization = model.currentOrganizationExtended

    pic =
      if (String.isEmpty currentOrganization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        currentOrganization.pic_uri

    profileInfo = "Name: " ++ currentOrganization.name ++ "\n" ++ "Short info: "
      ++ currentOrganization.description ++ "\n" ++ "Username: " ++ currentOrganization.username
      ++ "\n" ++ "Webpage: " ++ currentOrganization.webpage
      ++ "\n" ++ "Email: " ++ currentOrganization.email ++ "\n"
      ++ "About us: " ++ currentOrganization.about_us ++ "\n" ++ "Industry: "
      ++ currentOrganization.industry ++ "\n" ++ "Interested industries: "
      ++ currentOrganization.interested_industries
  in
    div [ style [("width", "50%"), ("padding-top", "0.5em"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("margin-left", "10vw")] ]
      [ img [ style [("width", "80%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-4.5em"), ("width", "20%"), ("height", "auto")], src pic ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "5%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , div []
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text currentOrganization.name ]
        , p [ style [("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-top", "0.5em")] ] [ text currentOrganization.description ]
        , div [ class "uk-flex", style [("margin-left", "25%")] ]
          [ button [ onClick OnSwitchSettingsPage, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text "Share profile" ]
          ]
        , div [ style [("padding", "1em")] ]
          [ img [ src "/images/grey_divider.png" ] []
          , infoChunk "About Us:" currentOrganization.about_us
          , infoChunk "Industry:" currentOrganization.industry
          , infoChunk "Industries we are interested in:" currentOrganization.interested_industries
          , img [ src "/images/grey_divider.png" ] []
          , br[][]
          , div [ style [("width", "100%"), ("margin-top", "1em")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentOrganization.connections_count) ] ]
          , br[][], br[][]
          , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentOrganization.rating) ],  (ratingStarsView currentOrganization.rating True) ]
          ]
        ]
      ]


seeOtherOrganizationProfilePageView : Model -> OrganizationExtended -> Html Msg
seeOtherOrganizationProfilePageView model organization =
  let

    pic =
      if (String.isEmpty organization.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        organization.pic_uri

    receiverData = (ChatMessageReceiverData organization.id organization.name True)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(organization.id)) && (c.value == "true")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div [ style [("width", "50%"), ("padding-top", "0.5em"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("margin-left", "10vw")] ]
      [ img [ style [("width", "80%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-4.5em"), ("width", "20%"), ("height", "auto")], src pic ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "5%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , div []
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text organization.name ]
        , p [ style [("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-top", "0.5em")] ] [ text organization.description ]
        , div [ class "uk-flex", style [("margin-left", "25%")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated organization.id True), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text connectBtnText ]
          ]
        , div [ style [("padding", "1em")] ]
          [ img [ src "/images/grey_divider.png" ] []
          , infoChunk "About:" organization.about_us
          , infoChunk "Industry:" organization.industry
          , infoChunk "Industries we are interested in:" organization.interested_industries
          , img [ src "/images/grey_divider.png" ] []
          , br[][]
          , div [ style [("width", "100%"), ("margin-top", "1em")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString organization.connections_count) ] ]
          , br[][], br[][]
          , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString organization.rating) ],  (ratingStarsView organization.rating True) ]
          ]
        ]
      ]


seeOtherInnovatorProfilePageView : Model -> InnovatorExtended -> Html Msg
seeOtherInnovatorProfilePageView model innovator =
  let

    pic =
      if (String.isEmpty innovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        innovator.pic_uri

    receiverData = (ChatMessageReceiverData innovator.id innovator.name False)

    connections = model.connections

    connected =
      List.filter (\c -> (c.key == toString(innovator.id)) && (c.value == "false")) connections

    connectEnabled =
      if ((List.length connected) > 0) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    connectBtnText =
      if ((List.length connected) > 0) then
        "Connected!"
      else
        "Connect"

  in
    div [ style [("width", "50%"), ("padding-top", "0.5em"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("margin-left", "10vw")] ]
      [ img [ style [("width", "80%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-4.5em"), ("width", "20%"), ("height", "auto")], src pic ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "5%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , div []
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text innovator.name ]
        , p [ style [("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-top", "0.5em")] ] [ text innovator.description ]
        , div [ class "uk-flex", style [("margin-left", "25%")] ]
          [ button [ onClick (OnToggleChatWindow (Just receiverData)), style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Message" ]
          , button [ onClick (OnConnectInitiated innovator.id False), connectEnabled, style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text connectBtnText ]
          ]
        , div [ style [("padding", "1em")] ]
          [ img [ src "/images/grey_divider.png" ] []
          , infoChunk "About:" innovator.about_me
          , infoChunk "Education:" innovator.education
          , infoChunk "Experience:" innovator.experience
          , img [ src "/images/grey_divider.png" ] []
          , br[][]
          , div [ style [("width", "100%"), ("margin-top", "1em")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.connections_count) ] ]
          , br[][]
          , div [ style [("width", "100%"), ("margin-top", "1em")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString innovator.ideas_count) ] ]
          , br[][], br[][]
          , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString innovator.rating) ],  (ratingStarsView innovator.rating True) ]
          ]
        ]
      ]



innovatorProfilePageView : Model -> Html Msg
innovatorProfilePageView model =
  let
    currentInnovator = model.currentInnovatorExtended

    pic =
      if (String.isEmpty currentInnovator.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        currentInnovator.pic_uri

    profileInfo = "Name: " ++ currentInnovator.name ++ "\n" ++ "Short info: "
      ++ currentInnovator.description ++ "\n" ++ "Username: " ++ currentInnovator.username
      ++ "\n" ++ "Email: " ++ currentInnovator.email ++ "\n"
      ++ "About me: " ++ currentInnovator.about_me ++ "\n" ++ "Education: "
      ++ currentInnovator.education ++ "\n" ++ "Experience: "
      ++ currentInnovator.experience ++ "\n" ++ "Rating: "
      ++ (toString currentInnovator.rating)
  in
    div [ style [("width", "50%"), ("padding-top", "0.5em"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("margin-left", "10vw")] ]
      [ img [ style [("width", "80%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-4.5em"), ("width", "20%"), ("height", "auto")], src pic ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "5%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , div []
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text currentInnovator.name ]
        , p [ style [("padding-right", "10%"), ("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-top", "0.5em")] ] [ text currentInnovator.description ]
        , div [ class "uk-flex", style [("margin-left", "25%")] ]
          [ button [ onClick OnSwitchSettingsPage, style [("background", "gold"), ("border", "none"), ("color", "black"), ("margin-right", "1em")] ] [ text "Edit profile" ]
          , button [ onClick (OnShareProfileOnFacebook profileInfo), style [("background", "white"), ("border", "2px solid gold"), ("color", "black")] ] [ text "Share profile" ]
          ]
        , div [ style [("padding", "1em")] ]
          [ img [ src "/images/grey_divider.png" ] []
          , infoChunk "About:" currentInnovator.about_me
          , infoChunk "Education:" currentInnovator.education
          , infoChunk "Experience:" currentInnovator.experience
          , img [ src "/images/grey_divider.png" ] []
          , br[][]
          , div [ style [("width", "100%"), ("margin-top", "1em")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.connections_count) ] ]
          , button [ onClick OnDashboardNewIdeaPageVisible, style [("background", "gold"), ("color", "black"), ("float", "right"), ("border", "none")] ] [ text "Post an Idea" ]
          , br[][]
          , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentInnovator.ideas_count) ] ]
          , br[][], br[][]
          , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentInnovator.rating) ],  (ratingStarsView currentInnovator.rating True) ]
          ]
        ]
      ]


infoChunk : String -> String -> Html Msg
infoChunk title info =
  div []
    [ p [ style [("font-size", "95%"), ("text-align", "left"),("color", "black"), ("font-weight", "bold"), ("margin-bottom", "-0.1em")] ] [ text title ]
    , p [ style [("font-size", "90%"), ("text-align", "left"), ("color", "black"), ("margin-top", "-0.1em")] ] [ text info ]
    ]


infoChunkMobile : String -> String -> Html Msg
infoChunkMobile title info =
  div []
    [ p [ style [("font-size", "75%"), ("text-align", "left"),("color", "black"), ("font-weight", "bold"), ("margin-bottom", "-0.1em")] ] [ text title ]
    , p [ style [("font-size", "70%"), ("text-align", "left"), ("color", "black"), ("margin-top", "-0.1em")] ] [ text info ]
    ]


infoChunkTab : String -> String -> Html Msg
infoChunkTab title info =
  div [ style [("width", "80%"), ("margin-left", "10%")] ]
    [ p [ style [("font-size", "95%"), ("color", "black"), ("font-weight", "bold"), ("margin-bottom", "-0.1em")] ] [ text title ]
    , p [ style [("font-size", "90%"), ("color", "black"), ("margin-top", "-0.1em")] ] [ text info ]
    ]


headerComplexView : Model -> Html Msg
headerComplexView model =
  let
    pricingVisible = model.pricingOpened

    optionsVisible =
      if model.dashboardOptionsVisible then
        ("display", "block")
      else
        ("display", "none")

    unredsList = model.pendingUnredMessages
    unredsCount =
      if (List.length(unredsList) > 0) then
        toString(List.length(unredsList))
      else
        ""

    unredsCountView =
      if (List.length(unredsList) > 0) then
        button [ class "responsiveVisibility", attribute "disabled" "", style [("margin-left", "-0.3em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold"), ("color", "white")] ] [ text unredsCount ]
      else
        button [ class "responsiveVisibility", attribute "disabled" "", style [("margin-left", "-0.3em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "white")] ] []


    messagesNotifs =
      if (List.length(unredsList) > 0) then
        unredMessagesListView model
      else
        span[][]


    unredsNotifs = model.notifications
    unredNotifsCount =
      if (List.length(unredsNotifs) > 0) then
        toString(List.length(unredsNotifs))
      else
        ""

    unredNotifsView =
      if (List.length(unredsNotifs) > 0) then
        button [ class "responsiveVisibility", attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold"), ("color", "white")] ] [ text unredNotifsCount ]
      else
        button [ class "responsiveVisibility", attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "white")] ] []


    newNotifs =
      if (List.length(unredsNotifs) > 0) then
        newNotifsListView model
      else
        span[][]

    searchedDataAll = model.searchedData
    searchProgress = model.searchProgress

  in
    div [ class "uk-flex responsiveVisibility" ]
    [ div [ class "headerLogoBlack responsiveVisibility", style [("margin-left", "10vw")] ] []
    , newNotifs
    , messagesNotifs
    , headerNavigationViewBlack pricingVisible
    , div [ style [("margin-left", "45%")] ]
      [ div [ class "responsiveVisibility", style [("margin-top", "3em"), ("margin-right", "1em"), ("margin-left", "2em"), ("background", "white"), ("border", "1px solid grey"), ("padding", "0.3em")] ] [ span [ onClick OnSubmitSearch, style [("color", "gold")], attribute "uk-icon" "search" ] [], input [ onInput OnInputSearch, style [("width", "7vw"), ("color", "grey"), ("border", "none")], placeholder "Search", value searchProgress.typedSearch ] [] ]
      , a [ onClick OnNewNotifsVisibilityToggle ] [ span [ class "responsiveDisplay", style [("color", "black")], attribute "uk-icon" "icon: bell; ratio: 1.3" ] [], unredNotifsView ]
      , a [ onClick OnNewMessagesNotifsVisibilityToggle ] [ span [ class "responsiveDisplay", style [("color", "black")], attribute "uk-icon" "icon: comments; ratio: 1.3" ] [], unredsCountView ]
      , div [ class "uk-flex uk-flex-column responsiveDisplay", style [("width", "10vw"), ("float", "right")] ]
        [ a [ href "#profile", onClick OnLocationChangeProfilePage ] [ img [ style [("margin-top", "0"), ("margin-left", "30%"), ("width", "40%"), ("height", "auto")], class "marginedUpRoundedImage", src "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg" ] [] ]
        , a [ onClick OnSwitchDashboardOptionsVisible, style [("color", "black")] ] [ text "Us", span [ style [("color", "black")], attribute "uk-icon" "triangle-down" ] [] ]
        , div [ style [optionsVisible, ("background", "white"), ("padding", "0.5em"), ("position", "absolute"), ("top", "21%"), ("right", "10%")] ]
          [ a [ onClick OnSwitchSettingsPage, style [("color", "gold"), ("font-size", "90%"), ("display", "block"), ("margin-right", "0")] ] [ text "Settings & Privacy" ]
          , a [ style [("text-align", "right"), ("color", "gold"), ("font-size", "90%"), ("display", "block")] ] [ text "Help Center" ]
          , a [ style [("text-align", "right"), ("color", "black"), ("font-size", "90%"), ("display", "block")] ] [ text "Language" ]
          , a [ style [("color", "grey"), ("font-weight", "bold"), ("pointer-events", "none")], attribute "disabled" "" ] [ text "______________" ]
          , a [ onClick OnSignOutInitiated, style [("text-align", "right"), ("color", "gold"), ("font-size", "90%"), ("display", "block")] ] [ text "Sign Out" ]
          ]
        ]
      ]
    ]



unredMessagesListView : Model -> Html Msg
unredMessagesListView model =
  let
    unredMessagesNotifsVisible =
      if model.newMessagesNotifsVisible then
        ("display", "initial")
      else
        ("display", "none")

    unredMessagesItems =
      List.map unredMessageItem model.pendingUnredMessages

  in
    ul [ class "unredMessgesNotifsStyle", style [unredMessagesNotifsVisible] ]
    (unredMessagesItems)


unredMessageItem : IncomingUnredChatMessage -> Html Msg
unredMessageItem item =
  let
    msg =
      if (String.length(item.body) > 30) then
        String.slice 0 30 item.body
      else
        item.body


    picUri =
      if (not (String.isEmpty item.sender_picture_uri)) then
        item.sender_picture_uri
      else if (item.sender_is_organization) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
  in
    li [ style [("border", "2px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
    [ a [ onClick (OnUnredChatMessageClick item.id) ]
      [ div [ class "uk-flex" ]
        [ div [ class "uk-width-1-4" ]
          [ img [ src picUri ] [] ]
        , div [ class "uk-width-3-4", style [("padding-left", "2%")] ]
          [ p [ style [("text-align", "left"), ("margin-bottom", "-5%"), ("font-size", "80%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.inserted_at ]
          , p [ style [("text-align", "left"), ("font-size", "90%"), ("color", "black")] ] [ text msg ]
          ]
        ]
      ]
    ]


headerComplexViewTab : Model -> Html Msg
headerComplexViewTab model =
  let
    letters = 1
    buttonsBack =
      if letters > 0 then
        ("background", "white")
      else
        ("background", "gold")

    buttonsTextColor =
      if letters > 0 then
        ("color", "black")
      else
        ("color", "gold")

    currentPage = model.dashboardMobilePage
    homeTabIconStyle =
      if currentPage == MobileHomePage then
        ("color", "white")
      else
        ("color", "black")

    homeTabBottomlineStyle =
      if currentPage == MobileHomePage then
        ("background", "white")
      else
        ("background", "gold")

    profileTabIconStyle =
      if currentPage == MobileProfilePage then
        ("color", "white")
      else
        ("color", "black")

    profileTabBottomlineStyle =
      if currentPage == MobileProfilePage then
        ("background", "white")
      else
        ("background", "gold")

    settingsTabIconStyle =
      if currentPage == MobileSettingsPage then
        ("color", "white")
      else
        ("color", "black")

    settingsTabBottomlineStyle =
      if currentPage == MobileSettingsPage then
        ("background", "white")
      else
        ("background", "gold")

    unredsList = model.pendingUnredMessages
    unredsCount =
      if (List.length(unredsList) > 0) then
        toString(List.length(unredsList))
      else
        ""

    unredsCountView =
      if (List.length(unredsList) > 0) then
        button [ attribute "disabled" "", style [("margin-right", "0.5em"), ("margin-left", "-0.5em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "black")] ] [ text unredsCount ]
      else
        button [ attribute "disabled" "", style [("margin-right", "0.5em"), ("margin-left", "-0.5em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold") ] ] []


    unredsNotifs = model.notifications
    unredNotifsCount =
      if (List.length(unredsNotifs) > 0) then
        toString(List.length(unredsNotifs))
      else
        ""

    unredNotifsView =
      if (List.length(unredsNotifs) > 0) then
        button [ attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "black")] ] [ text unredNotifsCount ]
      else
        button [ attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold")] ] []


  in
    div [ class "responsiveVisibilityTab" ]
    [ div [ class "uk-flex", style [("position", "absolute"), ("left", "0"), ("top", "1em"), ("width", "100vw"), ("background", "gold")] ]
      [ div [ class "uk-width-1-3" ] [ div [ class "headerLogoBlack" ] [] ]
      , div [ class "uk-width-2-3 uk-child-width-auto", attribute "uk-grid" "" ]
        [ div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnDashboardMobileHomePageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [homeTabIconStyle], attribute "uk-icon" "icon: home" ] [] ]
          , div [ style [homeTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-1em"), ("margin-left", "-1em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnDashboardMobileProfilePageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [profileTabIconStyle], attribute "uk-icon" "icon: user" ] [] ]
          , div [ style [profileTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-1em"), ("margin-left", "-1em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnNewNotifsVisibilityToggle, style [("padding-bottom", "40%"), ("padding-top", "45%")] ] [ span [ style [("margin-left", "-1em"), ("color", "black")], attribute "uk-icon" "icon: bell" ] [], unredNotifsView ] ]
        , div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnNewMessagesNotifsVisibilityToggle, style [("padding-bottom", "40%"), ("padding-top", "45%")] ] [ span [ style [("margin-left", "-1em"), ("color", "black")], attribute "uk-icon" "icon: comments" ] [], unredsCountView ] ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-1em")] ]
          [ a [ style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ onClick OnToggleMobileSearchInput, style [("color", "black")], attribute "uk-icon" "icon: search" ] [] ]
          , div [ style [("background", "gold"), ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-1em"), ("margin-left", "-1em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnDashboardMobileSettingsPageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [settingsTabIconStyle], attribute "uk-icon" "icon: cog" ] [] ]
          , div [ style [settingsTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-1em"), ("margin-left", "-1em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnSignOutInitiated, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [("color", "black")], attribute "uk-icon" "icon: table" ] [] ]
          , div [ style [("background", "gold"), ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-1em"), ("margin-left", "-1em")] ] []
          ]
        ]
      ]
    ]


headerComplexViewMobile : Model -> Html Msg
headerComplexViewMobile model =
  let
    letters = 1
    buttonsBack =
      if letters > 0 then
        ("background", "white")
      else
        ("background", "gold")

    buttonsTextColor =
      if letters > 0 then
        ("color", "black")
      else
        ("color", "gold")

    currentPage = model.dashboardMobilePage
    homeTabIconStyle =
      if currentPage == MobileHomePage then
        ("color", "white")
      else
        ("color", "black")

    homeTabBottomlineStyle =
      if currentPage == MobileHomePage then
        ("background", "white")
      else
        ("background", "gold")

    profileTabIconStyle =
      if currentPage == MobileProfilePage then
        ("color", "white")
      else
        ("color", "black")

    profileTabBottomlineStyle =
      if currentPage == MobileProfilePage then
        ("background", "white")
      else
        ("background", "gold")

    settingsTabIconStyle =
      if currentPage == MobileSettingsPage then
        ("color", "white")
      else
        ("color", "black")

    settingsTabBottomlineStyle =
      if currentPage == MobileSettingsPage then
        ("background", "white")
      else
        ("background", "gold")

    unredsList = model.pendingUnredMessages
    unredsCount =
      if (List.length(unredsList) > 0) then
        toString(List.length(unredsList))
      else
        ""

    unredsCountView =
      if (List.length(unredsList) > 0) then
        button [ attribute "disabled" "", style [("margin-right", "0.5em"), ("margin-left", "-0.5em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "black")] ] [ text unredsCount ]
      else
        button [ attribute "disabled" "", style [("margin-right", "0.5em"), ("margin-left", "-0.5em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold") ] ] []



    unredsNotifs = model.notifications
    unredNotifsCount =
      if (List.length(unredsNotifs) > 0) then
        toString(List.length(unredsNotifs))
      else
        ""

    unredNotifsView =
      if (List.length(unredsNotifs) > 0) then
        button [ attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "white"), ("color", "black")] ] [ text unredNotifsCount ]
      else
        button [ attribute "disabled" "", style [("margin-left", "-0.5em"), ("margin-right", "1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), ("background", "gold")] ] []

    -- button [ attribute "disabled" "", style [("margin-right", "1em"), ("margin-left", "-1em"), ("height", "1em"), ("border", "none"), ("border-radius", "40%"), ("font-size", "70%"), buttonsBack, buttonsTextColor] ] [ text "2" ]

  in
    div [ class "responsiveVisibilityMobile", style [("position", "absolute"), ("left", "0"), ("top", "2em"), ("width", "100vw")] ]
    [ div [ class "uk-flex", style [("background", "gold"), ("padding", "0.5em 0"), ("padding-left", "10vw")] ]
      [ div [ class "uk-width-3-3 uk-child-width-auto", attribute "uk-grid" "" ]
        [ div [ class "uk-flex uk-flex-column uk-flex-center" ]
          [ a [ onClick OnDashboardMobileHomePageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [homeTabIconStyle], attribute "uk-icon" "icon: home; ratio: 0.8" ] [] ]
          , div [ style [homeTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-0.5em"), ("margin-left", "-0.5em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-0.7em")] ]
          [ a [ onClick OnDashboardMobileProfilePageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [profileTabIconStyle], attribute "uk-icon" "icon: user; ratio: 0.8" ] [] ]
          , div [ style [profileTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-0.5em"), ("margin-left", "-0.5em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-0.4em")] ]
          [ a [ onClick OnNewNotifsVisibilityToggle, style [("padding-bottom", "40%"), ("padding-top", "45%")] ] [ span [ style [("margin-left", "-1em"), ("color", "black")], attribute "uk-icon" "icon: bell; ratio: 0.8" ] [], unredNotifsView ] ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-0.7em")] ]
          [ a [ onClick OnNewMessagesNotifsVisibilityToggle, style [("padding-bottom", "40%"), ("padding-top", "45%")] ] [ span [ style [("margin-left", "-1em"), ("color", "black")], attribute "uk-icon" "icon: comments; ratio: 0.8" ] [], unredsCountView ] ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-1.7em")] ]
          [ a [ style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ onClick OnToggleMobileSearchInput, style [("color", "black")], attribute "uk-icon" "icon: search; ratio: 0.8" ] [] ]
          , div [ style [("background", "gold"), ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-0.5em"), ("margin-left", "-0.5em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-0.7em")] ]
          [ a [ onClick OnDashboardMobileSettingsPageOpen, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [settingsTabIconStyle], attribute "uk-icon" "icon: cog; ratio: 0.8" ] [] ]
          , div [ style [settingsTabBottomlineStyle, ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-0.5em"), ("margin-left", "-0.5em")] ] []
          ]
        , div [ class "uk-flex uk-flex-column uk-flex-center", style [("margin-left", "-0.7em")] ]
          [ a [ onClick OnSignOutInitiated, style [("padding-bottom", "80%"), ("padding-top", "10%")] ] [ span [ style [("color", "black")], attribute "uk-icon" "icon: table; ratio: 0.8" ] [] ]
          , div [ style [("background", "gold"), ("height", "0.3em"), ("margin-bottom", "-1em"), ("margin-right", "-0.5em"), ("margin-left", "-0.5em")] ] []
          ]
        ]
      ]
    ]


headerNavigationViewBlack : PricingOpen -> Html Msg
headerNavigationViewBlack po =
  ul [ class "headerNavigationStyleBlack responsiveVisibility", style [("background-color", "white")] ]
    [ li [ style [ ("float", "left") ] ]
      [ a [ onClick (OnSwitchToHomePage "innovators"), style [("color", "black"), ("font-size", "90%")] ] [ text "Idea Generators" ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick (OnSwitchToHomePage "organizations"), style [("color", "black"), ("font-size", "90%")] ] [ text "Organizations" ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick OnPricingOpen, style [("color", "black"), ("font-size", "90%")] ] [ text "Pricing ", span [ attribute "uk-icon" "icon: triangle-down" ] [] ]
      , pricingULViewBlack po
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick (OnSwitchToHomePage "about-us"), style [("color", "black"), ("font-size", "90%")] ] [ text "About us" ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick (OnSwitchToHomePage "contacts"), style [("color", "black"), ("font-size", "90%")] ] [ text "Contact" ]
      , span [ class "headerNavigationBar" ] [ text "|" ]
      ]
    , li [ style [ ("float", "left") ] ]
      [ a [ onClick (OnSwitchToHomePage "faq"), style [("color", "black"), ("font-size", "90%")] ] [ text "FAQ" ]
      , span [ class "headerNavigationBar" ] [ text "" ]
      ]
    ]


pricingULViewBlack : PricingOpen -> Html Msg
pricingULViewBlack po =
  let
    v =
      case po of
        Opened -> "visible"
        Closed -> "hidden"
  in
    ul [ style [ ("visibility", v), ("listStyleType", "none"), ("position", "absolute"), ("right", "40%"), ("top", "270%"), ("background-color", "white"), ("padding", "0.3em") ] ]
      [ li [] [ a [ onClick (OnSwitchToHomePage "innovators-pricing"), style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#innovators-pricing" ] [ text "Idea Generators" ] ]
      , div [ class "boldDividerStyle" ] []
      , li [] [ a [ onClick (OnSwitchToHomePage "organizations-pricing"), style [ ("color", "gold"), ("fontSize", "0.9em"), ("float", "left") ], href "#organizations-pricing" ] [ text "Organizations" ] ]
      ]



leftColumnView : Model -> Html Msg
leftColumnView model =
  let
    currentExtendedUser = model.currentOrganizationExtended
  in
    div [ style [("padding-top", "0.5em")], class "responsiveVisibilityBlock" ]
      [ img [ style [("width", "60%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-3.5em"), ("width", "40%"), ("height", "50%")], src "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png" ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , br [][], br [][]
      , div [ style [("padding", "1em"), ("margin-top", "0.5em")] ]
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text "Company name" ]
        , p [ style [("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-bottom", "-0.1em")] ] [ text "Some company description will go here!" ]
        , a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline"), ("float", "left")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , img [ src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentExtendedUser.connections_count) ] ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Proposals" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text "14" ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentExtendedUser.rating) ],  (ratingStarsView currentExtendedUser.rating True) ]
        ]
      ]


leftColumnInnovatorView : Model -> Html Msg
leftColumnInnovatorView model =
  let

    currentExtendedUser = model.currentInnovatorExtended

  in
    div [ style [("padding-top", "0.5em")], class "responsiveVisibilityBlock" ]
      [ img [ style [("width", "60%"), ("height", "0.5em"), ("float", "right")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("float", "left"), ("margin-top", "-3.5em"), ("width", "40%"), ("height", "50%")], src "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg" ] []
      , img [ style [("margin-top", "0.7em"), ("margin-right", "0.7em"), ("width", "10%"), ("height", "auto"), ("float", "right")], src "/images/menu_icon.png" ] []
      , br [][], br [][]
      , div [ style [("padding", "1em"), ("margin-top", "0.5em")] ]
        [ h6 [ style [("font-weight", "bold"), ("text-align", "left"), ("margin-bottom", "-0.5em")] ] [ text "Company name" ]
        , p [ style [("color", "grey"), ("font-size", "90%"), ("text-align", "left"), ("margin-bottom", "-0.1em")] ] [ text "Some company description will go here!" ]
        --, a [ style [("font-size", "90%"), ("color", "black"), ("text-decoration", "underline"), ("float", "left")], href "www.google.com", target "_blank" ] [ text "www.example.com" ]
        , img [ src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Connections" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text (toString currentExtendedUser.connections_count) ] ]
        , br[][]
        , div [ style [("width", "100%")] ] [ span [ style [("font-weight", "bold"), ("color", "black"), ("float", "left"), ("font-size", "85%"), ("margin-right", "2px")] ] [ text "Generated Ideas" ], span [ style [("color", "gold"), ("float", "left"), ("font-size", "85%"), ("font-weight", "bold")] ] [ text "14" ] ]
        , br[][]
        , div [ style [("margin-top", "0.5em"), ("width", "100%")] ] [ span [ style [("font-size", "110%"), ("color", "black"), ("margin-right", "2px"), ("float", "left")] ] [ text (toString currentExtendedUser.rating) ],  (ratingStarsView currentExtendedUser.rating True) ]
        ]
      ]


middleColumnView : Model -> Html Msg
middleColumnView model =
  let
    postData = model.postData

    errors =
      if (not (String.isEmpty postData.error)) then
        div []
        [ br[][]
        , p [ style [("color", "red"), ("font-size", "90%")] ] [ text postData.error ]
        ]
      else
        span [][]

    report =
      if (not (String.isEmpty postData.mediaFileName)) then
        div []
        [ br[][]
        , p [ style [("color", "green"), ("font-size", "90%")] ] [ text postData.mediaFileName ]
        ]
      else
        span [][]

    posts = model.postList
    postsWrapped =
      List.map (ideasListItem model) posts

    postsView =
      if ((List.length postsWrapped) > 0) then
        div [] (postsWrapped)
      else
        div [ style [("color", "grey")] ] [ br[][], text "No posts were fetched!" ]

  in
    div [ class "responsiveVisibility" ]
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ textarea [ value postData.message, onInput OnPostMessageInput, style [("resize", "none"), ("background", "white"), ("width", "100%"), ("border", "none")], rows 3, placeholder "Lorem ipsum" ] []
        , img [ src "/images/grey_divider.png" ] []
        , div [ style [("width", "100%")] ]
          [ a [ style [("color", "grey"), ("float", "left")] ]
            [ span [ style [("margin-right", "1px")], attribute "uk-icon" "image" ] []
            , label [ class "btn", for "files" ] [ text "Photo/Video" ]
            , input [ id "files", style [("display", "none")], type_ "file" ] []
            ]
          , button [ onClick OnSubmitPost, style [("margin-top", "0.4em"), ("background", "gold"), ("float", "right"), ("border", "none"), ("color", "black"), ("padding", "0 1em")] ] [ text "Post" ]
          , errors
          , report
          ]
        ]
      , postsView
      ]



ideasListItemMobile : Model -> ExtendedPostData -> Html Msg
ideasListItemMobile model postData =
  let
    pic =
      if (String.isEmpty postData.post_media_file) then
        div [] []
      else
        img [ style [("width", "100%"), ("height", "auto")], src postData.post_media_file ] []

    avatar =
      if (String.isEmpty postData.author_pic) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        postData.author_pic

    authorName = postData.author_name
    authorDesc = postData.author_desc
    postMessage = postData.post_message
    postLikes = postData.post_likes

    postId = postData.post_id

    currentCommentData = model.currentCommentData
    sendButtonDisabled =
      if (String.isEmpty currentCommentData.body) then
        attribute "disabled" "disabled"
      else
        attribute "enabled" "enabled"

    postWithComments = model.currentPostWithComments
    commentsView =
      if (postId == postWithComments) then
        div [ style [("width", "100%"), ("color", "black")] ]
          [ br[][]
          , ul [ style [("list-style-type", "none"), ("padding", "0"), ("margin", "0")] ]
            ( List.map postCommentsItem model.currentPostComments )
          , input [ style [("font-size", "90%"), ("padding", "0.2em")], onInput OnCurrentPostCommentInput, placeholder "Your comment here..." ] []
          , button [ sendButtonDisabled, onClick OnSubmitComment, style [("padding", "0.4em"), ("font-size", "90%"), ("border", "none"), ("color", "white"), ("background", "blue")] ] [ text "Send" ]
          ]
      else
        span [][]

  in
    div []
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "10%"), ("height", "auto")], class "marginedUpRoundedImage", src avatar ] []
        , div [ class "uk-flex uk-flex-column", style [("width", "75%"), ("float", "left")] ]
          [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ text authorName ]
          , p [ style [("text-align", "left"),  ("margin-top", "-1em"), ("color", "grey"), ("font-size", "80%")] ] [ text authorDesc ]
          ]
        , img [ style [("width", "10%"), ("height", "auto"), ("float", "right"), ("margin-right", "0.5em"), ("margin-top", "-3em")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text postMessage ]
        , pic
        , p [ style [("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text (toString(postLikes) ++ " likes") ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ a [ onClick (OnPostLikeClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: heart; ratio: 0.7" ] [], text "Like" ]
          , a [ onClick (OnPostCommentsClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: comment; ratio: 0.7" ] [], text "Comment" ]
          , a [ style [("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: social; ratio: 0.7" ] [], text "Share" ]
          ]
        , commentsView
        ]
      ]
