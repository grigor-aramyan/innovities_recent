module Networking exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline as Pipeline exposing (..)
import Json.Encode as Encode exposing (..)
import Http exposing (..)

import Messages exposing (..)
import Models exposing (PromoRegistration, PromoRegData, RegisteredDataList, AdminPanelSignInData, DataRegistered, DataRegisteredWrapper,
  InnovatorRegistration, CompanyRegistration, TopMembers, TopInnovator, TopOrganization, LoggingInMember, LoggedInMemberWrapper,
  LoggedInMember, SignOutResponse, InnovatorExtended, GetInnovatorDataResponseWrapper, GetOrganizationDataResponseWrapper,
  OrganizationExtended, GetDataRequestStruct, ContactUsData, SimpleResponse, PostData, ExtendedPostData, NewIdeaData,
  ChatHistoryRequestWrapper, UnredChatMessagesRequestWrapper, SuggestedUser, ConnectionData, InnovatorSettingsFields,
  TariffPlanSubscriptionData, OrganizationSettingsFields, NotificationItem, PostCommentData, ProcessedSearchDataWrapper,
  SearchData, IdeaData, FullDescReqWrapper, AcceptRejectFullDescWrapper, FullIdeaData, NDAFullDataWrapper,
  IncomingChatMessage, IncomingUnredChatMessage, SignedNDA, UserIdentifierWrapper)


api : String
api =
  "http://localhost:4000/api/"
  --"https://bland-soulful-tinamou.gigalixirapp.com/api/"
  --"https://www.innovities.com/api/"

memberLoginUri : String
memberLoginUri =
  api ++ "member/login"

fetchTopMembersUri : String
fetchTopMembersUri =
  api ++ "top_members"

organizationRegisterUri : String
organizationRegisterUri =
  api ++ "organization/register"

innovatorRegisterUri : String
innovatorRegisterUri =
  api ++ "innovator/register"

promoRegisterUri : String
promoRegisterUri =
  api ++ "promo/registration"


adminPanelSignInUri : String
adminPanelSignInUri =
  api ++ "admin_login"

signOutUri : String
signOutUri =
  api ++ "sign_out"

getInnovatorDataUri : String
getInnovatorDataUri =
  api ++ "get_innovator_data"

getOrganizationDataUri : String
getOrganizationDataUri =
  api ++ "get_organization_data"

sendContactUsEmailUri : String
sendContactUsEmailUri =
  api ++ "send_contact_email"

submitPostUri : String
submitPostUri =
  api ++ "submit_post"

submitIdeaUri : String
submitIdeaUri =
  api ++ "submit_idea"

fetchExtendedPostsUri : String
fetchExtendedPostsUri =
  api ++ "fetch_extended_posts"

fetchChatHistoryUri : String
fetchChatHistoryUri =
  api ++ "fetch_chat_history"

fetchUnredMessagesUri : String
fetchUnredMessagesUri =
  api ++ "fetch_unred_messages"

fetchSuggestedOrganizationsUri : String
fetchSuggestedOrganizationsUri =
  api ++ "fetch_suggested_companies"

fetchSuggestedInnovatorsUri : String
fetchSuggestedInnovatorsUri =
  api ++ "fetch_suggested_innovators"

makeConnectionUri : String
makeConnectionUri =
  api ++ "make_connection"

updateInnovatorSettingsUri : String
updateInnovatorSettingsUri =
  api ++ "update_innovator_settings"

subscribeTariffPlanUri : String
subscribeTariffPlanUri =
  api ++ "subscribe_tariff_plan"

updateOrganizationSettingsUri : String
updateOrganizationSettingsUri =
  api ++ "update_organization_settings"

markNotifAsRedUri : String
markNotifAsRedUri =
  api ++ "mark_notif_as_red"

fetchNewNotifsUri : String
fetchNewNotifsUri =
  api ++ "fetch_unred_notifs"

likePostUri : String
likePostUri =
  api ++ "like_post"

createCommentUri : String
createCommentUri =
  api ++ "create_comment"

fetchCommentsUri : String
fetchCommentsUri =
  api ++ "fetch_comments"

processSearchUri : String
processSearchUri =
  api ++ "process_search"

checkConnectionAndConnectUri : String
checkConnectionAndConnectUri =
  api ++ "check_connection_and_connect"

createFullDescReqNotifUri : String
createFullDescReqNotifUri =
  api ++ "create_full_desc_req_notification"

acceptOrRejectFullDescReqUri : String
acceptOrRejectFullDescReqUri =
  api ++ "accept_or_reject_full_desc_req"

getFullIdeaUri : String
getFullIdeaUri =
  api ++ "get_full_idea"

saveNdaUri : String
saveNdaUri =
  api ++ "save_nda"

fetchSignedNdasUri : String
fetchSignedNdasUri =
  api ++ "fetch_signed_ndas"


-- CALLS

fetchSignedNdas : UserIdentifierWrapper -> Http.Request (List SignedNDA)
fetchSignedNdas data =
  let
    body =
      data
      |> userIdentifierWrapperEncoder
      |> Http.jsonBody

  in
    Http.post fetchSignedNdasUri body signedNdasListDecoder



fetchSignedNdasCmd : UserIdentifierWrapper -> Cmd Msg
fetchSignedNdasCmd data =
  Http.send OnFetchSignedNdasCompleted (fetchSignedNdas data)




