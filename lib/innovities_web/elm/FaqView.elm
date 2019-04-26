module FaqView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Messages exposing (..)


faqView : Html Msg
faqView =
  div [ id "faq", class "responsiveVisibility", style [ ("margin", "auto"), ("width", "62%")]]
    [ h3 [ style [("color", "gold"), ("margin-top", "2em")] ] [ text "FAQ" ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "15vw"), ("margin-left", "15vw")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
    ]

faqViewTab : Html Msg
faqViewTab =
  div [ id "faq-t", class "responsiveVisibilityTab", style [ ("margin", "auto"), ("width", "62%")]]
    [ h3 [ style [("color", "gold"), ("margin-top", "2em")] ] [ text "FAQ" ]
    , p [ style [("font-size", "small"), ("text-align", "left"), ("margin-right", "5vw"), ("margin-left", "5vw")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
    ]


faqViewMobile : Bool -> Html Msg
faqViewMobile visible =
  let
    vis =
      if visible then
        ("display", "initial")
      else
        ("display", "none")
  in
    div [ id "faq", class "responsiveVisibilityMobile", style [ vis, ("position", "absolute"), ("left", "10vw"), ("bottom", "10px"), ("margin", "auto"), ("width", "80vw")]]
      [ h3 [ style [("color", "gold")] ] [ text "FAQ" ]
      , p [ style [("font-size", "small")] ] [ text "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." ]
      ]
