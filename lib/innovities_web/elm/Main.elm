module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location)

import Messages exposing (..)
import Routes exposing (..)
import Models exposing (..)
import TarrifPlans exposing (..)
import TopMembersList exposing (..)
import AboutUsView exposing (..)
import ContactUsView exposing (..)
import FaqView exposing (..)
import FooterView exposing (..)
import HeaderView exposing (..)
import IntroInfo exposing (..)
import LandingPageView exposing (..)
import Networking exposing (..)
import Ports exposing (..)
import AdminPanelView exposing (..)
import CountriesList as CL exposing (..)
import Utils exposing (..)
import DashboardView exposing (..)
import ChatWindowView exposing (..)
import Updater exposing (update)
import BackButtonView exposing (..)
import TestView exposing (testView)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


init : Location -> (Model, Cmd Msg)
init location =
    let
      currentRoute =
        parseLocation location
    in
      ( initialModel currentRoute, topMembersFetchCmd )

initialModel : Route -> Model
initialModel route =
  let
    initialCountry = makeRealString (List.head CL.countries)
  in
    Model route Closed False False False False "" "" "" "" False "" "" "" "" "" True "" [] "" "" "" False False False
      False True False False False False False False False False False False (CompanyRegistration "" "" "" initialCountry False False "")
      (InnovatorRegistration "" "" "" initialCountry False False "") (DataRegistered 0 "" "" "") [] [] (LoggingInMember "" "" "")
      (LoggedInMember 0 "" "" False "") False MobileHomePage (InnovatorExtended 0 "" "" 0 "" "" 0 0 "" "" "" "" "" "" 0)
      (OrganizationExtended 0 "" "" "" "" 0 0 "" "" "" "" "" "" "" 0 0) NotSelectedForInnovators NotSelectedForOrganizations
      (ContactUsData "" "" "" "") (PostData 0 0 "" "" "" "" "") [] (NewIdeaData "" "" "" "" "" "" "" "" "" "" 0 "" "" False True "")
      (NewChatMessageData 0 0 False False "" "" "" "") False [] [] False [ (SuggestedUser 0 "" "" ""),
      (SuggestedUser 0 "" "" ""), (SuggestedUser 0 "" "" "") ]
      (InnovatorSettingsFieldsEditable False False False False False False False False False False)
      (InnovatorSettingsFields 0 "" "" "" 0 "" "" 0 0 "" "" "" "" "" "" "" "" "" "") ""
      (OrganizationSettingsFields 0 "" "" "" "" 0 0 "" "" "" "" "" "" "" "" "" "" "")
      (OrganizationSettingsFieldsEditable False False False False False False False False False False False) [] False
      Eng [] (PostCommentData 0 False "" "" "" 0 "") 0 (ProcessedSearchDataWrapper [] [] [] []) (SearchProgress "" Idle)
      HomePage (InnovatorExtended 0 "" "" 0 "" "" 0 0 "" "" "" "" "" "" 0) (OrganizationExtended 0 "" "" "" "" 0 0 "" "" "" "" "" "" "" 0 0)
      [] False (IdeaData 0 "" "" "" "" "" "" "" 0 "" "") (FullIdeaData 0 "" "" "" "" "" "" "" 0 "" "" "" False True "") [] [] []




-- VIEW

view : Model -> Html Msg
view model =
    div [ class "uk-height-large" ]
    [ div [ class "uk-container", style [("paddingTop", "12px")] ]
      [ page model
      ]
    ]

page : Model -> Html Msg
page model =
  let
    currentRoute = model.route
  in
    case currentRoute of
      HomeRoute ->
        homeView model
      DashboardRoute ->
        dashboardView model
      AdminRoute ->
        adminView model
      NotFoundRoute ->
        div [] [ text "not found" ]



homeView : Model -> Html Msg
homeView model =
  let
    vis =
      if model.mobileMenuView then
        ("display", "none")
      else
        ("display", "initial")

    loggedInData = model.loggedInData

  in
    div []
      [ backButtonView model
      , backButtonViewMobile model
      , headerView model
      , div [ style [ vis ] ] [ br [][], br [][], br [][] ]
      , mobileMenuScreenView model
      , infoView model
      , ideaGeneratorsPlan model
      , ideaGeneratorsPlanTab model
      , organizationsPlan model
      , organizationsPlanTab model
      , tarrifPlansMobile model
      , innovatorsList model
      , innovatorsListTab model
      , innovatorsListMobile model
      , organizationsList model
      , organizationsListTab model
      , organizationsListMobile model
      , br[][], br[][], br[][]
      , aboutUsView
      , aboutUsViewTab
      , aboutUsMobileView model
      , br[][], br[][], br[][]
      , contactUsView model
      , contactUsViewTab model
      , contactUsViewMobile model
      , br[][], br[][], br[][]
      , faqView
      , faqViewTab
      , faqViewMobile model.mobileFaqView
      , br[][], br[][], br[][]
      , br[][], br[][]
      , footerView
      , footerViewTab
      , chatWindowView model
      ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
      [ sendFakeInterOpResponseForLocationSwitch OnDoubleLocationSwitch
      , fetchCachedDataResponse OnFetchCachedDataCompleted
      , ndaRejected OnNDARejected
      , ndaAccepted OnNDAAccepted
      , regularNewNotifsFetch OnRegularNewNotifsFetch
      , replyWithOrgSettingsPicUri OnGetUploadedOrgSettingsPicUri
      , getOrgSettingsImageName OnOrganizationSettingsPicNameReceived
      , sendFakeInterOpResponse3 OnGetFakeInterOpResponse3
      , replyWithSettingsPicUri OnGetUploadedSettingsPicUri
      , sendFakeInterOpResponse2 OnGetFakeInterOpResponse2
      , getSettingsImageName OnInnovatorSettingsPicNameReceived
      , replyToMarkAsRedWithSendersData OnMarkMessageAsRedReply
      , replyWithUnredChatMessageWithPic OnExtendedUnredMessageIncome
      , chatMessageSubmitError OnChatMessageError
      , incomingChatMessage OnIncomingChatMessage
      , replyWithIdeaPictureUris OnGetIdeaPictureUris
      , sendFakeInterOpResponse OnGetFakeInterOpResponse
      , getIdeaPicName OnIdeaPicNameChoosen
      , replyWithIdeaVideoFileUri OnGetUploadedVideoFileUri
      , getIdeaVideoName OnIdeaVideoNameChoosen
      , getPostImageName OnPostImageNameChoosen
      , replyWithPostMediaFileUri OnGetUploadedMediaFileUri
      ]