saveNda : NDAFullDataWrapper -> Http.Request SimpleResponse
saveNda data =
  let
    body =
      data
        |> ndaDataEncoder
        |> Http.jsonBody

  in
    Http.post saveNdaUri body simpleResponseDecoder


saveNdaCmd : NDAFullDataWrapper -> Cmd Msg
saveNdaCmd data =
  Http.send OnSaveNdaCallCompleted (saveNda data)



getFullIdeaData : GetDataRequestStruct -> Http.Request FullIdeaData
getFullIdeaData data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody

  in
    Http.post getFullIdeaUri body fullIdeaDataDecoder


getFullIdeaDataCmd : GetDataRequestStruct -> Cmd Msg
getFullIdeaDataCmd data =
  Http.send OnGetFullIdeaDataCompleted (getFullIdeaData data)




acceptRejectFullDesc : AcceptRejectFullDescWrapper -> Http.Request SimpleResponse
acceptRejectFullDesc data =
  let
    body =
      data
        |> acceptRejectFullDescWrapperEncoder
        |> Http.jsonBody

  in
    Http.post acceptOrRejectFullDescReqUri body simpleResponseDecoder


acceptRejectFullDescCmd : AcceptRejectFullDescWrapper -> Cmd Msg
acceptRejectFullDescCmd data =
  Http.send OnAcceptRejectFullDescCompleted (acceptRejectFullDesc data)




fullDescRequest : FullDescReqWrapper -> Http.Request SimpleResponse
fullDescRequest data =
  let
    body =
      data
        |> fullDescReqWrapperEncoder
        |> Http.jsonBody

  in
    Http.post createFullDescReqNotifUri body simpleResponseDecoder



fullDescRequestCmd : FullDescReqWrapper -> Cmd Msg
fullDescRequestCmd data =
  Http.send OnFullDescRequestCompleted (fullDescRequest data)



checkConnectionAndConnect : ConnectionData -> Http.Request SimpleResponse
checkConnectionAndConnect data =
  let
    body =
      data
        |> makeConnectionDataEncoder
        |> Http.jsonBody

  in
    Http.post checkConnectionAndConnectUri body simpleResponseDecoder


checkConnectionAndConnectCmd : ConnectionData -> Cmd Msg
checkConnectionAndConnectCmd data =
  Http.send OnCheckConnectionAndConnectCompleted (checkConnectionAndConnect data)




processSearch : SearchData -> Http.Request ProcessedSearchDataWrapper
processSearch data =
  let
    body =
      data
        |> searchDataEncoder
        |> Http.jsonBody

  in
    Http.post processSearchUri body processedSearchDataDecoder


processSearchCmd : SearchData -> Cmd Msg
processSearchCmd data =
  Http.send OnProcessSearchCompleted (processSearch data)



fetchPostComments : GetDataRequestStruct -> Http.Request (List PostCommentData)
fetchPostComments data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody

  in
    Http.post fetchCommentsUri body postCommentsDecoder


fetchPostCommentsCmd : GetDataRequestStruct -> Cmd Msg
fetchPostCommentsCmd data =
  Http.send OnPostCommentsFetchCompleted (fetchPostComments data)



createComment : PostCommentData -> Http.Request PostCommentData
createComment data =
  let
    body =
      data
        |> postCommentDataEncoder
        |> Http.jsonBody
  in
    Http.post createCommentUri body postCommentDataDecoder


createCommentCmd : PostCommentData -> Cmd Msg
createCommentCmd data =
  Http.send OnPostCommentSubmitCompleted (createComment data)




likePost : GetDataRequestStruct -> Http.Request SimpleResponse
likePost data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody

  in
    Http.post likePostUri body simpleResponseDecoder


likePostCmd : GetDataRequestStruct -> Cmd Msg
likePostCmd data =
  Http.send OnPostLikedCompleted (likePost data)



markNotifAsRed : GetDataRequestStruct -> Http.Request SimpleResponse
markNotifAsRed data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody

  in
    Http.post markNotifAsRedUri body simpleResponseDecoder


markNotifAsRedCmd : GetDataRequestStruct -> Cmd Msg
markNotifAsRedCmd data =
  Http.send OnMarkNotifAsRedCompleted (markNotifAsRed data)



fetchNewNotifications : UnredChatMessagesRequestWrapper -> Http.Request (List NotificationItem)
fetchNewNotifications data =
  let
    body =
      data
        |> unredMessagesRequestEncoder
        |> Http.jsonBody

  in
    Http.post fetchNewNotifsUri body notificationsListDecoder


fetchNewNotificationsCmd : UnredChatMessagesRequestWrapper -> Cmd Msg
fetchNewNotificationsCmd data =
  Http.send OnFetchNewNotificationsCompleted (fetchNewNotifications data)




subscribeTariffPlan : TariffPlanSubscriptionData -> Http.Request SimpleResponse
subscribeTariffPlan data =
  let
    body =
      data
        |> tariffPlanDataEncoder
        |> Http.jsonBody

  in
    Http.post subscribeTariffPlanUri body simpleResponseDecoder

subscribeTariffPlanCmd : TariffPlanSubscriptionData -> Cmd Msg
subscribeTariffPlanCmd data =
  Http.send OnSubscribeTariffPlanCompleted (subscribeTariffPlan data)




updateOrganizationSettings : OrganizationSettingsFields -> Http.Request GetOrganizationDataResponseWrapper
updateOrganizationSettings data =
  let
    body =
      data
        |> updateOrganizationDataEncoder
        |> Http.jsonBody

  in
    Http.post updateOrganizationSettingsUri body organizationExtendedWrapperDecoder


