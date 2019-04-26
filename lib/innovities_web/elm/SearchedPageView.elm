module SearchedPageView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)




searchedPageView : Model -> Html Msg
searchedPageView model =
  let
    searchedDataAll = model.searchedData
    searchedPosts = searchedDataAll.posts
    searchedIdeas = searchedDataAll.ideas
    searchedInnovators = searchedDataAll.innovators
    searchedOrganizations = searchedDataAll.organizations

    postsWrapped =
      List.map (ideasListItem model) searchedPosts

    postsView =
      if ((List.length searchedPosts) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Posts" ]
          , div [] (postsWrapped)
          ]
      else
        span[][]


    ideasWrapped =
      List.map (realIdeasListItem model) searchedIdeas

    ideasView =
      if ((List.length searchedIdeas) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Ideas" ]
          , div [] (ideasWrapped)
          ]
      else
        span[][]


    innovatorsWrapped =
      List.map (innovatorsListItem model) searchedInnovators

    innovatorsView =
      if ((List.length searchedInnovators) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Innovators" ]
          , div [] (innovatorsWrapped)
          ]
      else
        span[][]


    organizationsWrapped =
      List.map (organizationsListItem model) searchedOrganizations

    organizationsView =
      if ((List.length searchedOrganizations) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Organizations" ]
          , div [] (organizationsWrapped)
          ]
      else
        span[][]


    emptyView =
      if (((List.length searchedPosts) == 0) && ((List.length searchedIdeas) == 0)
        && ((List.length searchedInnovators) == 0) && ((List.length searchedOrganizations) == 0)) then
          p [ style [("color", "black")] ] [ text "Nothing found!" ]
      else
        span[][]

  in
    div [ class "uk-width-3-5 uk-flex uk-flex-column", style [("width", "50%"), ("margin-left", "10vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h2 [] [ text "Searched" ]
      , postsView
      , br[][]
      , ideasView
      , br[][]
      , innovatorsView
      , br[][]
      , organizationsView
      , emptyView
      ]
    ]



searchedPageViewTab : Model -> Html Msg
searchedPageViewTab model =
  let
    searchedDataAll = model.searchedData
    searchedPosts = searchedDataAll.posts
    searchedIdeas = searchedDataAll.ideas
    searchedInnovators = searchedDataAll.innovators
    searchedOrganizations = searchedDataAll.organizations

    postsWrapped =
      List.map (ideasListItem model) searchedPosts

    postsView =
      if ((List.length searchedPosts) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Posts" ]
          , div [] (postsWrapped)
          ]
      else
        span[][]


    ideasWrapped =
      List.map (realIdeasListItem model) searchedIdeas

    ideasView =
      if ((List.length searchedIdeas) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Ideas" ]
          , div [] (ideasWrapped)
          ]
      else
        span[][]


    innovatorsWrapped =
      List.map (innovatorsListItem model) searchedInnovators

    innovatorsView =
      if ((List.length searchedInnovators) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Innovators" ]
          , div [] (innovatorsWrapped)
          ]
      else
        span[][]


    organizationsWrapped =
      List.map (organizationsListItem model) searchedOrganizations

    organizationsView =
      if ((List.length searchedOrganizations) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Organizations" ]
          , div [] (organizationsWrapped)
          ]
      else
        span[][]


    emptyView =
      if (((List.length searchedPosts) == 0) && ((List.length searchedIdeas) == 0)
        && ((List.length searchedInnovators) == 0) && ((List.length searchedOrganizations) == 0)) then
          p [ style [("color", "black")] ] [ text "Nothing found!" ]
      else
        span[][]

  in
    div [ class "uk-width-5-5 uk-flex uk-flex-column", style [("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h2 [] [ text "Searched" ]
      , postsView
      , br[][]
      , ideasView
      , br[][]
      , innovatorsView
      , br[][]
      , organizationsView
      , emptyView
      ]
    ]



searchedPageViewMobile : Model -> Html Msg
searchedPageViewMobile model =
  let
    searchedDataAll = model.searchedData
    searchedPosts = searchedDataAll.posts
    searchedIdeas = searchedDataAll.ideas
    searchedInnovators = searchedDataAll.innovators
    searchedOrganizations = searchedDataAll.organizations

    postsWrapped =
      List.map (ideasListItemMobile model) searchedPosts

    postsView =
      if ((List.length searchedPosts) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Posts" ]
          , div [] (postsWrapped)
          ]
      else
        span[][]


    ideasWrapped =
      List.map (realIdeasListItem model) searchedIdeas

    ideasView =
      if ((List.length searchedIdeas) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Ideas" ]
          , div [] (ideasWrapped)
          ]
      else
        span[][]


    innovatorsWrapped =
      List.map (innovatorsListItem model) searchedInnovators

    innovatorsView =
      if ((List.length searchedInnovators) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Innovators" ]
          , div [] (innovatorsWrapped)
          ]
      else
        span[][]


    organizationsWrapped =
      List.map (organizationsListItem model) searchedOrganizations

    organizationsView =
      if ((List.length searchedOrganizations) > 0) then
        div[]
          [ h4 [ style [("float", "left")] ] [ text "Organizations" ]
          , div [] (organizationsWrapped)
          ]
      else
        span[][]


    emptyView =
      if (((List.length searchedPosts) == 0) && ((List.length searchedIdeas) == 0)
        && ((List.length searchedInnovators) == 0) && ((List.length searchedOrganizations) == 0)) then
          p [ style [("color", "black")] ] [ text "Nothing found!" ]
      else
        span[][]

  in
    div [ class "uk-width-5-5 uk-flex uk-flex-column", style [("width", "100vw"), ("padding-top", "0.5em"), ("color", "black"), ("border", "1px solid red"), ("margin-right", "0.5em"), ("min-height", "85vh"), ("height", "85vh"), ("overflow", "auto")] ]
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ class "uk-card uk-card-default uk-card-body" ]
      [ h2 [] [ text "Searched" ]
      , postsView
      , br[][]
      , ideasView
      , br[][]
      , innovatorsView
      , br[][]
      , organizationsView
      , emptyView
      ]
    ]



