module TopMembersList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Utils exposing (..)

organizationsList : Model -> Html Msg
organizationsList model =
  let
    topOrganizations = model.topOrganizations
    organization1 =
      if (List.length topOrganizations) > 0 then
        makeRealOrganization (List.head topOrganizations)
      else
        defaultOrganization

    remaining = List.drop 1 topOrganizations
    organization2 =
      if (List.length remaining) > 0 then
        makeRealOrganization (List.head remaining)
      else
        defaultOrganization

    remaining2 = List.drop 1 remaining
    organization3 =
      if (List.length remaining2) > 0 then
        makeRealOrganization (List.head remaining2)
      else
        defaultOrganization

  in
    div [ id "organizations", class "responsiveVisibility" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "Organisations" ]
      , ul [ class "tarrifPlansStyle", style [("width", "75%"), ("margin-top", "4em")] ]
        [ organizationsListItem model organization1.id organization1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization1.country organization1.pic_uri
        , organizationsListItem model organization2.id organization2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization2.country organization2.pic_uri
        , organizationsListItem model organization3.id organization3.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization3.country organization3.pic_uri
        ]
      ]

organizationsListTab : Model -> Html Msg
organizationsListTab model =
  let
    topOrganizations = model.topOrganizations
    organization1 =
      if (List.length topOrganizations) > 0 then
        makeRealOrganization (List.head topOrganizations)
      else
        defaultOrganization

    remaining = List.drop 1 topOrganizations
    organization2 =
      if (List.length remaining) > 0 then
        makeRealOrganization (List.head remaining)
      else
        defaultOrganization

    remaining2 = List.drop 1 remaining
    organization3 =
      if (List.length remaining2) > 0 then
        makeRealOrganization (List.head remaining2)
      else
        defaultOrganization
  in
    div [ id "organizations-t", class "responsiveVisibilityTab" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "Organisations" ]
      , ul [ class "tarrifPlansStyle", style [("width", "100vw"), ("margin-top", "4em")] ]
        [ organizationsListItemTab model organization1.id organization1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization1.country organization1.pic_uri
        , organizationsListItemTab model organization2.id organization2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization2.country organization2.pic_uri
        , organizationsListItemTab model organization3.id organization3.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization3.country organization3.pic_uri
        ]
      ]