updateOrganizationSettingsCmd : OrganizationSettingsFields -> Cmd Msg
updateOrganizationSettingsCmd data =
  Http.send OnUpdateOrganizationSettingsCompleted (updateOrganizationSettings data)




updateInnovatorSettings : InnovatorSettingsFields -> Http.Request GetInnovatorDataResponseWrapper
updateInnovatorSettings data =
  let
    body =
      data
        |> updatedInnovatorSettingsEncoder
        |> Http.jsonBody

  in
    Http.post updateInnovatorSettingsUri body innovatorExtendedWrapperDecoder


updateInnovatorSettingsCmd : InnovatorSettingsFields -> Cmd Msg
updateInnovatorSettingsCmd data =
  Http.send OnUpdateInnovatorSettingsCompleted (updateInnovatorSettings data)



makeConnection : ConnectionData -> Http.Request SimpleResponse
makeConnection data =
  let
    body =
      data
        |> makeConnectionDataEncoder
        |> Http.jsonBody

  in
    Http.post makeConnectionUri body simpleResponseDecoder


makeConnectionCmd : ConnectionData -> Cmd Msg
makeConnectionCmd data =
  Http.send OnMakeConnectionCompleted (makeConnection data)



fetchSuggestions : GetDataRequestStruct -> String -> Http.Request (List SuggestedUser)
fetchSuggestions data uri =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody

  in
    Http.post uri body suggestionsDecoder


fetchSuggestionsCmd : GetDataRequestStruct -> String -> Cmd Msg
fetchSuggestionsCmd data uri =
  Http.send OnFetchSuggestionsCompleted (fetchSuggestions data uri)



fetchUnredMessages : UnredChatMessagesRequestWrapper -> Http.Request (List IncomingUnredChatMessage)
fetchUnredMessages data =
  let
    body =
      data
        |> unredMessagesRequestEncoder
        |> Http.jsonBody

  in
    Http.post fetchUnredMessagesUri body unredMessagesDecoder


fetchUnredMessagesCmd : UnredChatMessagesRequestWrapper -> Cmd Msg
fetchUnredMessagesCmd data =
  Http.send OnFetchUnredChatMessagesCompleted (fetchUnredMessages data)



fetchChatHistory : ChatHistoryRequestWrapper -> Http.Request (List IncomingChatMessage)
fetchChatHistory data =
  let
    body =
      data
        |> chatHistoryRequestEncoder
        |> Http.jsonBody

  in
    Http.post fetchChatHistoryUri body chatHistoryDecoder


fetchChatHistoryCmd : ChatHistoryRequestWrapper -> Cmd Msg
fetchChatHistoryCmd data =
  Http.send OnChatHistoryFetchCompleted (fetchChatHistory data)



submitNewIdea : NewIdeaData -> Http.Request SimpleResponse
submitNewIdea data =
  let
    body =
      data
        |> ideaDataEncoder
        |> Http.jsonBody

  in
    Http.post submitIdeaUri body simpleResponseDecoder


submitNewIdeaCmd : NewIdeaData -> Cmd Msg
submitNewIdeaCmd data =
  Http.send OnSubmitIdeaCompleted (submitNewIdea data)



fetchExtendedPosts : String -> Http.Request (List ExtendedPostData)
fetchExtendedPosts token =
  let
    body =
      token
      |> tokenEncoder
      |> Http.jsonBody

  in
    Http.post fetchExtendedPostsUri body extendedPostsListDecoder


fetchExtendedPostsCmd : String -> Cmd Msg
fetchExtendedPostsCmd token =
  Http.send OnFetchExtendedPostsCompleted (fetchExtendedPosts token)



submitNewPost : PostData -> Http.Request SimpleResponse
submitNewPost data =
  let
    body =
      data
        |> postDataEncoder
        |> Http.jsonBody

  in
    Http.post submitPostUri body simpleResponseDecoder

submitNewPostCmd : PostData -> Cmd Msg
submitNewPostCmd data =
  Http.send OnSubmitPostCompleted (submitNewPost data)



submitContactUsForm : ContactUsData -> Http.Request SimpleResponse
submitContactUsForm data =
  let
    body =
      data
        |> contactUsFormEncoder
        |> Http.jsonBody
  in
    Http.post sendContactUsEmailUri body simpleResponseDecoder


submitContactUsFormCmd : ContactUsData -> Cmd Msg
submitContactUsFormCmd data =
  Http.send OnContactUsFormSubmitCompleted (submitContactUsForm data)



getInnovatorData : GetDataRequestStruct -> Http.Request GetInnovatorDataResponseWrapper
getInnovatorData data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody
  in
    Http.post getInnovatorDataUri body innovatorExtendedWrapperDecoder

getInnovatorDataCmd : GetDataRequestStruct -> Cmd Msg
getInnovatorDataCmd data =
  Http.send OnGetInnovatorDataCompleted (getInnovatorData data)



getOrganizationData : GetDataRequestStruct -> Http.Request GetOrganizationDataResponseWrapper
getOrganizationData data =
  let
    body =
      data
        |> getMemberDataStructEncoder
        |> Http.jsonBody
  in
    Http.post getOrganizationDataUri body organizationExtendedWrapperDecoder



getOrganizationDataCmd : GetDataRequestStruct -> Cmd Msg
getOrganizationDataCmd data =
  Http.send OnGetOrganizationDataCompleted (getOrganizationData data)



