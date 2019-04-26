module Routes exposing (..)

import UrlParser as UP exposing (..)
import Navigation exposing (Location)

type Route =
  HomeRoute
  | AdminRoute
  | DashboardRoute
  | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
  UP.oneOf
      [ UP.map HomeRoute top
      , UP.map HomeRoute (UP.s "innovators")
      , UP.map HomeRoute (UP.s "organizations")
      , UP.map HomeRoute (UP.s "innovators-pricing")
      , UP.map HomeRoute (UP.s "organizations-pricing")
      , UP.map HomeRoute (UP.s "about-us")
      , UP.map HomeRoute (UP.s "contacts")
      , UP.map HomeRoute (UP.s "faq")
      , UP.map HomeRoute (UP.s "innovators-t")
      , UP.map HomeRoute (UP.s "organizations-t")
      , UP.map HomeRoute (UP.s "innovators-pricing-t")
      , UP.map HomeRoute (UP.s "organizations-pricing-t")
      , UP.map HomeRoute (UP.s "about-us-t")
      , UP.map HomeRoute (UP.s "contacts-t")
      , UP.map HomeRoute (UP.s "faq-t")
      , UP.map AdminRoute (UP.s "admin_panel")
      , UP.map HomeRoute (UP.s "menu-m")
      , UP.map HomeRoute (UP.s "innovators-m")
      , UP.map HomeRoute (UP.s "organizations-m")
      , UP.map HomeRoute (UP.s "tarrif-plans-m")
      , UP.map HomeRoute (UP.s "innovators-pricing-m")
      , UP.map HomeRoute (UP.s "organizations-pricing-m")
      , UP.map HomeRoute (UP.s "about-us-m")
      , UP.map HomeRoute (UP.s "contacts-m")
      , UP.map HomeRoute (UP.s "faq-m")
      , UP.map DashboardRoute (UP.s "dashboard")
      , UP.map DashboardRoute (UP.s "profile") ]


parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    Nothing ->
      NotFoundRoute
