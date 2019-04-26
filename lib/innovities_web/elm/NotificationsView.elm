module NotificationsView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



newNotifsListView : Model -> Html Msg
newNotifsListView model =
  let
    newNotifsVisible =
      if model.newNotificationsVisible then
        ("display", "initial")
      else
        ("display", "none")

    fullDescReqNotifs =
      List.filter (\n -> n.notificationType == "COMPLETE_DESC_REQ") model.notifications

    acceptedFullDescNotifs =
      List.filter (\n -> n.notificationType == "DESC_REQ_ACCEPTED" ) model.notifications

    remainingNotifs =
      List.filter (\n -> (n.notificationType /= "COMPLETE_DESC_REQ") &&
        (n.notificationType /= "DESC_REQ_ACCEPTED")) model.notifications


    newNotifsItems =
      List.map newNotifItem remainingNotifs

    acceptedFullDescNotifsList =
      List.map acceptedFullDescNotifItem acceptedFullDescNotifs

    fullDescNotifs =
      List.map newFullDescNotifItem fullDescReqNotifs


    completeItems =
      fullDescNotifs ++ acceptedFullDescNotifsList ++ newNotifsItems

  in
    ul [ class "newNotifsListStyle", style [ newNotifsVisible ] ]
    (completeItems)


newFullDescNotifItem : NotificationItem -> Html Msg
newFullDescNotifItem item =
  li [ style [("border", "2px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
  [ div [ style [("padding-left", "2%")] ]
    [ p [ style [("text-align", "left"), ("margin-bottom", "-5%"), ("font-size", "90%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.title ]
    , p [ style [("text-align", "left"), ("font-size", "80%"), ("color", "black")] ] [ text item.body ]
    , div [ style [("margin-bottom", "2px")] ]
      [ button [ onClick (OnAcceptRejectFullDescInitiated item.id 0), style [("margin-right", "0.3em"), ("background", "white"), ("border", "1px solid orange"), ("color", "black")] ] [ text "Reject" ]
      , button [ onClick (OnAcceptRejectFullDescInitiated item.id 1), style [("margin-left", "0.3em"), ("background", "orange"), ("border", "1px solid orange"), ("color", "white")] ] [ text "Accept" ]
      ]
    ]
  ]


acceptedFullDescNotifItem : NotificationItem -> Html Msg
acceptedFullDescNotifItem item =
  li [ style [("border", "2px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
  [ div [ style [("padding-left", "2%")] ]
    [ p [ style [("text-align", "left"), ("margin-bottom", "-5%"), ("font-size", "90%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.title ]
    , p [ style [("text-align", "left"), ("font-size", "80%"), ("color", "black")] ] [ text item.body ]
    , div [ style [("margin-bottom", "2px")] ]
      [ button [ onClick (OnViewFullIdeaData item.requestedIdeaId item.id item.body), style [("background", "white"), ("border", "1px solid orange"), ("color", "black")] ] [ text "Read" ] ]
    ]
  ]


newNotifItem : NotificationItem -> Html Msg
newNotifItem item =
  li [ style [("border", "2px solid orange"), ("border-radius", "5%"), ("margin-bottom", "0.2em")] ]
  [ a [ onClick (OnNewNotifItemClick item.id) ]
    [ div [ style [("padding-left", "2%")] ]
      [ p [ style [("text-align", "left"), ("margin-bottom", "-5%"), ("font-size", "90%"), ("color", "grey"), ("font-style", "italic")] ] [ text item.title ]
      , p [ style [("text-align", "left"), ("font-size", "80%"), ("color", "black")] ] [ text item.body ]
      ]
    ]
  ]