signOut : String -> Http.Request SignOutResponse
signOut token =
  let
    body =
      token
        |> tokenEncoder
        |> Http.jsonBody
  in
    Http.post signOutUri body signOutResponseDecoder

signOutCmd : String -> Cmd Msg
signOutCmd token =
  Http.send OnSignOutCompleted (signOut token)




memberLogin : LoggingInMember -> Http.Request LoggedInMemberWrapper
memberLogin memberData =
  let
    body =
      memberData
        |> loginDataEncoder
        |> Http.jsonBody

  in
    Http.post memberLoginUri body loginDataDecoder

memberLoginCmd : LoggingInMember -> Cmd Msg
memberLoginCmd memberData =
  Http.send OnLoggingInMemberCompleted (memberLogin memberData)




topMembersFetch : Http.Request TopMembers
topMembersFetch =
  Http.get fetchTopMembersUri topMembersDecoder

topMembersFetchCmd : Cmd Msg
topMembersFetchCmd =
  Http.send TopMembersFetchCompleted topMembersFetch




organizationRegister : CompanyRegistration -> String -> Http.Request DataRegisteredWrapper
organizationRegister registerData tarrifPlan =
  let
    body =
      registerData
        |> organizationRegisterDataEncoder tarrifPlan
        |> Http.jsonBody

  in
    Http.post organizationRegisterUri body registeredDataDecoder

organizationRegisterCmd : CompanyRegistration -> String -> Cmd Msg
organizationRegisterCmd registerData tarrifPlan =
  Http.send CompanyRegisterCompleted (organizationRegister registerData tarrifPlan)



innovatorRegister : InnovatorRegistration -> String -> Http.Request DataRegisteredWrapper
innovatorRegister registerData tarrifPlan =
  let
    body =
      registerData
        |> innovatorRegisterDataEncoder tarrifPlan
        |> Http.jsonBody

  in
    Http.post innovatorRegisterUri body registeredDataDecoder

innovatorRegisterCmd : InnovatorRegistration -> String -> Cmd Msg
innovatorRegisterCmd registerData tarrifPlan =
  Http.send InnovatorRegisterCompleted (innovatorRegister registerData tarrifPlan)



adminPanelSignIn : AdminPanelSignInData -> Http.Request RegisteredDataList
adminPanelSignIn signInData =
  let
    body =
      signInData
        |> signInDataEncoder
        |> Http.jsonBody

  in
    Http.post adminPanelSignInUri body signInDataDecoder

adminPanelSignInCmd : AdminPanelSignInData -> Cmd Msg
adminPanelSignInCmd signInData =
  Http.send AdminPanelSignInCompleted (adminPanelSignIn signInData)



promoRegister : PromoRegistration -> Http.Request PromoRegistration
promoRegister promoData =
  let
    body =
      promoData
        |> promoDataEncoder
        |> Http.jsonBody
  in
    Http.post promoRegisterUri body promoDataDecoder


promoRegisterCmd : PromoRegistration -> Cmd Msg
promoRegisterCmd promoData =
  Http.send PromoRegistrationCallCompleted (promoRegister promoData)



-- ENCODERS

userIdentifierWrapperEncoder : UserIdentifierWrapper -> Encode.Value
userIdentifierWrapperEncoder data =
  Encode.object
    [ ("id", Encode.int data.id)
    , ("is_org", Encode.bool data.is_org)
    , ("token", Encode.string data.token) ]



ndaDataEncoder : NDAFullDataWrapper -> Encode.Value
ndaDataEncoder data =
  Encode.object
    [ ("author_id", Encode.int data.author_id)
    , ("author_is_org", Encode.bool data.author_is_org)
    , ("idea_id", Encode.int data.idea_id)
    , ("recipient_id", Encode.int data.recipient_id)
    , ("recipient_is_org", Encode.bool data.recipient_is_org)
    , ("token", Encode.string data.token)
    , ("is_default_nda", Encode.bool data.is_default_nda) ]



acceptRejectFullDescWrapperEncoder : AcceptRejectFullDescWrapper -> Encode.Value
acceptRejectFullDescWrapperEncoder data =
  Encode.object
    [ ("notif_id", Encode.int data.notif_id)
    , ("res_code", Encode.int data.res_code)
    , ("token", Encode.string data.token) ]



fullDescReqWrapperEncoder : FullDescReqWrapper -> Encode.Value
fullDescReqWrapperEncoder data =
  Encode.object
    [ ("notification_type_code", Encode.int data.notification_type_code)
    , ("requested_idea_id", Encode.int data.requested_idea_id)
    , ("addressed_to", Encode.int data.addressed_to)
    , ("addressed_to_is_org", Encode.bool data.addressed_to_is_org)
    , ("requested_from", Encode.int data.requested_from)
    , ("requested_from_is_org", Encode.bool data.requested_from_is_org)
    , ("token", Encode.string data.token) ]



searchDataEncoder : SearchData -> Encode.Value
searchDataEncoder data =
  Encode.object
    [ ("query", Encode.string data.query)
    , ("token", Encode.string data.token)
    , ("user_id", Encode.int data.user_id)
    , ("user_is_org", Encode.bool data.user_is_org) ]



postCommentDataEncoder : PostCommentData -> Encode.Value
postCommentDataEncoder data =
  Encode.object
    [ ("author_id", Encode.int data.author_id)
    , ("author_is_org", Encode.bool data.author_is_org)
    , ("body", Encode.string data.body)
    , ("post_id", Encode.int data.post_id)
    , ("token", Encode.string data.token)]



