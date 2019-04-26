module Messages exposing (..)

import Navigation exposing (Location)
import Http exposing (..)


import Ports exposing (PostImageChooserData, PostMediaUriData, MediaFileChooserData, ChatMessageSenderData)
import Models exposing (PromoRegistration, RegisteredDataList, DataRegisteredWrapper, TopMembers, LoggedInMemberWrapper,
  SignOutResponse, GetInnovatorDataResponseWrapper, GetOrganizationDataResponseWrapper, SimpleResponse, ExtendedPostData,
  ChatMessageReceiverData, SuggestedUser, NotificationItem, Language, PostCommentData, ProcessedSearchDataWrapper,
  InnovatorExtended, OrganizationExtended, IdeaData, FullIdeaData, IncomingChatMessage,
  IncomingUnredChatMessage, CacheDataWrapper, SignedNDA)

type Msg =
  OnLocationChange Location
  | OnPricingOpen
  | OnPricingClose
  | OnGetStartedButtonsSwitch
  | OnLoginButtonSwitch
  | OnIdeaGeneratorRegistrationOpen
  | OnCompanyRegistrationOpen
  | OnLandingUsernameType String
  | OnLandingEmailType String
  | OnLandingCompanyType String
  | OnLandingShortIdeaType String
  | OnLandingSignUp
  | OnLandingSignUpMobileClick
  | PromoRegistrationCallCompleted (Result Http.Error PromoRegistration)
  | AdminPanelSignInCompleted (Result Http.Error RegisteredDataList)
  | OnAdminPanelFirstPasswordInput String
  | OnAdminPanelSecondPasswordInput String
  | OnAdminPanelSignIn
  | OnMobileGetStartedViewOpen
  | OnMobileRegisterCompanyViewOpen
  | OnMobileRegisterIdeaGeneratorViewOpen
  | OnMobileMenuOpen
  | OnMobileIdeaGeneratorsViewOpen
  | OnMobileOrganizationsViewOpen
  | OnMobilePricingToggle
  | OnMobilePricingIdeaGeneratorsViewOpen
  | OnMobilePricingOrganizationsViewOpen
  | OnMobileTarrifPlansViewOpen
  | OnMobileAboutUsViewOpen
  | OnMobileContactUsViewOpen
  | OnMobileFaqViewOpen
  | OnCompanyRegistrationNameInput String
  | OnCompanyRegistrationEmailInput String
  | OnCompanyRegistrationPasswordInput String
  | OnCompanyRegistrationCountryInput String
  | OnCompanyRegistrationTSAgreementCheck
  | OnCompanyRegistrationReceiveNewletterCheck
  | OnCompanyRegistrationSubmit
  | OnCompanyRegistrationSubmitMobile
  | CompanyRegisterCompleted (Result Http.Error DataRegisteredWrapper)
  | OnInnovatorRegistrationNameInput String
  | OnInnovatorRegistrationEmailInput String
  | OnInnovatorRegistrationPasswordInput String
  | OnInnovatorRegistrationCountryInput String
  | OnInnovatorRegistrationTSAgreementCheck
  | OnInnovatorRegistrationReceiveNewletterCheck
  | OnInnovatorRegistrationSubmit
  | OnInnovatorRegistrationSubmitMobile
  | InnovatorRegisterCompleted (Result Http.Error DataRegisteredWrapper)
  | TopMembersFetchCompleted (Result Http.Error TopMembers)
  | OnLoggingInMemberUsernameInput String
  | OnLoggingInMemberPasswordInput String
  | OnLoggingInMemberLogin
  | OnLoggingInMemberCompleted (Result Http.Error LoggedInMemberWrapper)
  | OnSwitchDashboardOptionsVisible
  | OnLocationChangeProfilePage
  | OnDashboardMobileHomePageOpen
  | OnDashboardMobileProfilePageOpen
  | OnDashboardMobileSettingsPageOpen
  | OnSignOutInitiated
  | OnSignOutCompleted (Result Http.Error SignOutResponse)
  | OnGetInnovatorDataCompleted (Result Http.Error GetInnovatorDataResponseWrapper)
  | OnGetOrganizationDataCompleted (Result Http.Error GetOrganizationDataResponseWrapper)
  | OnSubscribeFreeInnovators
  | OnSubscribeBasicInnovators
  | OnSubscribePlusInnovators
  | OnSubscribePremiumInnovators

  | OnSubscribeFreeInnovatorsMobile
  | OnSubscribeBasicInnovatorsMobile
  | OnSubscribePlusInnovatorsMobile
  | OnSubscribePremiumInnovatorsMobile

  | OnSubscribeBasicOrganization
  | OnSubscribePlusOrganization
  | OnSubscribePremiumOrganization
  | OnSubscribeMaxOrganization

  | OnSubscribeBasicOrganizationMobile
  | OnSubscribePlusOrganizationMobile
  | OnSubscribePremiumOrganizationMobile
  | OnSubscribeMaxOrganizationMobile


  | OnContactUsNameInput String
  | OnContactUsEmailInput String
  | OnContactUsMessageInput String
  | OnContactUsFormSubmit
  | OnContactUsFormSubmitCompleted (Result Http.Error SimpleResponse)
  | OnPostImageNameChoosen PostImageChooserData
  | OnPostMessageInput String
  | OnGetUploadedMediaFileUri PostMediaUriData
  | OnSubmitPost
  | OnSubmitPostCompleted (Result Http.Error SimpleResponse)
  | OnSubmitIdeaCompleted (Result Http.Error SimpleResponse)
  | OnFetchExtendedPostsCompleted (Result Http.Error (List ExtendedPostData))
  | OnDashboardNewIdeaPageVisible
  | OnMobileDashboardNewIdeaPageVisible

  | OnNewIdeaNameInput String
  | OnNewIdeaIndustryInput String
  | OnNewIdeaTagsInput String
  | OnNewIdeaShortDescriptionInput String
  | OnNewIdeaPriceInput String
  | OnNewIdeaLongDescriptionInput String
  | OnNewIdeaSubmit

  | OnIdeaPicNameChoosen MediaFileChooserData
  | OnIdeaVideoNameChoosen MediaFileChooserData
  | OnGetUploadedVideoFileUri PostMediaUriData
  | OnGetFakeInterOpResponse String
  | OnGetIdeaPictureUris PostMediaUriData
  | OnToggleChatWindow (Maybe ChatMessageReceiverData)
  | OnInputChatMessage String
  | OnSubmitChatMessage
  | OnIncomingChatMessage IncomingChatMessage
  | OnChatMessageError PostMediaUriData
  | OnChatHistoryFetchCompleted (Result Http.Error (List IncomingChatMessage))
  | OnExtendedUnredMessageIncome IncomingUnredChatMessage
  | OnFetchUnredChatMessagesCompleted (Result Http.Error (List IncomingUnredChatMessage))
  | OnNewMessagesNotifsVisibilityToggle
  | OnUnredChatMessageClick Int
  | OnMarkMessageAsRedReply ChatMessageSenderData
  | OnFetchSuggestionsCompleted (Result Http.Error (List SuggestedUser))
  | OnMakeConnectionCompleted (Result Http.Error SimpleResponse)
  | OnMakeConnectionInitiated Int

  | OnSwitchSettingsPage
  | OnSwitchTariffPlansPage

  | OnSettingsUsernameEditable
  | OnSettingsNameEditable
  | OnSettingsSurnameEditable
  | OnSettingsPhoneEditable
  | OnSettingsEmailEditable
  | OnSettingsAboutEditable
  | OnSettingsEducationEditable
  | OnSettingsExperienceEditable
  | OnSettingsCountryEditable
  | OnSettingsChangePasswordEditable

  | OnOrgSettingsUsernameEditable
  | OnOrgSettingsNameEditable
  | OnOrgSettingsWebpageEditable
  | OnOrgSettingsPhoneEditable
  | OnOrgSettingsEmailEditable
  | OnOrgSettingsAboutEditable
  | OnOrgSettingsDescriptionEditable
  | OnOrgSettingsIndustryEditable
  | OnOrgSettingsInterestedIndustriesEditable
  | OnOrgSettingsCountryEditable
  | OnOrgSettingsChangePasswordEditable

  | OnInnovatorSettingsUsernameInput String
  | OnInnovatorSettingsNameInput String
  | OnInnovatorSettingsSurnameInput String
  | OnInnovatorSettingsPhoneInput String
  | OnInnovatorSettingsEmailInput String
  | OnInnovatorSettingsAboutInput String
  | OnInnovatorSettingsEducationInput String
  | OnInnovatorSettingsExperienceInput String
  | OnInnovatorSettingsCountryInput String
  | OnInnovatorSettingsChangePasswordInput String
  | OnInnovatorSettingsSaveChanges
  | OnInnovatorSettingsPicNameReceived MediaFileChooserData
  | OnGetFakeInterOpResponse2 String
  | OnGetUploadedSettingsPicUri PostMediaUriData
  | OnUpdateInnovatorSettingsCompleted (Result Http.Error GetInnovatorDataResponseWrapper)
  | OnSubscribeTariffPlanCompleted (Result Http.Error SimpleResponse)
  | OnSelectTariffPlan String

  | OnOrganizationSettingsUsernameInput String
  | OnOrganizationSettingsNameInput String
  | OnOrganizationSettingsPhoneInput String
  | OnOrganizationSettingsEmailInput String
  | OnOrganizationSettingsAboutInput String
  | OnOrganizationSettingsIndustryInput String
  | OnOrganizationSettingsInterestedIndustriesInput String
  | OnOrganizationSettingsCountryInput String
  | OnOrganizationSettingsChangePasswordInput String
  | OnOrganizationSettingsWebpageInput String
  | OnOrganizationSettingsDescriptionInput String
  | OnOrganizationSettingsSaveChanges
  | OnGetFakeInterOpResponse3 String
  | OnOrganizationSettingsPicNameReceived MediaFileChooserData
  | OnGetUploadedOrgSettingsPicUri PostMediaUriData
  | OnUpdateOrganizationSettingsCompleted (Result Http.Error GetOrganizationDataResponseWrapper)

  | OnFetchNewNotificationsCompleted (Result Http.Error (List NotificationItem))
  | OnNewNotifsVisibilityToggle
  | OnNewNotifItemClick Int
  | OnMarkNotifAsRedCompleted (Result Http.Error SimpleResponse)
  | OnRegularNewNotifsFetch String

  | OnSwitchLang Language

  | OnPostLikeClicked Int
  | OnPostLikedCompleted (Result Http.Error SimpleResponse)

  | OnPostCommentSubmitCompleted (Result Http.Error PostCommentData)
  | OnPostCommentsFetchCompleted (Result Http.Error (List PostCommentData))
  | OnPostCommentsClicked Int
  | OnCurrentPostCommentInput String
  | OnSubmitComment
  | OnSharePostOnFacebook String
  | OnShareProfileOnFacebook String

  | OnProcessSearchCompleted (Result Http.Error ProcessedSearchDataWrapper)
  | OnInputSearch String
  | OnSubmitSearch

  | OnSeeOtherInnovator InnovatorExtended
  | OnSeeOtherOrganization OrganizationExtended

  | OnCheckConnectionAndConnectCompleted (Result Http.Error SimpleResponse)
  | OnConnectInitiated Int Bool

  | OnToggleMobileSearchInput
  | OnViewIdeaPageSwitch IdeaData

  | OnFullDescRequestCompleted (Result Http.Error SimpleResponse)
  | OnFullDescRequestInitiated Int Int

  | OnAcceptRejectFullDescCompleted (Result Http.Error SimpleResponse)
  | OnAcceptRejectFullDescInitiated Int Int

  | OnGetFullIdeaDataCompleted (Result Http.Error FullIdeaData)

  | OnViewFullIdeaData Int Int String

  | OnNDAAccepted String
  | OnNDARejected String

  | OnSaveNdaCallCompleted (Result Http.Error SimpleResponse)

  | OnFetchCachedDataCompleted CacheDataWrapper

  | OnSwitchToDashboard
  | OnSwitchToHomePage String
  | OnDoubleLocationSwitch String

  | OnSwitchNDAsPage

  | OnFetchSignedNdasCompleted (Result Http.Error (List SignedNDA))
  | OnOpenNDAsIdea Int

  | OnBackButtonPressed
  | OnBackButtonPressedMobile

  | OnHasNdaClicked
  | OnNdaTypeClicked String
  | OnCustomNdaInput String

  | OnTestMessage
