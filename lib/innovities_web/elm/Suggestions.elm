module Suggestions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



rightColumnView : Model -> Html Msg
rightColumnView model =
  let
    suggestions =
      List.map (suggestionsListItem model) model.suggestedUsers
  in
    div []
    [ img [ style [("width", "100%"), ("height", "0.5em")], src "/images/bold_divider.png" ] []
    , div [ style [("padding", "1em")] ]
      [ h5 [ style [("text-align", "left"), ("color", "black")] ] [ text "Suggestions" ]
      , ul [ style [("overflow", "auto"), ("list-style-type", "none"), ("padding", "0"), ("margin", "0")] ]
        ( suggestions )
      ]
    ]


suggestionsTabView : Model -> Html Msg
suggestionsTabView model =
  let
    suggestions =
      List.map (suggestionsListItemForSmallerScreens model) model.suggestedUsers
  in
    div []
    [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
    , div [ style [("padding", "1em")] ]
      [ h5 [ style [("text-align", "left"), ("color", "black"), ("margin-top", "-3em")] ] [ text "Suggestions" ]
      , ul [ style [("overflow", "auto"), ("list-style-type", "none"), ("padding", "0"), ("margin", "0")] ]
        ( suggestions )
      ]
    ]



suggestionsMobileView : Model -> Html Msg
suggestionsMobileView model =
  let
    suggestions =
      List.map (suggestionsListItemForSmallestScreens model) model.suggestedUsers
  in
    div []
    [ img [ style [("width", "100%"), ("height", "0.5em"), ("margin-top", "-5.5em")], src "/images/bold_divider.png" ] []
    , div [ style [("padding", "0.3em")] ]
      [ h5 [ style [("text-align", "left"), ("color", "black"), ("margin-top", "-3em")] ] [ text "Suggestions" ]
      , ul [ style [("overflow", "auto"), ("list-style-type", "none"), ("padding", "0"), ("margin", "0")] ]
        ( suggestions )
      ]
    ]