tariffPlanDataEncoder : TariffPlanSubscriptionData -> Encode.Value
tariffPlanDataEncoder data =
  Encode.object
    [ ("id", Encode.int data.id)
    , ("is_organization", Encode.bool data.is_organization)
    , ("tariff_plan_name", Encode.string data.tariff_plan_name)
    , ("token", Encode.string data.token) ]



updateOrganizationDataEncoder : OrganizationSettingsFields -> Encode.Value
updateOrganizationDataEncoder data =
  Encode.object
    [ ("id", Encode.int data.id)
    , ("name", Encode.string data.name)
    , ("logo_uri", Encode.string data.pic_uri)
    , ("country", Encode.string data.country)
    , ("email", Encode.string data.email)
    , ("description", Encode.string data.description)
    , ("webpage", Encode.string data.webpage)
    , ("about_us", Encode.string data.about_us)
    , ("industry", Encode.string data.industry)
    , ("interested_industries", Encode.string data.interested_industries)
    , ("username", Encode.string data.username)
    , ("phone", Encode.string data.phone)
    , ("token", Encode.string data.token) ]



updatedInnovatorSettingsEncoder : InnovatorSettingsFields -> Encode.Value
updatedInnovatorSettingsEncoder data =
  Encode.object
    [ ("id", Encode.int data.id)
    , ("full_name", Encode.string (data.name ++ " " ++ data.surname))
    , ("picture_uri", Encode.string data.pic_uri)
    , ("country", Encode.string data.country)
    , ("email", Encode.string data.email)
    , ("description", Encode.string data.description)
    , ("about_me", Encode.string data.about_me)
    , ("education", Encode.string data.education)
    , ("experience", Encode.string data.experience)
    , ("username", Encode.string data.username)
    , ("phone", Encode.string data.phone)
    , ("token", Encode.string data.token) ]



makeConnectionDataEncoder : ConnectionData -> Encode.Value
makeConnectionDataEncoder data =
  Encode.object
    [ ("sender_id", Encode.int data.sender_id)
    , ("sender_is_organization", Encode.bool data.sender_is_organization)
    , ("receiver_id", Encode.int data.receiver_id)
    , ("receiver_is_organization", Encode.bool data.receiver_is_organization)
    , ("token", Encode.string data.token) ]



unredMessagesRequestEncoder : UnredChatMessagesRequestWrapper -> Encode.Value
unredMessagesRequestEncoder data =
  Encode.object
    [ ("receiver_id", Encode.int data.receiver_id)
    , ("receiver_is_org", Encode.bool data.receiver_is_organization)
    , ("token", Encode.string data.token) ]



chatHistoryRequestEncoder : ChatHistoryRequestWrapper -> Encode.Value
chatHistoryRequestEncoder data =
  Encode.object
    [ ("to_id", Encode.int data.to_id)
    , ("from_id", Encode.int data.from_id)
    , ("to_is_organization", Encode.bool data.to_is_organization)
    , ("from_is_organization", Encode.bool data.from_is_organization)
    , ("token", Encode.string data.token) ]



ideaDataEncoder : NewIdeaData -> Encode.Value
ideaDataEncoder data =
  Encode.object
    [ ("innovator_id", Encode.int data.innovator_id)
    , ("short_description", Encode.string data.shortDescription)
    , ("long_description", Encode.string data.longDescription)
    , ("idea_name", Encode.string data.ideaName)
    , ("industry", Encode.string data.industry)
    , ("tags", Encode.string data.tags)
    , ("price", Encode.string data.ideaPrice)
    , ("picture_uris", Encode.string data.pictureUris)
    , ("video_uri", Encode.string data.videoUri)
    , ("token", Encode.string data.token)
    , ("has_nda", Encode.bool data.hasNda)
    , ("is_default_nda", Encode.bool data.isDefaultNda)
    , ("custom_nda", Encode.string data.customNda)]


postDataEncoder : PostData -> Encode.Value
postDataEncoder data =
  Encode.object
    [ ("message", Encode.string data.message)
    , ("media_file_uri", Encode.string data.mediaFileUri)
    , ("innovator_id", Encode.int data.innovator_id)
    , ("organization_id", Encode.int data.organization_id)
    , ("token", Encode.string data.token) ]


contactUsFormEncoder : ContactUsData -> Encode.Value
contactUsFormEncoder data =
  Encode.object
    [ ("name", Encode.string data.name)
    , ("email", Encode.string data.email)
    , ("message", Encode.string data.message) ]



getMemberDataStructEncoder : GetDataRequestStruct -> Encode.Value
getMemberDataStructEncoder data =
  Encode.object
    [ ("id", Encode.int data.id)
    , ("token", Encode.string data.token) ]



tokenEncoder : String -> Encode.Value
tokenEncoder token =
  Encode.object
    [ ("token", Encode.string token) ]


loginDataEncoder : LoggingInMember -> Encode.Value
loginDataEncoder loginData =
  Encode.object
  [ ("email", Encode.string loginData.email)
  , ("password", Encode.string loginData.password)]


organizationRegisterDataEncoder : String -> CompanyRegistration -> Encode.Value
organizationRegisterDataEncoder tarrifPlan regData =
  Encode.object
  [ ("name", Encode.string regData.name)
  , ("email", Encode.string regData.email)
  , ("password", Encode.string regData.password)
  , ("country", Encode.string regData.country)
  , ("receive_newsletter", Encode.bool regData.receiveNewsletterAgreement)
  , ("tariff_plan", Encode.string tarrifPlan)]



