module FooterView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Messages exposing (..)


footerView : Html Msg
footerView =
  div [ class "responsiveVisibility uk-column-1-2", style [("width", "20em"), ("float", "right"), ("margin-right", "15em")] ]
    [ ul [ style [("list-style-type", "none")] ]
        [ li [ style [("color", "gold"), ("margin-bottom", "0.5em")] ] [ text "Follow Us:" ]
        , li [ style [("margin-bottom", "0.5em")] ] [ a [ href "https://www.facebook.com/", target "_blank" ] [ text "Facebook" ] ]
        , li [ style [("margin-bottom", "0.5em")] ] [ a [ href "https://www.twitter.com/", target "_blank" ] [ text "Twitter" ] ]
        , li [] [ a [ href "https://www.linkedin.com/", target "_blank" ] [ text "LinkedIn" ] ]
        ]
    , div []
        [ div [ class "headerLogo" ] []
        , p [ style [("font-size", "x-small"), ("margin-top", "-0.1em"), ("width", "29em")] ] [ text "@ 2018-2019 Innovities. All Rights Reserved. Terms of Service." ]
        ]
    ]

footerViewTab : Html Msg
footerViewTab =
  div [ class "responsiveVisibilityTab uk-column-1-2", style [("width", "20em"), ("float", "right"), ("margin-right", "15em")] ]
    [ ul [ style [("list-style-type", "none")] ]
        [ li [ style [("color", "gold"), ("margin-bottom", "0.5em")] ] [ text "Follow Us:" ]
        , li [ style [("margin-bottom", "0.5em")] ] [ a [ href "https://www.facebook.com/", target "_blank" ] [ text "Facebook" ] ]
        , li [ style [("margin-bottom", "0.5em")] ] [ a [ href "https://www.twitter.com/", target "_blank" ] [ text "Twitter" ] ]
        , li [] [ a [ href "https://www.linkedin.com/", target "_blank" ] [ text "LinkedIn" ] ]
        ]
    , div []
        [ div [ class "headerLogo" ] []
        , p [ style [("font-size", "x-small"), ("margin-top", "-0.1em"), ("width", "29em")] ] [ text "@ 2018-2019 Innovities. All Rights Reserved. Terms of Service." ]
        ]
    ]
