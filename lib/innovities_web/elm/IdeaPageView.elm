module IdeaPageView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)
import IndustriesList as IL exposing (..)



viewFullIdeaPage : Model -> Html Msg
viewFullIdeaPage model =
  let
    selectedIdea = model.viewingCurrentFullIdea

    avatar =
      if (String.isEmpty selectedIdea.innovator_pic) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        selectedIdea.innovator_pic

    imagesListInitial = String.split ":::" selectedIdea.picture_uris
    imagesList =
      List.filter (\i -> not (String.isEmpty i)) imagesListInitial
    imagesCount = List.length imagesList
    imageWidth = 95 // imagesCount
    imageWidthStr = (toString imageWidth) ++ "%"

    imagesListView =
      List.map (\i -> img [ style [("width", imageWidthStr), ("height", imageWidthStr), ("margin", "0 0.2em")], src i ] []) imagesList

    imagesView =
      if (imagesCount == 0) then
        span [][]
      else
        div [ class "uk-flex" ]
          imagesListView

    videoUri = selectedIdea.video_uri
    videoView =
      if (String.isEmpty videoUri) then
        span [][]
      else
        --video [ style [("width", "80%"), ("height", "auto"), ("margin", "0.5em 0")], attribute "controls" "" ] [ source [ src videoUri ] [] ]
        iframe [ style [("width", "80%"), ("height", "auto"), ("margin", "0.5em 0")], src videoUri ] []
  in
    div [ class "responsiveDisplay uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src avatar ] []
      , p [ style [("color", "black")] ] [ text selectedIdea.innovator_name ]
      , img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , h2 [] [ text selectedIdea.idea_name ]
      , p [ style [("color", "black")] ] [ text selectedIdea.short_description ]
      , div [ style [("color", "black")] ]
        [ span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.industry ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.price ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em"), ("font-style", "italic"), ("color", "blue")] ] [ text selectedIdea.tags ]
        ]
      , p [ style [("color", "black")] ] [ text selectedIdea.long_description ]
      , imagesView
      , videoView
      , br[][]
      , button [ style [("border", "none"), ("color", "black"), ("background", "gold"), ("padding-left", "1em"), ("padding-right", "1em")] ] [ text "Pay For Idea" ]
      ]
    ]


viewFullIdeaPageMobile : Model -> Html Msg
viewFullIdeaPageMobile model =
  let
    selectedIdea = model.viewingCurrentFullIdea

    avatar =
      if (String.isEmpty selectedIdea.innovator_pic) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        selectedIdea.innovator_pic

    imagesListInitial = String.split ":::" selectedIdea.picture_uris
    imagesList =
      List.filter (\i -> not (String.isEmpty i)) imagesListInitial
    imagesCount = List.length imagesList
    imageWidthStr = "80%"

    imagesListView =
      List.map (\i -> img [ style [("width", imageWidthStr), ("height", "auto"), ("margin", "0.2em 0")], src i ] []) imagesList

    imagesView =
      if (imagesCount == 0) then
        span [][]
      else
        div [ class "uk-flex uk-flex-column" ]
          imagesListView

    videoUri = selectedIdea.video_uri
    videoView =
      if (String.isEmpty videoUri) then
        span [][]
      else
        --video [ style [("width", "80%"), ("height", "auto"), ("margin", "0.5em 0")], attribute "controls" "" ] [ source [ src videoUri ] [] ]
        iframe [ style [("width", "80%"), ("height", "auto"), ("margin", "0.5em 0")], src videoUri ] []
  in
    div []
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body", style [("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
      [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
      , img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src avatar ] []
      , p [ style [("color", "black")] ] [ text selectedIdea.innovator_name ]
      , img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , h2 [] [ text selectedIdea.idea_name ]
      , p [ style [("color", "black")] ] [ text selectedIdea.short_description ]
      , div [ style [("color", "black")] ]
        [ span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.industry ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.price ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em"), ("font-style", "italic"), ("color", "blue")] ] [ text selectedIdea.tags ]
        ]
      , p [ style [("color", "black")] ] [ text selectedIdea.long_description ]
      , imagesView
      , videoView
      , br[][]
      , button [ style [("border", "none"), ("color", "black"), ("background", "gold"), ("padding-left", "1em"), ("padding-right", "1em")] ] [ text "Pay For Idea" ]
      ]
    ]