innovatorRegisterDataEncoder : String -> InnovatorRegistration -> Encode.Value
innovatorRegisterDataEncoder tarrifPlan regData =
  Encode.object
  [ ("full_name", Encode.string regData.full_name)
  , ("email", Encode.string regData.email)
  , ("password", Encode.string regData.password)
  , ("country", Encode.string regData.country)
  , ("receive_newsletter", Encode.bool regData.receiveNewsletterAgreement)
  , ("tariff_plan", Encode.string tarrifPlan)]


promoDataEncoder : PromoRegistration -> Encode.Value
promoDataEncoder promoData =
  Encode.object
    [ ("full_name", Encode.string promoData.full_name)
    , ("email", Encode.string promoData.email)
    , ("prefered_organization", Encode.string promoData.prefered_organization)
    , ("short_description", Encode.string promoData.short_description)]



signInDataEncoder : AdminPanelSignInData -> Encode.Value
signInDataEncoder signInData =
  Encode.object
    [ ("first_password", Encode.string signInData.first_password)
    , ("second_password", Encode.string signInData.second_password)]



-- DECODERS

signedNdasListDecoder : Decoder (List SignedNDA)
signedNdasListDecoder =
  let
    decoder =
      Pipeline.decode SignedNDA
        |> Pipeline.required "idea_id" (Decode.int)
        |> Pipeline.required "idea_name" (Decode.string)
        |> Pipeline.required "idea_industry" (Decode.string)
        |> Pipeline.required "idea_price" (Decode.string)
        |> Pipeline.required "signing_date" (Decode.string)

  in
    at ["response", "ndas"] (Decode.list decoder)



fullIdeaDataDecoder : Decoder FullIdeaData
fullIdeaDataDecoder =
  let
    decoder =
      Pipeline.decode FullIdeaData
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "short_description" (Decode.string)
        |> Pipeline.required "idea_name" (Decode.string)
        |> Pipeline.required "industry" (Decode.string)
        |> Pipeline.required "tags" (Decode.string)
        |> Pipeline.required "price" (Decode.string)
        |> Pipeline.required "picture_uris" (Decode.string)
        |> Pipeline.required "video_uri" (Decode.string)
        |> Pipeline.required "innovator_id" (Decode.int)
        |> Pipeline.required "innovator_name" (Decode.string)
        |> Pipeline.required "innovator_pic" (Decode.string)
        |> Pipeline.required "long_description" (Decode.string)
        |> Pipeline.required "has_nda" (Decode.bool)
        |> Pipeline.required "is_default_nda" (Decode.bool)
        |> Pipeline.required "custom_nda" (Decode.string)
  in
    at ["response"] decoder



processedSearchDataDecoder : Decoder ProcessedSearchDataWrapper
processedSearchDataDecoder =
  let
    innovator_decoder =
      Pipeline.decode InnovatorExtended
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "name" (Decode.string)
        |> Pipeline.required "pic_uri" (Decode.string)
        |> Pipeline.required "rating" (Decode.int)
        |> Pipeline.required "country" (Decode.string)
        |> Pipeline.required "email" (Decode.string)
        |> Pipeline.required "ideas_count" (Decode.int)
        |> Pipeline.required "innovators_plan_id" (Decode.int)
        |> Pipeline.required "description" (Decode.string)
        |> Pipeline.required "about_me" (Decode.string)
        |> Pipeline.required "education" (Decode.string)
        |> Pipeline.required "experience" (Decode.string)
        |> Pipeline.required "username" (Decode.string)
        |> Pipeline.required "phone" (Decode.string)
        |> Pipeline.required "connections_count" (Decode.int)

    organization_decoder =
      Pipeline.decode OrganizationExtended
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "name" (Decode.string)
        |> Pipeline.required "pic_uri" (Decode.string)
        |> Pipeline.required "country" (Decode.string)
        |> Pipeline.required "email" (Decode.string)
        |> Pipeline.required "complete_ideas_count" (Decode.int)
        |> Pipeline.required "organizations_plan_id" (Decode.int)
        |> Pipeline.required "description" (Decode.string)
        |> Pipeline.required "webpage" (Decode.string)
        |> Pipeline.required "about_us" (Decode.string)
        |> Pipeline.required "industry" (Decode.string)
        |> Pipeline.required "interested_industries" (Decode.string)
        |> Pipeline.required "username" (Decode.string)
        |> Pipeline.required "phone" (Decode.string)
        |> Pipeline.required "rating" (Decode.int)
        |> Pipeline.required "connections_count" (Decode.int)

    post_decoder =
      Pipeline.decode ExtendedPostData
        |> Pipeline.required "author_name" (Decode.string)
        |> Pipeline.required "author_desc" (Decode.string)
        |> Pipeline.required "author_pic" (Decode.string)
        |> Pipeline.required "author_id" (Decode.int)
        |> Pipeline.required "post_id" (Decode.int)
        |> Pipeline.required "post_media_file" (Decode.string)
        |> Pipeline.required "post_message" (Decode.string)
        |> Pipeline.required "post_likes" (Decode.int)

    idea_decoder =
      Pipeline.decode IdeaData
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "short_description" (Decode.string)
        |> Pipeline.required "idea_name" (Decode.string)
        |> Pipeline.required "industry" (Decode.string)
        |> Pipeline.required "tags" (Decode.string)
        |> Pipeline.required "price" (Decode.string)
        |> Pipeline.required "picture_uris" (Decode.string)
        |> Pipeline.required "video_uri" (Decode.string)
        |> Pipeline.required "innovator_id" (Decode.int)
        |> Pipeline.required "innovator_name" (Decode.string)
        |> Pipeline.required "innovator_pic" (Decode.string)

    decoder =
      Pipeline.decode ProcessedSearchDataWrapper
        |> Pipeline.required "innovators" (Decode.list innovator_decoder)
        |> Pipeline.required "organizations" (Decode.list organization_decoder)
        |> Pipeline.required "ideas" (Decode.list idea_decoder)
        |> Pipeline.required "posts" (Decode.list post_decoder)

  in
    at ["response"] decoder