organizationsListItem : Model -> Int -> String -> String -> String -> String -> Html Msg
organizationsListItem model id name bio country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    pic =
      if (String.isEmpty picUri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name True)
  in
    li [ style [("float", "left"), ("margin-left", "3em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "16em"), ("height", "23em")] ]
        [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail; ratio: 2", style [("margin-left", "0.4em"), ("color", "gold"), ("float", "left")] ] [] ]
        , img [ class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "110%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , p [ class "smallWhiteCentered", style [("font-size", "small"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text bio ]
        , addressView country False
        ]
      ]

organizationsListItemTab : Model -> Int -> String -> String -> String -> String -> Html Msg
organizationsListItemTab model id name bio country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    bioLength = 190

    bioProcessed =
      if (String.length bio) > bioLength then
        (String.slice 0 bioLength bio) ++ "..."
      else
        bio

    pic =
      if (String.isEmpty picUri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name True)
  in
    li [ style [("float", "left"), ("margin-left", "1em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "26vw"), ("height", "23em")] ]
        [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail", style [("margin-left", "0.4em"), ("color", "gold"), ("float", "left")] ] [] ]
        , img [ style [("margin-top", "-2em"), ("margin-right", "1.5em")], class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "100%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , p [ class "smallWhiteCentered", style [("font-size", "90%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text bioProcessed ]
        , addressView country False
        ]
      ]

organizationsListMobile : Model -> Html Msg
organizationsListMobile model =
  let

    topOrganizations = model.topOrganizations
    organization1 =
      if (List.length topOrganizations) > 0 then
        makeRealOrganization (List.head topOrganizations)
      else
        defaultOrganization

    remaining = List.drop 1 topOrganizations
    organization2 =
      if (List.length remaining) > 0 then
        makeRealOrganization (List.head remaining)
      else
        defaultOrganization

    vis =
      if model.mobileOrganizationsView then
        ("display", "initial")
      else
        ("display", "none")
  in
    div [ id "organizations", class "responsiveVisibilityMobile", style [ vis, ("position", "absolute"), ("bottom", "10px"), ("left", "0")] ]
      [ --h5 [ style [("font-weight", "bold"), ("color", "gold")] ] [ text "Organisations" ]
        ul [ class "tarrifPlansStyle", style [("width", "100vw"), ("margin-top", "4em")] ]
        [ organizationsListItemMobile model organization1.id True organization1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization1.country organization1.pic_uri
        , organizationsListItemMobile model organization2.id False organization2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." organization2.country organization2.pic_uri
        ]
      ]

organizationsListItemMobile : Model -> Int -> Bool -> String -> String -> String -> String -> Html Msg
organizationsListItemMobile model id firstOne name bio country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    leftMargined =
      if firstOne then
        ("margin-left", "0")
      else
        ("margin-left", "1em")

    bioLength = 200
    bioProcessed =
      if (String.length bio) > bioLength then
        (String.slice 0 bioLength bio) ++ "..."
      else
        bio

    pic =
      if (String.isEmpty picUri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name True)
  in
    li [ style [("float", "left"), leftMargined] ]
      [ div [ class "tarrifBorderedItem", style [("width", "40vw"), ("height", "64vh")] ]
        [ img [ style [("margin-right", "0")], class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "90%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , p [ class "smallWhiteCentered", style [("font-size", "75%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text bioProcessed ]
        , addressView country False
        , div [ style [("background", "darkslategray"), ("margin-top", "1em")] ]
          [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail", style [("color", "gold")] ] [] ] ]
        ]
      ]


innovatorsList : Model -> Html Msg
innovatorsList model =
  let
    topInnovators = model.topInnovators
    innovator1 =
      if (List.length topInnovators) > 0 then
        makeRealInnovator (List.head topInnovators)
      else
        defaultInnovator

    remaining = List.drop 1 topInnovators
    innovator2 =
      if (List.length remaining) > 0 then
        makeRealInnovator (List.head remaining)
      else
        defaultInnovator

    remaining2 = List.drop 1 remaining
    innovator3 =
      if (List.length remaining2) > 0 then
        makeRealInnovator (List.head remaining2)
      else
        defaultInnovator
  in
    div [ id "innovators", class "responsiveVisibility" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "Innovators" ]
      , ul [ class "tarrifPlansStyle", style [("width", "75%"), ("margin-top", "4em")] ]
        [ innovatorsListItem model innovator1.id innovator1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator1.rating innovator1.country innovator1.pic_uri
        , innovatorsListItem model innovator2.id innovator2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator2.rating innovator2.country innovator2.pic_uri
        , innovatorsListItem model innovator3.id innovator3.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator3.rating innovator3.country innovator3.pic_uri
        ]
      ]

innovatorsListTab : Model -> Html Msg
innovatorsListTab model =
  let
    topInnovators = model.topInnovators
    innovator1 =
      if (List.length topInnovators) > 0 then
        makeRealInnovator (List.head topInnovators)
      else
        defaultInnovator

    remaining = List.drop 1 topInnovators
    innovator2 =
      if (List.length remaining) > 0 then
        makeRealInnovator (List.head remaining)
      else
        defaultInnovator

    remaining2 = List.drop 1 remaining
    innovator3 =
      if (List.length remaining2) > 0 then
        makeRealInnovator (List.head remaining2)
      else
        defaultInnovator
  in
    div [ id "innovators-t", class "responsiveVisibilityTab" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "Innovators" ]
      , ul [ class "tarrifPlansStyle", style [("width", "100vw"), ("margin-top", "4em")] ]
        [ innovatorsListItemTab model innovator1.id innovator1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator1.rating innovator1.country innovator1.pic_uri
        , innovatorsListItemTab model innovator2.id innovator2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator2.rating innovator2.country innovator2.pic_uri
        , innovatorsListItemTab model innovator3.id innovator3.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator3.rating innovator3.country innovator3.pic_uri
        ]
      ]

innovatorsListItem : Model -> Int -> String -> String -> Int -> String -> String -> Html Msg
innovatorsListItem model id name bio rating country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    pic =
      if (String.isEmpty picUri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name False)
  in
    li [ style [("float", "left"), ("margin-left", "3em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "16em"), ("height", "23em")] ]
        [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail; ratio: 2", style [("margin-left", "0.4em"), ("color", "gold"), ("float", "left")] ] [] ]
        , img [ class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "110%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , p [ class "smallWhiteCentered", style [("font-size", "small"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text bio ]
        , ratingStarsView rating True
        , addressView country True
        ]
      ]

innovatorsListItemTab : Model -> Int -> String -> String -> Int -> String -> String -> Html Msg
innovatorsListItemTab model id name bio rating country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    bioLength = 230

    processedBio =
      if (String.length bio > bioLength) then
        (String.slice 0 bioLength bio) ++ "..."
      else
        bio

    pic =
      if (String.isEmpty picUri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name False)
  in
    li [ style [("float", "left"), ("margin-left", "1em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "26vw"), ("height", "23em")] ]
        [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail", style [("margin-left", "0.4em"), ("color", "gold"), ("float", "left")] ] [] ]
        , img [ style [("margin-top", "-2em"), ("margin-right", "1.5em")], class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "100%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , p [ class "smallWhiteCentered", style [("font-size", "80%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text processedBio ]
        , ratingStarsView rating True
        , addressView country True
        ]
      ]

innovatorsListMobile : Model -> Html Msg
innovatorsListMobile model =
  let
    vis =
      if model.mobileIdeaGeneratorsView then
        ("display", "initial")
      else
        ("display", "none")

    topInnovators = model.topInnovators
    innovator1 =
      if (List.length topInnovators) > 0 then
        makeRealInnovator (List.head topInnovators)
      else
        defaultInnovator

    remaining = List.drop 1 topInnovators
    innovator2 =
      if (List.length remaining) > 0 then
        makeRealInnovator (List.head remaining)
      else
        defaultInnovator


  in
    div [ id "innovators", class "responsiveVisibilityMobile", style [vis, ("position", "absolute"), ("bottom", "10px"), ("left", "0"), ("margin-top", "-5em")] ]
      [ --h5 [ style [("color", "gold"), ("font-weight", "bold")] ] [ text "Innovators" ]
        ul [ class "tarrifPlansStyle", style [("width", "100vw"), ("margin-top", "4em")] ]
        [ innovatorsListItemMobile model innovator1.id True innovator1.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator1.rating innovator1.country innovator1.pic_uri
        , innovatorsListItemMobile model innovator2.id False innovator2.name "He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were." innovator2.rating innovator2.country innovator2.pic_uri
        ]
      ]

innovatorsListItemMobile : Model -> Int -> Bool -> String -> String -> Int -> String -> String -> Html Msg
innovatorsListItemMobile model id firstOne name bio rating country picUri =
  let
    currentUser = model.loggedInMember
    mailVisibility =
      if (currentUser.id == 0) then
        ("visibility", "hidden")
      else
        ("visibility", "visible")

    leftMargined =
      if firstOne then
        ("margin-left", "0")
      else
        ("margin-left", "1em")

    bioLength = 200
    bioProcessed =
      if (String.length bio) > bioLength then
        (String.slice 0 bioLength bio) ++ "..."
      else
        bio

    pic =
      if (String.isEmpty picUri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        picUri

    receiverData = (ChatMessageReceiverData id name False)
  in
    li [ style [leftMargined, ("float", "left")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "40vw"), ("height", "67.5vh")] ]
        [ img [ style [("margin-right", "0")], class "marginedUpRoundedImage", src pic ] []
        , p [ class "smallWhiteCentered", style [("font-size", "90%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text name ]
        , addressView country False
        , p [ class "smallWhiteCentered", style [("font-size", "75%"), ("margin-left", "0.8em"), ("margin-right", "0.8em")] ] [ text bioProcessed ]
        , ratingStarsView rating False
        , div [ style [("background", "darkslategray"), ("margin-top", "1em")] ]
          [ a [ style [ mailVisibility ], onClick (OnToggleChatWindow (Just receiverData)) ] [ span [ attribute "uk-icon" "icon: mail", style [("color", "gold")] ] [] ] ]
        ]
      ]

addressView : String -> Bool -> Html Msg
addressView country forInnovators =
  let
    rightFloat =
      style [ ("float", "right"), ("margin-right", "0.8em"), ("margin-down", "0.8em") ]
    centerAlign =
      style [ ("margin-down", "0.8em") ]
  in
    div [ if forInnovators then rightFloat else centerAlign ]
      [ span [ attribute "uk-icon" "location", style [("color", "gold")] ] []
      , span [ style [("font-size", "small"), ("color", "gold") ] ] [ text country ]
      ]

ratingStarsView : Int -> Bool -> Html Msg
ratingStarsView rating leftFloat =
  let
    styled =
      style [("color", "gold")]
    styledDefault =
      style [("color", "white")]

    lefted =
      if leftFloat then
        ("float", "left")
      else
        ("float", "none")
  in
    div [ style [lefted, ("margin-left", "0.8em"), ("margin-down", "0.8em")] ]
      [ span [ attribute "uk-icon" "star", if rating >= 1 then styled else styledDefault ] []
      , span [ attribute "uk-icon" "star", if rating >= 2 then styled else styledDefault ] []
      , span [ attribute "uk-icon" "star", if rating >= 3 then styled else styledDefault ] []
      , span [ attribute "uk-icon" "star", if rating >= 4 then styled else styledDefault ] []
      , span [ attribute "uk-icon" "star", if rating >= 5 then styled else styledDefault ] []
      ]
