port module Ports exposing (..)

import Models exposing (IncomingChatMessage, IncomingUnredChatMessage, CacheDataWrapper)



type alias PostImageChooserData =
  { fileName : String
  , error : String
  }

type alias MediaFileChooserData =
  { fileName : String
  , error : String
  }

type alias PostMediaUriData =
  { uri : String
  , error : String
  }

type alias NewChatMessageWrapper =
  { body : String
  , from : Int
  , receiver_is_organization : Bool
  , sender_is_organization : Bool
  , to : Int
  , token : String
  }

type alias MarkMessageAsRedWrapper =
  { message_id: Int
  , token : String
  }

type alias ChatMessageSenderData =
  { message_id : Int
  , receiver_id : Int
  , receiver_is_org : Bool
  , receiver_name : String
  }

type alias NDADataWrapper =
  { companyName : String
  , innovatorName : String
  , ideaName : String
  , langString : String
  , customNda : String
  }


port scrollToElement : String -> Cmd msg



port cacheAllData : CacheDataWrapper -> Cmd msg

port fetchCachedDataResponse : (CacheDataWrapper -> msg) -> Sub msg

port clearCachedData : String -> Cmd msg




port showNDAConfirmDialog : NDADataWrapper -> Cmd msg

port ndaRejected : (String -> msg) -> Sub msg

port ndaAccepted : (String -> msg) -> Sub msg




port turnOnNewNotifsFetch : String -> Cmd msg

port turnOffNewNotifsFetch : String -> Cmd msg

port regularNewNotifsFetch : (String -> msg) -> Sub msg



port sharePostOnFacebook : String -> Cmd msg

port shareProfileOnFacebook : String -> Cmd msg



port submitOrgSettingsPicToFirebase : String -> Cmd msg

port replyWithOrgSettingsPicUri : (PostMediaUriData -> msg) -> Sub msg



port submitSettingsPicToFirebase : String -> Cmd msg

port replyWithSettingsPicUri : (PostMediaUriData -> msg) -> Sub msg



port initOrgSettingsMediaBtn : String -> Cmd msg

port getOrgSettingsImageName : (MediaFileChooserData -> msg) -> Sub msg



port initSettingsMediaBtn : String -> Cmd msg

port getSettingsImageName : (MediaFileChooserData -> msg) -> Sub msg



port markIncomingMessageAsRed : MarkMessageAsRedWrapper -> Cmd msg



port markAsRedChatMessage : MarkMessageAsRedWrapper -> Cmd msg

port replyToMarkAsRedWithSendersData : (ChatMessageSenderData -> msg) -> Sub msg



port fetchMessageSenderPicture : IncomingChatMessage -> Cmd msg

port replyWithUnredChatMessageWithPic : (IncomingUnredChatMessage -> msg) -> Sub msg



port submitChatMessageToChannel : NewChatMessageWrapper -> Cmd msg

port incomingChatMessage : (IncomingChatMessage -> msg) -> Sub msg

port chatMessageSubmitError : (PostMediaUriData -> msg) -> Sub msg



port submitPicturesToFirebase : String -> Cmd msg

port replyWithIdeaPictureUris : (PostMediaUriData -> msg) -> Sub msg


port getIdeaPicName : (MediaFileChooserData -> msg) -> Sub msg


port submitVideoFileToFirebase : String -> Cmd msg

port replyWithIdeaVideoFileUri : (PostMediaUriData -> msg) -> Sub msg


port getIdeaVideoName : (MediaFileChooserData -> msg) -> Sub msg


port submitMediaFileToFirebase : String -> Cmd msg

port replyWithPostMediaFileUri : (PostMediaUriData -> msg) -> Sub msg


port getPostImageName : (PostImageChooserData -> msg) -> Sub msg


port reverseBackgroundImage : String -> Cmd msg


port setWhiteBackground : String -> Cmd msg


port showPromoRegistrationConfirmDialog : String -> Cmd msg


port initPostMediaBtn : String -> Cmd msg

port initIdeaMediaBtns : String -> Cmd msg



port initFakeInterOpForLocationSwitch : String -> Cmd msg

port sendFakeInterOpResponseForLocationSwitch : (String -> msg) -> Sub msg



port initFakeInterOp3 : String -> Cmd msg

port sendFakeInterOpResponse3 : (String -> msg) -> Sub msg



port initFakeInterOp2 : String -> Cmd msg

port sendFakeInterOpResponse2 : (String -> msg) -> Sub msg


port initFakeInterOp : String -> Cmd msg

port sendFakeInterOpResponse : (String -> msg) -> Sub msg