postCommentsDecoder : Decoder (List PostCommentData)
postCommentsDecoder =
  let
    decoder =
      Pipeline.decode PostCommentData
        |> Pipeline.required "author_id" (Decode.int)
        |> Pipeline.required "author_is_org" (Decode.bool)
        |> Pipeline.required "author_name" (Decode.string)
        |> Pipeline.required "body" (Decode.string)
        |> Pipeline.required "input_date" (Decode.string)
        |> Pipeline.required "post_id" (Decode.int)
        |> Pipeline.required "token" (Decode.string)

  in
    at ["response", "comments"] (Decode.list decoder)


postCommentDataDecoder : Decoder PostCommentData
postCommentDataDecoder =
  let
    decoder =
      Pipeline.decode PostCommentData
        |> Pipeline.required "author_id" (Decode.int)
        |> Pipeline.required "author_is_org" (Decode.bool)
        |> Pipeline.required "author_name" (Decode.string)
        |> Pipeline.required "body" (Decode.string)
        |> Pipeline.required "input_date" (Decode.string)
        |> Pipeline.required "post_id" (Decode.int)
        |> Pipeline.required "token" (Decode.string)

  in
    at ["response"] decoder



notificationsListDecoder : Decoder (List NotificationItem)
notificationsListDecoder =
  let
    decoder =
      Pipeline.decode NotificationItem
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "title" (Decode.string)
        |> Pipeline.required "body" (Decode.string)
        |> Pipeline.required "notificationType" (Decode.string)
        |> Pipeline.required "requestedIdeaId" (Decode.int)

  in
    at ["response", "notifications"] (Decode.list decoder)



suggestionsDecoder : Decoder (List SuggestedUser)
suggestionsDecoder =
  let
    decoder =
      Pipeline.decode SuggestedUser
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "name" (Decode.string)
        |> Pipeline.required "description" (Decode.string)
        |> Pipeline.required "picture" (Decode.string)

  in
    at ["response", "suggestions"] (Decode.list decoder)



unredMessagesDecoder : Decoder (List IncomingUnredChatMessage)
unredMessagesDecoder =
  let
    decoder =
      Pipeline.decode IncomingUnredChatMessage
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "sender_id" (Decode.int)
        |> Pipeline.required "receiver_id" (Decode.int)
        |> Pipeline.required "body" (Decode.string)
        |> Pipeline.required "sender_is_organization" (Decode.bool)
        |> Pipeline.required "receiver_is_organization" (Decode.bool)
        |> Pipeline.required "inserted_at" (Decode.string)
        |> Pipeline.required "sender_picture_uri" (Decode.string)

  in
    at ["response", "unreds"] (Decode.list decoder)



chatHistoryDecoder : Decoder (List IncomingChatMessage)
chatHistoryDecoder =
  let
    decoder =
      Pipeline.decode IncomingChatMessage
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "sender_id" (Decode.int)
        |> Pipeline.required "receiver_id" (Decode.int)
        |> Pipeline.required "body" (Decode.string)
        |> Pipeline.required "sender_is_organization" (Decode.bool)
        |> Pipeline.required "receiver_is_organization" (Decode.bool)
        |> Pipeline.required "inserted_at" (Decode.string)

  in
    at ["response", "messages"] (Decode.list decoder)



extendedPostsListDecoder : Decoder (List ExtendedPostData)
extendedPostsListDecoder =
  let
    decoder =
      Pipeline.decode ExtendedPostData
        |> Pipeline.required "author_name" (Decode.string)
        |> Pipeline.required "author_desc" (Decode.string)
        |> Pipeline.required "author_pic" (Decode.string)
        |> Pipeline.required "author_id" (Decode.int)
        |> Pipeline.required "post_id" (Decode.int)
        |> Pipeline.required "post_media_file" (Decode.string)
        |> Pipeline.required "post_message" (Decode.string)
        |> Pipeline.required "post_likes" (Decode.int)

  in
    at ["response", "posts"] (Decode.list decoder)



simpleResponseDecoder : Decoder SimpleResponse
simpleResponseDecoder =
  let
    decoder =
      map2 SimpleResponse
        (Decode.field "success" Decode.string)
        (Decode.field "error" Decode.string)
  in
    at ["response"] decoder



organizationExtendedWrapperDecoder : Decoder GetOrganizationDataResponseWrapper
organizationExtendedWrapperDecoder =
  let
    decoder =
      map2 GetOrganizationDataResponseWrapper
        (Decode.field "organization_data" organizationExtendedDecoder)
        (Decode.field "token" Decode.string)

  in
    at ["data"] decoder

