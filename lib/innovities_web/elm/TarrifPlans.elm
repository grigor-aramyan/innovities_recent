module TarrifPlans exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)

organizationsPlan : Model -> Html Msg
organizationsPlan model =
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
        Models.Arm -> "D 104,690/ամիս"
        Models.Eng -> "$216/mth"

    my =
      case lang of
        Models.Arm -> "D 1,210,490/տարի*"
        Models.Eng -> "$2496/yr*"

    ms =
      case lang of
        Models.Arm -> "*խնայեք D 45,790"
        Models.Eng -> "*save $96"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "organizations-pricing", class "responsiveVisibility" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "For Organizations" ]
      , br[][]
      , ul [ class "tarrifPlansStyle" ]
          [ organizationsTarrifListItem model True "Basic" bm by bs "5" "15" "Current country" OnSubscribeBasicOrganization
          , organizationsTarrifListItem model False "Plus" pm py ps "10" "30" "Current region" OnSubscribePlusOrganization
          , organizationsTarrifListItem model False "Premium" pmm pmy pms "20" "50" "Current continent" OnSubscribePremiumOrganization
          , li [ style [("float", "left"), ("margin-left", "2em")] ]
              [ div [ class "tarrifBorderedItem", style [("height", "28.5em")] ]
                  [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("background", "navy"), ("color", "white"), ("width", "4.5em"), ("margin-left", "1.5em")] ] [ text "Max" ]
                  , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
                  , br [][]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text mm ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text my ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text ms ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
                  , p [ class "marginedSkyblue" ] [ text "All" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
                  , p [ class "marginedSkyblue" ] [ text "Up to 50" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "120%"), ("margin-top", "1em") ] ] [ text "Unlimited" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "Worldwide" ]
                  , button [ onClick OnSubscribeMaxOrganization, class "subscribeButtonStyle" ] [ text "Subscribe" ]
                  ]
              ]
          ]
        , div [ class "wantMoreStyle" ]
            [ p [ style [("margin", "auto"), ("background", "teal"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
            , a [ href "#contacts", class "subscribeButtonStyle", style [("padding", "0.3em")] ] [ text "Contact us" ]
            ]
      ]

organizationsPlanTab : Model -> Html Msg
organizationsPlanTab model =
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
        Models.Arm -> "D 104,690/ամիս"
        Models.Eng -> "$216/mth"

    my =
      case lang of
        Models.Arm -> "D 1,210,490/տարի*"
        Models.Eng -> "$2496/yr*"

    ms =
      case lang of
        Models.Arm -> "*խնայեք D 45,790"
        Models.Eng -> "*save $96"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "organizations-pricing-t", class "responsiveVisibilityTab" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "5em")] ] [ text "For Organizations" ]
      , br[][]
      , ul [ class "tarrifPlansStyle", style [("width", "100vw")] ]
          [ organizationsTarrifListItemTab model True "Basic" bm by bs "5" "15" "Current country" OnSubscribeBasicOrganization
          , organizationsTarrifListItemTab model False "Plus" pm py ps "10" "30" "Current region" OnSubscribePlusOrganization
          , organizationsTarrifListItemTab model False "Premium" pmm pmy pms "20" "50" "Current continent" OnSubscribePremiumOrganization
          , li [ style [("float", "left"), ("margin-left", "1em")] ]
              [ div [ class "tarrifBorderedItem", style [("height", "28.5em"), ("width", "20vw")] ]
                  [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("background", "navy"), ("color", "white"), ("width", "4.5em"), ("margin-left", "1.5vw")] ] [ text "Max" ]
                  , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
                  , br [][]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text mm ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text my ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text ms ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
                  , p [ class "marginedSkyblue" ] [ text "All" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
                  , p [ class "marginedSkyblue" ] [ text "Up to 50" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "100%"), ("margin-top", "1em") ] ] [ text "Unlimited" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "90%") ] ] [ text "Worldwide" ]
                  , button [ onClick OnSubscribeMaxOrganization, class "subscribeButtonStyle" ] [ text "Subscribe" ]
                  ]
              ]
          ]
        , div [ class "wantMoreStyle" ]
            [ p [ style [("margin", "auto"), ("background", "teal"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
            , a [ href "#contacts", class "subscribeButtonStyle", style [("padding", "0.3em")] ] [ text "Contact us" ]
            ]
      ]

organizationsPlanMobile : Model -> Html Msg
organizationsPlanMobile model =
  let
    vis =
      if model.mobileTarrifPlansView then
        ("display", "initial")
      else
        ("display", "none")

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
        Models.Arm -> "D 104,690/ամիս"
        Models.Eng -> "$216/mth"

    my =
      case lang of
        Models.Arm -> "D 1,210,490/տարի*"
        Models.Eng -> "$2496/yr*"

    ms =
      case lang of
        Models.Arm -> "*խնայեք D 45,790"
        Models.Eng -> "*save $96"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "organizations-pricing", class "responsiveVisibilityMobile", style [ vis ] ]
      [ h5 [ style [("font-weight", "bold"), ("color", "gold"), ("margin-top", "40px")] ] [ text "For Organizations" ]
      , br[][]
      , ul [ class "tarrifPlansStyle", style [("float", "left"), ("width", "100vw"), ("margin-bottom", "1em")] ]
        [ organizationsTarrifListItemUnmargined model "Basic" bm by bs "5" "15" "Current country" OnSubscribeBasicOrganizationMobile
        , organizationsTarrifListItemMobile model "Plus" pm py ps "10" "30" "Current region" OnSubscribePlusOrganizationMobile
        ]
      , ul [ class "tarrifPlansStyle", style [("margin-top", "2em"), ("float", "left"), ("width", "100vw")] ]
          [ organizationsTarrifListItemUnmargined model "Premium" pmm pmy pms "20" "50" "Current continent" OnSubscribePremiumOrganizationMobile
          , li [ style [("float", "left"), ("margin-left", "1em")] ]
              [ div [ class "tarrifBorderedItem", style [("width", "37vw"), ("height", "28.5em")] ]
                  [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("background", "black"), ("color", "white"), ("width", "4.5em"), ("margin-left", "3vw")] ] [ text "Max" ]
                  , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
                  , br [][]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text mm ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text my ]
                  , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text ms ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
                  , p [ class "marginedSkyblue" ] [ text "All" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
                  , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
                  , p [ class "marginedSkyblue" ] [ text "Up to 50" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "120%"), ("margin-top", "1em") ] ] [ text "Unlimited" ]
                  , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
                  , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "Worldwide" ]
                  , button [ onClick OnSubscribeMaxOrganizationMobile, class "subscribeButtonStyle" ] [ text "Subscribe" ]
                  ]
              ]
          ]
        , div [ class "wantMoreStyle", style [("display", "inline-block"), ("width", "80vw"), ("margin-bottom", "10px")] ]
            [ p [ style [("margin", "auto"), ("background", "black"), ("font-size", "120%"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
            , a [ href "#contacts", class "subscribeButtonStyle", style [("padding", "0.3em")] ] [ text "Contact us" ]
            ]
      ]


organizationsTarrifListItem : Model -> Bool -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
organizationsTarrifListItem model isFirst label mp yp sp cv ig region subscriptionMsg =
  let
    leftMargin =
      if isFirst then
        ("margin-left", "0")
      else
        ("margin-left", "2em")

    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), leftMargin] ]
      [ div [ class "tarrifBorderedItem", style [("height", "28.5em")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("background", "navy"), ("color", "white")] ] [ text label ]
        , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
        , br [][]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
        , p [ class "marginedSkyblue" ] [ text "All" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ cv) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text (ig ++ " idea") ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "generators" ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

organizationsTarrifListItemTab : Model -> Bool -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
organizationsTarrifListItemTab model isFirst label mp yp sp cv ig region subscriptionMsg =
  let
    leftMargin =
      if isFirst then
        ("margin-left", "0")
      else
        ("margin-left", "1em")

    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), leftMargin] ]
      [ div [ class "tarrifBorderedItem", style [("height", "28.5em"), ("width", "20vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-left", "2.5vw"), ("margin-top", "-1.2em"), ("background", "navy"), ("color", "white")] ] [ text label ]
        , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
        , br [][]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
        , p [ class "marginedSkyblue" ] [ text "All" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ cv) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text (ig ++ " idea") ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "generators" ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "90%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

organizationsTarrifListItemMobile : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
organizationsTarrifListItemMobile model label mp yp sp cv ig region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), ("margin-left", "1em")] ]
      [ div [ class "tarrifBorderedItem", style [("height", "28.5em"), ("width", "37vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("margin-left", "5vw"), ("background", "black"), ("color", "white")] ] [ text label ]
        , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
        , br [][]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
        , p [ class "marginedSkyblue" ] [ text "All" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ cv) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text (ig ++ " idea") ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "generators" ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

organizationsTarrifListItemUnmargined : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
organizationsTarrifListItemUnmargined model label mp yp sp cv ig region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "80%")
        Models.Eng -> ("font-size", "100%")
  in
    li [ style [("float", "left")] ]
      [ div [ class "tarrifBorderedItem", style [("height", "28.5em"), ("width", "37vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-top", "-1.2em"), ("margin-left", "5vw"), ("background", "black"), ("color", "white")] ] [ text label ]
        , p [ style [("color", "white"), ("text-align", "center"), ("margin-top", "-1.5em"), ("font-size", "98%")] ] [ text "(Enterprise)" ]
        , br [][]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(short version)" ]
        , p [ class "marginedSkyblue" ] [ text "All" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-0.8em"), ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "smallWhiteCentered", style [ ("margin-top", "-1.8em"), ("font-size", "80%") ] ] [ text "(complete version)" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ cv) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text (ig ++ " idea") ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "generators" ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small"), ("margin-top", "-0.4em") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]


ideaGeneratorsPlan : Model -> Html Msg
ideaGeneratorsPlan model =
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

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "innovators-pricing", class "responsiveVisibility" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "15em")] ] [ text "For Idea Generators" ]
      , ul [ class "tarrifPlansStyle" ]
        [ li [ style [("float", "left")] ]
          [ div [ class "tarrifBorderedItem" ]
            [ h4 [ class "tarrifBorderedTitle", style [("color", "white"), ("width", "4.5em"), ("margin-left", "1.5em")] ] [ text "Free plan" ]
            , p [ style [("color", "gold"), ("text-align", "center"), ("font-weight", "bold"), ("margin-top", "1.5em") ] ] [ text "Free" ]
            , p [ class "smallWhiteCentered", style [ ("margin-top", "2.4em"), ("font-size", "small") ] ] [ text "Ideas" ]
            , p [ class "marginedSkyblue" ] [ text "Up to 2" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "1 organization" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text "Current country" ]
            , button [ onClick OnSubscribeFreeInnovators, class "subscribeButtonStyle" ] [ text "Subscribe" ]
            ]
          ]
        , innovatorsTarrifListItem model "Basic" bm by bs "3" "3" "Current region" OnSubscribeBasicInnovators
        , innovatorsTarrifListItem model "Plus" pm py ps "6" "5" "Current continent" OnSubscribePlusInnovators
        , innovatorsTarrifListItem model "Premium" pmm pmy pms "8" "8" "Worldwide" OnSubscribePremiumInnovators
        ]
      , div [ class "wantMoreStyle" ]
        [ p [ style [("margin", "auto"), ("background", "navy"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
        , a [ href "#contacts", class "subscribeButtonStyle", style [("padding", "0.3em")] ] [ text "Contact us" ]
        ]
      ]

ideaGeneratorsPlanTab : Model -> Html Msg
ideaGeneratorsPlanTab model =
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

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "innovators-pricing-t", class "responsiveVisibilityTab" ]
      [ h3 [ style [("color", "gold"), ("margin-top", "15em")] ] [ text "For Idea Generators" ]
      , ul [ class "tarrifPlansStyle", style [("width", "100vw")] ]
        [ li [ style [("float", "left")] ]
          [ div [ class "tarrifBorderedItem", style [("width", "20vw")] ]
            [ h4 [ class "tarrifBorderedTitle", style [("color", "white"), ("width", "4.5em"), ("margin-left", "1.7vw")] ] [ text "Free plan" ]
            , p [ style [("color", "gold"), ("text-align", "center"), ("font-weight", "bold"), ("margin-top", "1.5em") ] ] [ text "Free" ]
            , p [ class "smallWhiteCentered", style [ ("margin-top", "2.4em"), ("font-size", "small") ] ] [ text "Ideas" ]
            , p [ class "marginedSkyblue" ] [ text "Up to 2" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "1 organization" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "Current country" ]
            , button [ onClick OnSubscribeFreeInnovators, class "subscribeButtonStyle" ] [ text "Subscribe" ]
            ]
          ]
        , innovatorsTarrifListItemTab model "Basic" bm by bs "3" "3" "Current region" OnSubscribeBasicInnovators
        , innovatorsTarrifListItemTab model "Plus" pm py ps "6" "5" "Current continent" OnSubscribePlusInnovators
        , innovatorsTarrifListItemTab model "Premium" pmm pmy pms "8" "8" "Worldwide" OnSubscribePremiumInnovators
        ]
      , div [ class "wantMoreStyle" ]
        [ p [ style [("margin", "auto"), ("background", "navy"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
        , a [ href "#contacts", class "subscribeButtonStyle", style [("padding", "0.3em")] ] [ text "Contact us" ]
        ]
      ]

tarrifPlansMobile : Model -> Html Msg
tarrifPlansMobile model =
  let
    vis =
      if model.mobileTarrifPlansView then
        ("display", "initial")
      else
        ("display", "none")
  in
    div [ id "tarrif-plans-m", style [ vis, ("background-size", "100vw 100vh"), ("background-attachment", "fixed"), ("background-image", "url(/images/background_landing_phone.png)"), ("position", "absolute"), ("left", "0"), ("top", "100px") ] ]
      [ ideaGeneratorsPlanMobile model
      , organizationsPlanMobile model
      ]

ideaGeneratorsPlanMobile : Model -> Html Msg
ideaGeneratorsPlanMobile model =
  let
    vis =
      if model.mobileTarrifPlansView then
        ("display", "initial")
      else
        ("display", "none")

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

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    div [ id "innovators-pricing", class "responsiveVisibilityMobile", style [ vis, ("margin-top", "32em")] ]
      [ h5 [ style [("font-weight", "bold"), ("color", "gold")] ] [ text "For Idea Generators" ]
      , ul [ class "tarrifPlansStyle", style [("float", "left"), ("width", "100vw"), ("margin-bottom", "1em")] ]
        [ li [ style [("float", "left")] ]
          [ div [ class "tarrifBorderedItem", style [("width", "37vw")] ]
            [ h4 [ class "tarrifBorderedTitle", style [("color", "white"), ("width", "4.5em"), ("margin-left", "4vw")] ] [ text "Free plan" ]
            , p [ style [("color", "gold"), ("text-align", "center"), ("font-weight", "bold"), ("margin-top", "1.5em") ] ] [ text "Free" ]
            , p [ class "smallWhiteCentered", style [ ("margin-top", "2.4em"), ("font-size", "small") ] ] [ text "Ideas" ]
            , p [ class "marginedSkyblue" ] [ text "Up to 2" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "1 organization" ]
            , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
            , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text "Current country" ]
            , button [ onClick OnSubscribeFreeInnovatorsMobile, class "subscribeButtonStyle" ] [ text "Subscribe" ]
            ]
          ]
        , innovatorsTarrifListItemMobile model "Basic" bm by bs "3" "3" "Current region" OnSubscribeBasicInnovatorsMobile
        ]
      , ul [ class "tarrifPlansStyle", style [("margin-top", "1em"), ("float", "left"), ("width", "100vw")] ]
        [ innovatorsTarrifListItemUnmargined model "Plus" pm py ps "6" "5" "Current continent" OnSubscribePlusInnovatorsMobile
        , innovatorsTarrifListItemMobile model "Premium" pmm pmy pms "8" "8" "Worldwide" OnSubscribePremiumInnovatorsMobile
        ]
      , div [ class "wantMoreStyle", style [("display", "inline-block"), ("width", "80vw")] ]
        [ p [ style [("margin", "auto"), ("font-size", "120%"), ("background", "black"), ("width", "13em"), ("color", "white"), ("text-align", "center"), ("margin-top", "-0.8em")] ] [ text "Looking for more options?" ]
        , a [ href "#contacts", class "subscribeButtonStyle", style [("margin-top", "5em"), ("padding", "0.3em")] ] [ text "Contact us" ]
        ]
      ]

innovatorsTarrifListItem : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
innovatorsTarrifListItem model label mp yp sp ideas organizations region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), ("margin-left", "2em")] ]
      [ div [ class "tarrifBorderedItem" ]
        [ h4 [ class "tarrifBorderedTitle", style [("color", "white")] ] [ text label ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ ideas) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text ( organizations ++ " organizations") ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "120%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

innovatorsTarrifListItemTab : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
innovatorsTarrifListItemTab model label mp yp sp ideas organizations region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), ("margin-left", "1em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "20vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("color", "white"), ("margin-left", "2vw")] ] [ text label ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ ideas) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text ( organizations ++ " organizations") ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "90%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