-- LIST ITEMS


innovatorsListItem : Model -> InnovatorExtended -> Html Msg
innovatorsListItem model innovatorData =
  let

    avatar =
      if (String.isEmpty innovatorData.pic_uri) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        innovatorData.pic_uri

    authorName = innovatorData.name
    authorDesc = innovatorData.description
    about = innovatorData.about_me

    ideasCount = innovatorData.ideas_count
    country = innovatorData.country
    rating = innovatorData.rating
    username = innovatorData.username

    innovatorId = innovatorData.id

  in
    div []
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "10%"), ("height", "auto")], class "marginedUpRoundedImage", src avatar ] []
        , div [ class "uk-flex uk-flex-column", style [("width", "75%"), ("float", "left")] ]
          [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ a [ onClick (OnSeeOtherInnovator innovatorData) ] [ text authorName ] ]
          , p [ style [("text-align", "left"),  ("margin-top", "-1em"), ("color", "grey"), ("font-size", "80%")] ] [ text authorDesc ]
          ]
        , img [ style [("width", "5%"), ("height", "auto")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text about ]
        , p [ style [("font-style", "italic"), ("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text ("Ideas: " ++ (toString ideasCount)) ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text country ]
          , span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text (toString rating) ]
          , span [ style [("color", "blue"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text username ]
          ]
        ]
      ]



organizationsListItem : Model -> OrganizationExtended -> Html Msg
organizationsListItem model organizationData =
  let

    avatar =
      if (String.isEmpty organizationData.pic_uri) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        organizationData.pic_uri

    authorName = organizationData.name
    authorDesc = organizationData.description
    about = organizationData.about_us

    website = organizationData.webpage
    country = organizationData.country
    industry = organizationData.industry
    username = organizationData.username

    organizationId = organizationData.id

  in
    div []
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "10%"), ("height", "auto")], class "marginedUpRoundedImage", src avatar ] []
        , div [ class "uk-flex uk-flex-column", style [("width", "75%"), ("float", "left")] ]
          [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ a [ onClick (OnSeeOtherOrganization organizationData) ] [ text authorName ] ]
          , p [ style [("text-align", "left"),  ("margin-top", "-1em"), ("color", "grey"), ("font-size", "80%")] ] [ text authorDesc ]
          ]
        , img [ style [("width", "5%"), ("height", "auto")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text about ]
        , p [ style [("font-style", "italic"), ("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text website ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text country ]
          , span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text industry ]
          , span [ style [("color", "blue"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text username ]
          ]
        ]
      ]


realIdeasListItem : Model -> IdeaData -> Html Msg
realIdeasListItem model ideaData =
  let

    avatar =
      if (String.isEmpty ideaData.innovator_pic) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else
        ideaData.innovator_pic

    ideaDesc = ideaData.short_description
    ideaName = ideaData.idea_name

    authorName = ideaData.innovator_name
    industry = ideaData.industry
    tags = ideaData.tags
    price = ideaData.price

  in
    div []
      [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
      , div [ class "uk-card uk-card-default uk-card-body", style [("padding", "0.5em")] ]
        [ img [ style [("margin-top", "0"), ("float", "left"), ("width", "10%"), ("height", "auto")], class "marginedUpRoundedImage", src avatar ] []
        , div [ class "uk-flex uk-flex-column", style [("width", "75%"), ("float", "left")] ]
          [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ a [ onClick (OnViewIdeaPageSwitch ideaData) ] [ text ideaName ] ] ]
        , img [ style [("width", "5%"), ("height", "auto")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text ideaDesc ]
        , p [ style [("font-style", "italic"), ("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text authorName ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text price ]
          , span [ style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ text industry ]
          , span [ style [("font-style", "italic"), ("color", "blue"), ("float", "left"), ("font-size", "85%")] ] [ text tags ]
          ]
        ]
      ]



ideasListItem : Model -> ExtendedPostData -> Html Msg
ideasListItem model postData =
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
        , img [ style [("width", "5%"), ("height", "auto")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text postMessage ]
        , pic
        , p [ style [("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text (toString(postLikes) ++ " likes") ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ a [ onClick (OnPostLikeClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: heart; ratio: 0.7" ] [], text "Like" ]
          , a [ onClick (OnPostCommentsClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: comment; ratio: 0.7" ] [], text "Comment" ]
          , a [ onClick (OnSharePostOnFacebook postMessage), style [("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: social; ratio: 0.7" ] [], text "Share" ]
          ]
        , commentsView
        ]
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
            ( List.map postCommentsItemMobile model.currentPostComments )
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
        , img [ style [("width", "5%"), ("height", "auto")], src "/images/menu_icon.png" ] []
        , p [ style [ ("width", "100%"), ("padding-right", "13%"), ("text-align", "left"), ("color", "black"), ("font-size", "90%")] ] [ text postMessage ]
        , pic
        , p [ style [("margin-bottom", "-0.5em"), ("width", "100%"), ("text-align", "left"), ("color", "grey"), ("font-size", "85%")] ] [ text (toString(postLikes) ++ " likes") ]
        , img [ src "/images/grey_divider.png" ] []
        , div []
          [ a [ onClick (OnPostLikeClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: heart; ratio: 0.7" ] [], text "Like" ]
          , a [ onClick (OnPostCommentsClicked postId), style [("margin-right", "20px"), ("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: comment; ratio: 0.7" ] [], text "Comment" ]
          , a [ onClick (OnSharePostOnFacebook postMessage), style [("color", "grey"), ("float", "left"), ("font-size", "85%")] ] [ span [ style [("margin-right", "7px")], attribute "uk-icon" "icon: social; ratio: 0.7" ] [], text "Share" ]
          ]
        , commentsView
        ]
      ]



postCommentsItemMobile : PostCommentData -> Html Msg
postCommentsItemMobile item =
  li [ style [("border", "1px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
  [ div [ style [("color", "black")], class "uk-flex uk-flex-column" ]
    [ span [ style [("font-size", "90%")] ] [ text item.author_name ]
    , span [ style [("font-size", "90%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.input_date ]
    , span [ style [("color", "grey")] ] [ text "___________" ]
    , span [ style [("font-size", "80%")] ] [ text item.body ]
    ]
  ]



postCommentsItem : PostCommentData -> Html Msg
postCommentsItem item =
  li [ style [("border", "1px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
  [ div [ style [("color", "black")], class "uk-flex uk-child-width-1-2" ]
    [ span [ style [("font-size", "90%")] ] [ text item.author_name ]
    , span [ style [("font-size", "90%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.input_date ]
    ]
  , div [ style [("color", "black")] ]
    [ span [ style [("font-size", "80%")] ] [ text item.body ] ]
  ]