organizationExtendedDecoder : Decoder OrganizationExtended
organizationExtendedDecoder =
  let
    decoder =
      Pipeline.decode OrganizationExtended
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "name" (Decode.string)
        |> Pipeline.required "pic_uri" (Decode.string)
        |> Pipeline.required "country" (Decode.string)
        |> Pipeline.required "email" (Decode.string)
        |> Pipeline.required "complete_ideas_count" (Decode.int)
        |> Pipeline.required "organizations_plan_id" (Decode.int)
        |> Pipeline.required "description" (Decode.string)
        |> Pipeline.required "webpage" (Decode.string)
        |> Pipeline.required "about_us" (Decode.string)
        |> Pipeline.required "industry" (Decode.string)
        |> Pipeline.required "interested_industries" (Decode.string)
        |> Pipeline.required "username" (Decode.string)
        |> Pipeline.required "phone" (Decode.string)
        |> Pipeline.required "rating" (Decode.int)
        |> Pipeline.required "connections_count" (Decode.int)
  in
    decoder



innovatorExtendedWrapperDecoder : Decoder GetInnovatorDataResponseWrapper
innovatorExtendedWrapperDecoder =
  let
    decoder =
      map2 GetInnovatorDataResponseWrapper
        (Decode.field "innovator_data" innovatorExtendedDecoder)
        (Decode.field "token" Decode.string)

  in
    at ["data"] decoder

innovatorExtendedDecoder : Decoder InnovatorExtended
innovatorExtendedDecoder =
  let
    decoder =
      Pipeline.decode InnovatorExtended
        |> Pipeline.required "id" (Decode.int)
        |> Pipeline.required "name" (Decode.string)
        |> Pipeline.required "pic_uri" (Decode.string)
        |> Pipeline.required "rating" (Decode.int)
        |> Pipeline.required "country" (Decode.string)
        |> Pipeline.required "email" (Decode.string)
        |> Pipeline.required "ideas_count" (Decode.int)
        |> Pipeline.required "innovators_plan_id" (Decode.int)
        |> Pipeline.required "description" (Decode.string)
        |> Pipeline.required "about_me" (Decode.string)
        |> Pipeline.required "education" (Decode.string)
        |> Pipeline.required "experience" (Decode.string)
        |> Pipeline.required "username" (Decode.string)
        |> Pipeline.required "phone" (Decode.string)
        |> Pipeline.required "connections_count" (Decode.int)
  in
    decoder



signOutResponseDecoder : Decoder SignOutResponse
signOutResponseDecoder =
  let
    decoder =
      map SignOutResponse
        (Decode.field "response" Decode.string)

  in
    decoder



loginDataDecoder : Decoder LoggedInMemberWrapper
loginDataDecoder =
  let
    decoder =
      map2 LoggedInMemberWrapper
        (Decode.field "login_data" memberDataDecoder)
        (Decode.field "error" Decode.string)
  in
    at ["data"] decoder


memberDataDecoder : Decoder LoggedInMember
memberDataDecoder =
  let
    decoder =
      map5 LoggedInMember
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "email" Decode.string)
        (Decode.field "isOrganization" Decode.bool)
        (Decode.field "token" Decode.string)

  in
    decoder



topMembersDecoder : Decoder TopMembers
topMembersDecoder =
  let
    decoder =
      map2 TopMembers
        (Decode.field "organizations" organizationDecoder)
        (Decode.field "innovators" innovatorDecoder)
  in
    at ["data"] decoder


organizationDecoder : Decoder (List TopOrganization)
organizationDecoder =
  let
    decoder =
      map4 TopOrganization
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "pic_uri" Decode.string)
        (Decode.field "country" Decode.string)
  in
    (Decode.list decoder)


innovatorDecoder : Decoder (List TopInnovator)
innovatorDecoder =
  let
    decoder =
      map5 TopInnovator
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "pic_uri" Decode.string)
        (Decode.field "rating" Decode.int)
        (Decode.field "country" Decode.string)
  in
    (Decode.list decoder)




registeredDataDecoder : Decoder DataRegisteredWrapper
registeredDataDecoder =
  let
    decoder =
      map2 DataRegisteredWrapper
        (Decode.field "reg_data" dataDecoder)
        (Decode.field "error" Decode.string)
  in
    at ["data"] decoder


dataDecoder : Decoder DataRegistered
dataDecoder =
  let
    decoder =
      map4 DataRegistered
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "email" Decode.string)
        (Decode.field "token" Decode.string)
  in
    decoder




signInDataDecoder : Decoder RegisteredDataList
signInDataDecoder =
  let
    decoder =
      map2 RegisteredDataList
        (Decode.field "reg_data" (Decode.list promoRegDataDecoder))
        (Decode.field "error" Decode.string)
  in
    at ["data"] decoder


promoRegDataDecoder : Decoder PromoRegData
promoRegDataDecoder =
  let
    decoder =
      map7 PromoRegData
        (Decode.field "id" Decode.int)
        (Decode.field "full_name" Decode.string)
        (Decode.field "email" Decode.string)
        (Decode.field "prefered_organization" Decode.string)
        (Decode.field "idea_id" Decode.int)
        (Decode.field "short_description" Decode.string)
        (Decode.field "register_date" Decode.string)
  in
    decoder



promoDataDecoder : Decoder PromoRegistration
promoDataDecoder =
  let
    decoder =
      map5 PromoRegistration
        (Decode.field "full_name" Decode.string)
        (Decode.field "email" Decode.string)
        (Decode.field "prefered_organization" Decode.string)
        (Decode.field "short_description" Decode.string)
        (Decode.field "error" Decode.string)
  in
    at ["data"] decoder