innovatorsTarrifListItemMobile : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
innovatorsTarrifListItemMobile model label mp yp sp ideas organizations region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left"), ("margin-left", "1em")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "37vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-left", "5vw"), ("color", "white")] ] [ text label ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ ideas) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text ( organizations ++ " organizations") ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]

innovatorsTarrifListItemUnmargined : Model -> String -> String -> String -> String -> String -> String -> String -> Msg -> Html Msg
innovatorsTarrifListItemUnmargined model label mp yp sp ideas organizations region subscriptionMsg =
  let
    lang = model.language
    currency =
      case lang of
        Models.Arm -> "D"
        Models.Eng -> "$"

    month =
      case lang of
        Models.Arm -> "/ամիս"
        Models.Eng -> "/mth"

    year =
      case lang of
        Models.Arm -> "/տարի*"
        Models.Eng -> "/yr*"

    save =
      case lang of
        Models.Arm -> "*խնայեք D "
        Models.Eng -> "*save $"

    fontSize =
      case lang of
        Models.Arm -> ("font-size", "100%")
        Models.Eng -> ("font-size", "120%")
  in
    li [ style [("float", "left")] ]
      [ div [ class "tarrifBorderedItem", style [("width", "37vw")] ]
        [ h4 [ class "tarrifBorderedTitle", style [("margin-left", "5vw"), ("color", "white")] ] [ text label ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ mp ++ month) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "white") ] ] [ text (currency ++ yp ++ year) ]
        , p [ class "marginedSkyblue", style [ fontSize, ("color", "gold") ] ] [ text (save ++ sp) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Ideas" ]
        , p [ class "marginedSkyblue" ] [ text ("Up to " ++ ideas) ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Connect to" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text ( organizations ++ " organizations") ]
        , p [ class "smallWhiteCentered", style [ ("font-size", "small") ] ] [ text "Region" ]
        , p [ class "marginedSkyblue", style[ ("font-size", "100%") ] ] [ text region ]
        , button [ onClick subscriptionMsg, class "subscribeButtonStyle" ] [ text "Subscribe" ]
        ]
      ]