suggestionsListItem : Model -> SuggestedUser -> Html Msg
suggestionsListItem model suggestedUser =
  let
    currentUser = model.loggedInMember

    pic =
      if ((String.isEmpty suggestedUser.picture) && (currentUser.isOrganization)) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else if ((String.isEmpty suggestedUser.picture) && (not currentUser.isOrganization)) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        suggestedUser.picture

    name =
      if ((String.isEmpty suggestedUser.name) && (currentUser.isOrganization)) then
        "Name Surename"
      else if ((String.isEmpty suggestedUser.name) && (not currentUser.isOrganization)) then
        "Company Name"
      else
        suggestedUser.name

    desc =
      if ((String.isEmpty suggestedUser.description) && (currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short bio of your yet to be discovered awesome innovator!"
      else if ((String.isEmpty suggestedUser.description) && (not currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short story about your next yet to be discovered great company!"
      else
        suggestedUser.description


    buttonClickable =
      if (suggestedUser.id == 0) then
        (attribute "disabled" "")
      else
        (attribute "enabled" "")


  in
    div [ style [("margin-bottom", "3em")] ]
    [ img [ style [("float", "left"), ("margin-right", "0.5em"), ("margin-top", "0"), ("width", "20%"), ("height", "auto")], class "marginedUpRoundedImage", src pic ] []
    , div [ class "uk-flex uk-flex-column" ]
      [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ text name ]
      , p [ style [("text-align", "left"),  ("margin-top", "-1em"), ("color", "grey"), ("font-size", "80%")] ] [ text desc ]
      , button [ onClick (OnMakeConnectionInitiated suggestedUser.id), buttonClickable, style [("float", "left"), ("width", "50%"), ("margin-top", "-0.5em"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Connect" ]
      ]
    ]


suggestionsListItemForSmallerScreens : Model -> SuggestedUser -> Html Msg
suggestionsListItemForSmallerScreens model suggestedUser =
  let
    currentUser = model.loggedInMember

    pic =
      if ((String.isEmpty suggestedUser.picture) && (currentUser.isOrganization)) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else if ((String.isEmpty suggestedUser.picture) && (not currentUser.isOrganization)) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        suggestedUser.picture

    name =
      if ((String.isEmpty suggestedUser.name) && (currentUser.isOrganization)) then
        "Name Surename"
      else if ((String.isEmpty suggestedUser.name) && (not currentUser.isOrganization)) then
        "Company Name"
      else
        suggestedUser.name

    desc =
      if ((String.isEmpty suggestedUser.description) && (currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short bio of your yet to be discovered awesome innovator!"
      else if ((String.isEmpty suggestedUser.description) && (not currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short story about your next yet to be discovered great company!"
      else
        suggestedUser.description


    buttonClickable =
      if (suggestedUser.id == 0) then
        (attribute "disabled" "")
      else
        (attribute "enabled" "")

  in
    div [ style [("margin-bottom", "3em")] ]
    [ div [ class "uk-flex" ]
      [ div [ class "uk-width-1-5" ]
        [ img [ style [("float", "left"), ("margin-right", "0.5em"), ("margin-top", "0")], class "marginedUpRoundedImage", src pic ] [] ]
      , div [ class "uk-width-3-5" ]
        [ div [ class "uk-flex uk-flex-column" ]
          [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ text name ]
          , p [ style [("text-align", "left"),  ("margin-top", "-1em"), ("color", "grey"), ("font-size", "80%")] ] [ text desc ]
          ]
        ]
      , div [ class "uk-width-1-5" ]
        [ button [ onClick (OnMakeConnectionInitiated suggestedUser.id), buttonClickable, style [("float", "left"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Connect" ] ]
      ]
    ]


suggestionsListItemForSmallestScreens : Model -> SuggestedUser -> Html Msg
suggestionsListItemForSmallestScreens model suggestedUser =
  let
    currentUser = model.loggedInMember

    pic =
      if ((String.isEmpty suggestedUser.picture) && (currentUser.isOrganization)) then
        "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg"
      else if ((String.isEmpty suggestedUser.picture) && (not currentUser.isOrganization)) then
        "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png"
      else
        suggestedUser.picture

    name =
      if ((String.isEmpty suggestedUser.name) && (currentUser.isOrganization)) then
        "Name Surename"
      else if ((String.isEmpty suggestedUser.name) && (not currentUser.isOrganization)) then
        "Company Name"
      else
        suggestedUser.name

    desc =
      if ((String.isEmpty suggestedUser.description) && (currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short bio of your yet to be discovered awesome innovator!"
      else if ((String.isEmpty suggestedUser.description) && (not currentUser.isOrganization)
          && (suggestedUser.id == 0)) then
        "Short story about your next yet to be discovered great company!"
      else
        suggestedUser.description


    buttonClickable =
      if (suggestedUser.id == 0) then
        (attribute "disabled" "")
      else
        (attribute "enabled" "")

  in
    div [ style [("margin-bottom", "3em")] ]
    [ img [ style [("float", "left"), ("margin-right", "0.5em"), ("margin-top", "0"), ("width", "20%"), ("height", "auto")], class "marginedUpRoundedImage", src pic ] []
    , div [ class "uk-flex uk-flex-column" ]
      [ p [ style [("text-align", "left"),  ("font-weight", "bold"), ("color", "black"), ("font-size", "90%")] ] [ text name ]
      , p [ style [("text-align", "left"),  ("margin-top", "-1.5em"), ("color", "grey"), ("font-size", "80%")] ] [ text desc ]
      , button [ onClick (OnMakeConnectionInitiated suggestedUser.id), buttonClickable, style [("font-size", "75%"), ("float", "left"), ("width", "50%"), ("margin-top", "-1em"), ("border", "2px solid gold"), ("color", "black"), ("background", "white")] ] [ text "Connect" ]
      ]
    ]
