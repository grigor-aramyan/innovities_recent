module AboutUsView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Messages exposing (..)
import Models exposing (..)


aboutUsView : Html Msg
aboutUsView =
  div [ class "responsiveVisibility", id "about-us", style [ ("margin", "auto"), ("width", "50vw")] ]
    [ h3 [ style [("color", "gold"), ("margin-top", "3em")] ] [ text "About Us" ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "15vw"), ("margin-left", "15vw")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "15vw"), ("margin-left", "15vw")] ] [ text "That's where our platform provides a helping hand. Innovities is here to help connect both idea generators and companies who are looking for them." ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "15vw"), ("margin-left", "15vw")] ] [ text "You have a great idea or you need a solution for your business? Get registered and be a part of the world where ideas can turn into solution." ]
    ]

aboutUsViewTab : Html Msg
aboutUsViewTab =
  div [ class "responsiveVisibilityTab", id "about-us-t", style [ ("margin", "auto"), ("width", "50vw")] ]
    [ h3 [ style [("color", "gold"), ("margin-top", "3em")] ] [ text "About Us" ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "5vw"), ("margin-left", "5vw")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "5vw"), ("margin-left", "5vw")] ] [ text "That's where our platform provides a helping hand. Innovities is here to help connect both idea generators and companies who are looking for them." ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "5vw"), ("margin-left", "5vw")] ] [ text "You have a great idea or you need a solution for your business? Get registered and be a part of the world where ideas can turn into solution." ]
    ]

aboutUsMobileView : Model -> Html Msg
aboutUsMobileView model =
  let
    vis =
      if model.mobileAboutUsView then
        ("display", "initial")
      else
        ("display", "none")
  in
    div [ class "responsiveVisibilityMobile", id "about-us", style [ vis, ("width", "100vw"), ("position", "absolute"), ("bottom", "10px"), ("left", "3px")] ]
      [ h5 [ style [("font-weight", "bold"), ("color", "gold")] ] [ text "About Us" ]
      , p [ style [("margin-right", "1em"), ("font-size", "90%")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
      , p [ style [("margin-right", "1em"), ("font-size", "90%")] ] [ text "That's where our platform provides a helping hand. Innovities is here to help connect both idea generators and companies who are looking for them." ]
      , p [ style [("margin-right", "1em"), ("font-size", "90%")] ] [ text "You have a great idea or you need a solution for your business? Get registered and be a part of the world where ideas can turn into solution." ]
      ]