viewIdeaPage : Model -> Html Msg
viewIdeaPage model =
  let
    selectedIdea = model.viewingCurrentIdea

    avatar =
      if (String.isEmpty selectedIdea.innovator_pic) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        selectedIdea.innovator_pic

  in
    div [ class "uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ img [ class "marginedUpRoundedImage", style [("margin-top", "-8em"), ("margin-right", "-1em"), ("width", "27%"), ("height", "auto")], src avatar ] []
      , p [ style [("color", "black")] ] [ text selectedIdea.innovator_name ]
      , img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , h2 [] [ text selectedIdea.idea_name ]
      , p [ style [("color", "black")] ] [ text selectedIdea.short_description ]
      , div [ style [("color", "black")] ]
        [ span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.industry ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em")] ] [ text (selectedIdea.price ++ "  |  ") ]
        , span [ style [("margin-right", "0.5em"), ("font-style", "italic"), ("color", "blue")] ] [ text selectedIdea.tags ]
        ]
      , br[][]
      , button [ onClick (OnFullDescRequestInitiated selectedIdea.id selectedIdea.innovator_id), style [("border", "none"), ("color", "black"), ("background", "gold"), ("padding-left", "1em"), ("padding-right", "1em")] ] [ text "Request Full Access" ]
      ]
    ]



-- NEW IDEA PAGE VIEW


