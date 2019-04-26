module ChatWindowView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Messages exposing (..)
import Models exposing (..)



chatWindowView : Model -> Html Msg
chatWindowView model =
  let
    chatWindowVisibility =
      if model.chatWindowOpened then
        ("display", "initial")
      else
        ("display", "none")

    messageData = model.newChatMessageData
    chatHistory = model.currentChatHistory

    currentUser = model.loggedInMember

    chatHistoryItems =
      --TODO switch to dynamic data after data persistence layer will be done
      List.map (chatHistoryItemView currentUser.id currentUser.isOrganization) (List.reverse chatHistory)
      --List.map (chatHistoryItemView 20 False) (List.reverse chatHistory)

    errors =
      if (String.isEmpty messageData.error) then
        span [][]
      else
        span [ style [("display", "block"), ("color", "red"), ("font-size", "90%")] ] [ text messageData.error ]

  in
    div [ class "chatWindowStyle", style [chatWindowVisibility] ]
    [ div [ style [("height", "7%"), ("background", "orange"), ("padding-right", "2%"), ("padding-left", "2%")] ]
      [ a [ style [("float", "left"), ("font-size", "100%"), ("color", "white")] ] [ text messageData.receiver_name ]
      , a [ onClick (OnToggleChatWindow Nothing), style [("float", "right"), ("padding", "0.2em"), ("font-size", "100%"), ("color", "white"), ("display", "inline")] ] [ text "X" ]
      ]
    , errors
    , ul [ style [("width", "100%"), ("height", "63%"), ("overflow", "auto"), ("list-style-type", "none"), ("padding", "0"), ("margin", "0")] ] (chatHistoryItems)
    , div [ class "subChatWindowStyle" ]
      [ textarea [ onInput OnInputChatMessage, style [("color", "black"), ("resize", "none"), ("width", "100%")], rows 3, placeholder "Your message goes here...", value messageData.body ] []
      , button [ onClick OnSubmitChatMessage, style [("padding-left", "5%"), ("padding-right", "5%"), ("backgroundColor", "cornflowerblue"), ("color", "white"), ("border", "none")] ] [ text "Send" ]
      ]
    ]


chatHistoryItemView : Int -> Bool -> IncomingChatMessage -> Html Msg
chatHistoryItemView currentUserId currentUserIsOrg item =
  let
    alignments =
      if ((currentUserId == item.sender_id) && (currentUserIsOrg == item.sender_is_organization)) then
        ("text-align", "right")
      else
        ("text-align", "left")
  in
    li [ style [("padding-left", "2%"), ("padding-right", "2%")] ]
    [ p [ style [("margin-bottom", "-8%"), ("color", "grey"), ("font-size", "90%"), ("font-style", "italic"), alignments ] ] [ text item.inserted_at ]
    , p [ style [("margin-bottom", "-11%"), ("color", "black"), ("font-size", "100%"), alignments ] ] [ text item.body ]
    , p [ style [("margin-bottom", "-2%"), ("color", "lightgrey"), alignments] ] [ text "___________________" ]
    ]