newIdeaPageView : Model -> Html Msg
newIdeaPageView model =
  let
    newIdeaData = model.newIdeaData

    videoInfo =
      if (String.isEmpty newIdeaData.videoName) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Video: " ++ newIdeaData.videoName) ]

    picturesInfo =
      if (String.isEmpty newIdeaData.pictureNames) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Pictures: " ++ newIdeaData.pictureNames) ]

    hasNdaCheckedAttr =
      if newIdeaData.hasNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaSection =
      div [ style [("float", "left")] ]
        [ a []
          [ input [ onClick OnHasNdaClicked, type_ "checkbox", hasNdaCheckedAttr ] []
          , label [ style [("color", "skyblue"), ("font-size", "90%")] ] [ text "Has NDA?" ]
          ]
        , ndaRadios
        , customNdaTextarea
        ]

    customNdaTextarea =
      if (newIdeaData.hasNda && (not newIdeaData.isDefaultNda)) then
        textarea [ onInput OnCustomNdaInput, style [ ("font-size", "80%"), ("color", "black"), ("width", "100%") ], rows 2, value newIdeaData.customNda ] []
      else
        span[][]

    defaultNdaChecked =
      if newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    customNdaChecked =
      if not newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaRadios =
      if newIdeaData.hasNda then
        div []
          [ input [ onClick (OnNdaTypeClicked "Default"), defaultNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%"), ("margin-right", "1em")] ] [ text "Default NDA" ]
          , input [ onClick (OnNdaTypeClicked "Custom"), customNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%")] ] [ text "Custom NDA" ]
          ]
      else
        span [][]

  in
    div [ class "uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ div [ class "uk-flex" ]
        [ div [ class "uk-width-1-2", style [("margin-left", "-5%"), ("margin-right", "3%"), ("color", "black")] ]
          [ label [ style [("float", "left"), ("font-size", "80%")], for "project-name" ] [ text "Idea/Project Name" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
          , input [ value newIdeaData.ideaName, onInput OnNewIdeaNameInput, style [("font-size", "80%"), ("width", "110%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-name" ] []
          , br[][], br[][], br[][]
          , label [ style [("float", "left"), ("font-size", "80%")], for "industries" ] [ text "Industry" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
          , select [ value newIdeaData.industry, onInput OnNewIdeaIndustryInput, style [("font-size", "80%"), ("width", "110%"), ("border-radius", "10%"), ("border", "2px solid lightgrey"), ("padding", "0.2em")], id "industries" ] ( industriesList )
          , br[][], br[][]
          , label [ style [("float", "left"), ("font-size", "80%")], for "project-tags" ] [ text "Tags" ], br[][]
          , input [ value newIdeaData.tags, onInput OnNewIdeaTagsInput, style [("font-size", "80%"), ("width", "110%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-tags" ] []
          , br[][], br[][]
          , label [ style [("float", "left"), ("font-size", "80%")], for "short-description" ] [ text "Short Description " ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen by everyone)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
          , textarea [ value newIdeaData.shortDescription, onInput OnNewIdeaShortDescriptionInput, style [("font-size", "80%"), ("width", "110%"), ("resize", "none"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "short-description", rows 3, placeholder "Describe your idea/project in 3-4 sentences" ] []
          , br[][]
          , label [ style [("margin-top", "1.5em"), ("float", "left"), ("font-size", "80%")], for "idea-price" ] [ text "How much do you value your idea/project?" ], br[][], span [ style [("margin-top", "-0.5em"), ("float", "left"), ("font-size", "80%"), ("color", "grey")] ] [ text "(Please, mention the currency)"]
          , input [ value newIdeaData.ideaPrice, onInput OnNewIdeaPriceInput, style [("font-size", "80%"), ("width", "110%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "idea-price" ] []
          ]
        , div [ class "uk-width-1-2", style [ ("margin-left", "3%"), ("color", "black")] ]
          [ label [ style [("float", "left"), ("font-size", "80%")], for "long-description" ] [ text "Long Description" ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen after your approval)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
          , textarea [ value newIdeaData.longDescription, onInput OnNewIdeaLongDescriptionInput, style [("font-size", "80%"), ("width", "110%"), ("resize", "none"), ("float", "left"), ("border-radius", "2%"), ("border", "2px solid lightgrey")], id "long-description", rows 15, placeholder "Write detailed information of your idea/project" ] []
          , br[][]
          , div [ style [("float", "left"), ("margin-top", "18.5%")] ]
            [ a [ style [("color", "grey"), ("margin-right", "0.5em")] ]
              [ label [ class "btn", for "pictures", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach pictures" ]
              , input [ id "pictures", style [("display", "none")], type_ "file", accept "image/*" ] []
              ]
            , a [ style [("color", "grey"), ("margin-left", "0.5em")] ]
              [ label [ class "btn", for "video", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach video" ]
              , input [ id "video", style [("display", "none")], type_ "file", accept "video/*" ] []
              ]
            ]
          ]
        ]
      , ndaSection
      , p [ style [("color", "red"), ("font-size", "90%")] ] [ text newIdeaData.error ]
      , videoInfo
      , picturesInfo
      , button [ onClick OnNewIdeaSubmit, style [("width", "23%"), ("font-size", "90%"), ("color", "black"), ("background", "gold"), ("border", "none")] ] [ text "Post an Idea" ]
      ]
    ]


newIdeaPageTabView : Model -> Html Msg
newIdeaPageTabView model =
  let
    newIdeaData = model.newIdeaData

    videoInfo =
      if (String.isEmpty newIdeaData.videoName) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Video: " ++ newIdeaData.videoName) ]

    picturesInfo =
      if (String.isEmpty newIdeaData.pictureNames) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Pictures: " ++ newIdeaData.pictureNames) ]

    hasNdaCheckedAttr =
      if newIdeaData.hasNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaSection =
      div [ style [("float", "left")] ]
        [ a []
          [ input [ onClick OnHasNdaClicked, type_ "checkbox", hasNdaCheckedAttr ] []
          , label [ style [("color", "skyblue"), ("font-size", "90%")] ] [ text "Has NDA?" ]
          ]
        , ndaRadios
        , customNdaTextarea
        ]

    customNdaTextarea =
      if (newIdeaData.hasNda && (not newIdeaData.isDefaultNda)) then
        textarea [ onInput OnCustomNdaInput, style [ ("font-size", "80%"), ("color", "black"), ("width", "100%") ], rows 2, value newIdeaData.customNda ] []
      else
        span[][]

    defaultNdaChecked =
      if newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    customNdaChecked =
      if not newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaRadios =
      if newIdeaData.hasNda then
        div []
          [ input [ onClick (OnNdaTypeClicked "Default"), defaultNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%"), ("margin-right", "1em")] ] [ text "Default NDA" ]
          , input [ onClick (OnNdaTypeClicked "Custom"), customNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%")] ] [ text "Custom NDA" ]
          ]
      else
        span [][]
  in
    div [ style [("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "3% 10%"), ("width", "80%"), ("margin-left", "10%"), ("margin-top", "-3em")] ]
      [ label [ style [("float", "left"), ("font-size", "80%")], for "project-name" ] [ text "Idea/Project Name" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
      , input [ value newIdeaData.ideaName, onInput OnNewIdeaNameInput, style [("font-size", "80%"), ("float", "left"), ("width", "100%"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-name" ] []
      , br[][], br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "industries" ] [ text "Industry" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
      , select [ value newIdeaData.industry, onInput OnNewIdeaIndustryInput, style [("font-size", "80%"), ("width", "100%"), ("border-radius", "10%"), ("border", "2px solid lightgrey"), ("padding", "0.2em")], id "industries" ] ( industriesList )
      , br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "project-tags" ] [ text "Tags" ], br[][]
      , input [ value newIdeaData.tags, onInput OnNewIdeaTagsInput, style [("font-size", "80%"), ("width", "100%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-tags" ] []
      , br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "short-description" ] [ text "Short Description " ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen by everyone)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
      , textarea [ value newIdeaData.shortDescription, onInput OnNewIdeaShortDescriptionInput, style [("margin-bottom", "1.5em"), ("font-size", "80%"), ("width", "100%"), ("resize", "none"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "short-description", rows 3, placeholder "Describe your idea/project in 3-4 sentences" ] []
      , br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "long-description" ] [ text "Long Description" ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen after your approval)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
      , textarea [ value newIdeaData.longDescription, onInput OnNewIdeaLongDescriptionInput, style [("margin-bottom", "1.5em"), ("font-size", "80%"), ("width", "100%"), ("resize", "none"), ("float", "left"), ("border-radius", "2%"), ("border", "2px solid lightgrey")], id "long-description", rows 15, placeholder "Write detailed information of your idea/project" ] []
      , br[][], br[][], br[][]
      , div []
        [ a [ style [("color", "grey"), ("margin-right", "0.5em")] ]
          [ label [ class "btn", for "pictures", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach pictures" ]
          , input [ id "pictures", style [("display", "none")], type_ "file", accept "image/*" ] []
          ]
        , a [ style [("color", "grey"), ("margin-left", "0.5em")] ]
          [ label [ class "btn", for "video", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach video" ]
          , input [ id "video", style [("display", "none")], type_ "file", accept "video/*" ] []
          ]
        ]
      , label [ style [("margin-top", "1.5em"), ("float", "left"), ("font-size", "80%")], for "idea-price" ] [ text "How much do you value your idea/project?" ], br[][], span [ style [("margin-top", "-0.5em"), ("float", "left"), ("font-size", "80%"), ("color", "grey")] ] [ text "(Please, mention the currency)"]
      , input [ value newIdeaData.ideaPrice, onInput OnNewIdeaPriceInput, style [("font-size", "80%"), ("width", "100%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "idea-price" ] []
      , ndaSection
      , br[][], br[][]
      , p [ style [("color", "red"), ("font-size", "90%")] ] [ text newIdeaData.error ]
      , videoInfo
      , picturesInfo
      , button [ onClick OnNewIdeaSubmit, style [("width", "40%"), ("margin-top", "3em"), ("font-size", "90%"), ("color", "black"), ("background", "gold"), ("border", "none")] ] [ text "Post an Idea" ]
      ]
    ]


newIdeaPageMobileView : Model -> Html Msg
newIdeaPageMobileView model =
  let
    newIdeaData = model.newIdeaData

    videoInfo =
      if (String.isEmpty newIdeaData.videoName) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Video: " ++ newIdeaData.videoName) ]

    picturesInfo =
      if (String.isEmpty newIdeaData.pictureNames) then
        span [][]
      else
        p [ style [("color", "green"), ("font-size", "90%")] ] [ text ("Pictures: " ++ newIdeaData.pictureNames) ]

    hasNdaCheckedAttr =
      if newIdeaData.hasNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaSection =
      div [ style [("float", "left")] ]
        [ a []
          [ input [ onClick OnHasNdaClicked, type_ "checkbox", hasNdaCheckedAttr ] []
          , label [ style [("color", "skyblue"), ("font-size", "90%")] ] [ text "Has NDA?" ]
          ]
        , ndaRadios
        , customNdaTextarea
        ]

    customNdaTextarea =
      if (newIdeaData.hasNda && (not newIdeaData.isDefaultNda)) then
        textarea [ onInput OnCustomNdaInput, style [ ("font-size", "80%"), ("color", "black"), ("width", "100%") ], rows 2, value newIdeaData.customNda ] []
      else
        span[][]

    defaultNdaChecked =
      if newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    customNdaChecked =
      if not newIdeaData.isDefaultNda then
        attribute "checked" "checked"
      else
        attribute "enabled" "enabled"

    ndaRadios =
      if newIdeaData.hasNda then
        div []
          [ input [ onClick (OnNdaTypeClicked "Default"), defaultNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%"), ("margin-right", "1em")] ] [ text "Default NDA" ]
          , input [ onClick (OnNdaTypeClicked "Custom"), customNdaChecked, type_ "radio", name "ndaType" ] []
          , label [ style [("color", "black"), ("font-size", "80%")] ] [ text "Custom NDA" ]
          ]
      else
        span [][]
  in
    div []
    [ img [ style [("height", "12em")], src "/images/header_dashboard.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "3% 5%"), ("width", "90%"), ("margin-left", "5%"), ("margin-top", "-3em")] ]
      [ label [ style [("float", "left"), ("font-size", "80%")], for "project-name" ] [ text "Idea/Project Name" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
      , input [ value newIdeaData.ideaName, onInput OnNewIdeaNameInput, style [("font-size", "80%"), ("float", "left"), ("width", "100%"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-name" ] []
      , br[][], br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "industries" ] [ text "Industry" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ]
      , select [ value newIdeaData.industry, onInput OnNewIdeaIndustryInput, style [("font-size", "80%"), ("width", "100%"), ("border-radius", "10%"), ("border", "2px solid lightgrey"), ("padding", "0.2em")], id "industries" ] ( industriesList )
      , br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "project-tags" ] [ text "Tags" ], br[][]
      , input [ value newIdeaData.tags, onInput OnNewIdeaTagsInput, style [("font-size", "80%"), ("width", "100%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "project-tags" ] []
      , br[][], br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "short-description" ] [ text "Short Description " ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen by everyone)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
      , textarea [ value newIdeaData.shortDescription, onInput OnNewIdeaShortDescriptionInput, style [("margin-bottom", "1.5em"), ("font-size", "80%"), ("width", "100%"), ("resize", "none"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "short-description", rows 3, placeholder "Describe your idea/project in 3-4 sentences" ] []
      , br[][]
      , label [ style [("float", "left"), ("font-size", "80%")], for "long-description" ] [ text "Long Description" ], span [ style [("margin-left", "1px"), ("float", "left"), ("color", "grey"), ("font-size", "80%")] ] [ text "(seen after your approval)" ], span [ style [("float", "left"), ("color", "red")] ] [ text "*" ], br[][]
      , textarea [ value newIdeaData.longDescription, onInput OnNewIdeaLongDescriptionInput, style [("margin-bottom", "1.5em"), ("font-size", "80%"), ("width", "100%"), ("resize", "none"), ("float", "left"), ("border-radius", "2%"), ("border", "2px solid lightgrey")], id "long-description", rows 15, placeholder "Write detailed information of your idea/project" ] []
      , br[][]
      , div []
        [ a [ style [("color", "grey"), ("margin-right", "0.5em")] ]
          [ label [ class "btn", for "pictures", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach pictures" ]
          , input [ id "pictures", style [("display", "none")], type_ "file", accept "image/*" ] []
          ]
        , a [ style [("color", "grey"), ("margin-left", "0.5em")] ]
          [ label [ class "btn", for "video", style [("padding", "0 0.8em"), ("font-size", "80%"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Attach video" ]
          , input [ id "video", style [("display", "none")], type_ "file", accept "video/*" ] []
          ]
        ]
      , label [ style [("margin-top", "1.5em"), ("float", "left"), ("font-size", "80%")], for "idea-price" ] [ text "How much do you value your idea/project?" ], br[][], span [ style [("margin-top", "-0.5em"), ("float", "left"), ("font-size", "80%"), ("color", "grey")] ] [ text "(Please, mention the currency)"]
      , input [ value newIdeaData.ideaPrice, onInput OnNewIdeaPriceInput, style [("font-size", "80%"), ("width", "100%"), ("float", "left"), ("border-radius", "10%"), ("border", "2px solid lightgrey")], id "idea-price" ] []
      , ndaSection
      , br[][], br[][]
      , p [ style [("color", "red"), ("font-size", "90%")] ] [ text newIdeaData.error ]
      , videoInfo
      , picturesInfo
      , button [ onClick OnNewIdeaSubmit, style [("width", "40%"), ("margin-top", "3em"), ("font-size", "90%"), ("color", "black"), ("background", "gold"), ("border", "none")] ] [ text "Post an Idea" ]
      ]
    ]


-- LIST ITEMS


industriesList : List (Html Msg)
industriesList =
  List.map industriesListItem IL.industries


industriesListItem : String -> Html Msg
industriesListItem industry =
  option [ value industry ] [ text industry ]
