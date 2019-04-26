module Models exposing (..)

import Routes exposing (Route)


type alias Model =
  { route : Route
  , pricingOpened : PricingOpen
  , getStartedOpened : Bool
  , loginOpened : Bool
  , registerIdeaGeneratorOpened : Bool
  , registerCompanyOpened : Bool
  , landingUsername : String
  , landingEmail : String
  , landingCompany : String
  , landingShortIdea : String
  , landingSignUpMobileVisible : Bool
  , landingUsernameError : String
  , landingEmailError : String
  , landingCompanyError : String
  , landingShortIdeaError : String
  , landingPromoRegisterError : String
  , landingInputFieldsVisible : Bool
  , adminPanelSignInError : String
  , adminPanelRegDataList : List PromoRegData
  , adminPanelFirstPassword : String
  , adminPanelSecondPassword : String
  , adminPanelSignInError : String
  , adminPanelSignedIn : Bool
  , mobileGetStartedOpened : Bool
  , mobileRegisterCompanyOpened : Bool
  , mobileRegisterIdeaGeneratorOpened : Bool
  , mobileDefaultView : Bool
  , mobileMenuView : Bool
  , mobileIdeaGeneratorsView : Bool
  , mobileOrganizationsView : Bool
  , mobilePricingToggleOpen : Bool
  , mobilePricingIdeaGeneratorsView : Bool
  , mobilePricingOrganizationsView : Bool
  , mobileAboutUsView : Bool
  , mobileContactView : Bool
  , mobileFaqView : Bool
  , mobileTarrifPlansView : Bool
  , companyUnderRegistration : CompanyRegistration
  , innovatorUnderRegistration : InnovatorRegistration
  , loggedInData : DataRegistered
  , topInnovators : List TopInnovator
  , topOrganizations : List TopOrganization
  , loggingInMember : LoggingInMember
  , loggedInMember : LoggedInMember
  , dashboardOptionsVisible : Bool
  , dashboardMobilePage : MobilePage
  , currentInnovatorExtended : InnovatorExtended
  , currentOrganizationExtended : OrganizationExtended
  , selectedInnovatorsPlan : InnovatorsPlan
  , selectedOrganizationsPlan : OrganizationsPlan
  , contactUsData : ContactUsData
  , postData : PostData
  , postList : List ExtendedPostData
  , newIdeaData : NewIdeaData
  , newChatMessageData : NewChatMessageData
  , chatWindowOpened : Bool
  , currentChatHistory : List IncomingChatMessage
  , pendingUnredMessages : List IncomingUnredChatMessage
  , newMessagesNotifsVisible : Bool
  , suggestedUsers : List SuggestedUser
  , innovatorSettingsFieldsEditable : InnovatorSettingsFieldsEditable
  , innovatorSettingsFields : InnovatorSettingsFields
  , tariffPlanSubError : String
  , organizationSettingsFields : OrganizationSettingsFields
  , organizationSettingsFieldsEditable : OrganizationSettingsFieldsEditable
  , notifications : List NotificationItem
  , newNotificationsVisible : Bool
  , language : Language
  , currentPostComments : List PostCommentData
  , currentCommentData : PostCommentData
  , currentPostWithComments : Int
  , searchedData : ProcessedSearchDataWrapper
  , searchProgress : SearchProgress
  , desktopPage : DesktopPage
  , seeOtherInnovator : InnovatorExtended
  , seeOtherOrganization : OrganizationExtended
  , connections : List MapItem
  , mobileSearchVisible : Bool
  , viewingCurrentIdea : IdeaData
  , viewingCurrentFullIdea : FullIdeaData
  , mobilePageHistory : List MobilePage
  , pageHistory : List DesktopPage
  , signedNDAs : List SignedNDA
  }

type alias SignedNDA =
  { idea_id : Int
  , idea_name : String
  , idea_industry : String
  , idea_price : String
  , signing_date : String
  }

type alias UserIdentifierWrapper =
  { id : Int
  , is_org : Bool
  , token : String
  }

type alias CacheDataWrapper =
  { loggedInMember : LoggedInMember
  , dashboardMobilePage : String
  , currentInnovatorExtended : InnovatorExtended
  , currentOrganizationExtended : OrganizationExtended
  , postList : List ExtendedPostData
  , currentChatHistory : List IncomingChatMessage
  , pendingUnredMessages : List IncomingUnredChatMessage
  , suggestedUsers : List SuggestedUser
  , notifications : List NotificationItem
  , language : String
  , desktopPage : String
  , seeOtherInnovator : InnovatorExtended
  , seeOtherOrganization : OrganizationExtended
  , viewingCurrentIdea : IdeaData
  , viewingCurrentFullIdea : FullIdeaData
  , mobilePageHistory : List String
  , pageHistory : List String
  , signedNDAs : List SignedNDA
  }

type alias NDAFullDataWrapper =
  { author_id : Int
  , author_is_org : Bool
  , idea_id : Int
  , recipient_id : Int
  , recipient_is_org : Bool
  , token : String
  , is_default_nda : Bool
  }

type alias AcceptRejectFullDescWrapper =
  { notif_id : Int
  , res_code : Int
  , token : String
  }

type alias FullDescReqWrapper =
  { notification_type_code : Int
  , requested_idea_id : Int
  , addressed_to : Int
  , addressed_to_is_org : Bool
  , requested_from : Int
  , requested_from_is_org : Bool
  , token : String
  }

type alias SearchProgress =
  { typedSearch : String
  , progressStatus : SearchProgressStatus
  }

type SearchProgressStatus =
  Idle
  | Loading
  | Loaded

type alias ProcessedSearchDataWrapper =
  { innovators : List InnovatorExtended
  , organizations : List OrganizationExtended
  , ideas : List IdeaData
  , posts : List ExtendedPostData
  }

type alias SearchData =
  { query : String
  , token : String
  , user_id : Int
  , user_is_org : Bool
  }

type alias IdeaData =
  { id : Int
  , short_description : String
  , idea_name : String
  , industry : String
  , tags : String
  , price : String
  , picture_uris : String
  , video_uri : String
  , innovator_id : Int
  , innovator_name : String
  , innovator_pic : String
  }

type alias FullIdeaData =
  { id : Int
  , short_description : String
  , idea_name : String
  , industry : String
  , tags : String
  , price : String
  , picture_uris : String
  , video_uri : String
  , innovator_id : Int
  , innovator_name : String
  , innovator_pic : String
  , long_description : String
  , has_nda : Bool
  , is_default_nda : Bool
  , custom_nda : String
  }

type alias PostCommentData =
  { author_id : Int
  , author_is_org : Bool
  , author_name : String
  , body : String
  , input_date : String
  , post_id : Int
  , token : String
  }

type alias MapItem =
  { key : String
  , value : String
  }

type Language =
  Eng
  | Arm

type alias NotificationItem =
  { id : Int
  , title : String
  , body : String
  , notificationType : String
  , requestedIdeaId : Int -- for complete idea desc requests
  }

type alias OrganizationSettingsFields =
  { id : Int
  , name : String
  , pic_uri : String
  , country : String
  , email : String
  , complete_ideas_count : Int
  , organizations_plan_id : Int
  , description : String
  , webpage : String
  , about_us : String
  , industry : String
  , interested_industries : String
  , username : String
  , phone : String
  , changePassword : String
  , pic_name : String
  , error : String
  , token : String
  }

type alias OrganizationSettingsFieldsEditable =
  { name : Bool
  , country : Bool
  , email : Bool
  , description : Bool
  , webpage : Bool
  , about_us : Bool
  , industry : Bool
  , interested_industries : Bool
  , username : Bool
  , phone : Bool
  , changePassword : Bool
  }

type alias TariffPlanSubscriptionData =
  { id : Int
  , is_organization : Bool
  , tariff_plan_name : String
  , token : String
  }

type alias InnovatorSettingsFields =
  { id : Int
  , name : String
  , surname : String
  , pic_uri : String
  , rating : Int
  , country : String
  , email : String
  , ideas_count : Int
  , innovators_plan_id : Int
  , description : String
  , about_me : String
  , education : String
  , experience : String
  , username : String
  , phone : String
  , changePassword : String
  , pic_name : String
  , error : String
  , token : String
  }

type alias InnovatorSettingsFieldsEditable =
  { username : Bool
  , name : Bool
  , surname : Bool
  , phone : Bool
  , email : Bool
  , about : Bool
  , education : Bool
  , experience : Bool
  , country : Bool
  , changePassword : Bool
  }

type alias ConnectionData =
  { sender_id : Int
  , sender_is_organization : Bool
  , receiver_id : Int
  , receiver_is_organization : Bool
  , token : String
  }

type alias SuggestedUser =
  { id : Int
  , name : String
  , description : String
  , picture : String
  }

type alias UnredChatMessagesRequestWrapper =
  { receiver_id : Int
  , receiver_is_organization : Bool
  , token : String
  }

type alias ChatHistoryRequestWrapper =
  { to_id : Int
  , from_id : Int
  , to_is_organization : Bool
  , from_is_organization : Bool
  , token : String
  }

type alias NewChatMessageData =
  { to_id : Int
  , from_id : Int
  , sender_is_organization : Bool
  , receiver_is_organization : Bool
  , body : String
  , receiver_name : String
  , error : String
  , token : String
  }

type alias NewIdeaData =
  { ideaName : String
  , industry : String
  , tags : String
  , shortDescription : String
  , ideaPrice : String
  , longDescription : String
  , pictureUris : String
  , videoUri : String
  , error : String
  , token : String
  , innovator_id : Int
  , videoName : String
  , pictureNames : String
  , hasNda : Bool
  , isDefaultNda : Bool
  , customNda : String
  }

type alias ExtendedPostData =
  { author_name : String
  , author_desc : String
  , author_pic : String
  , author_id : Int
  , post_id : Int
  , post_media_file : String
  , post_message : String
  , post_likes : Int
  }

type alias PostData =
  { innovator_id : Int
  , organization_id : Int
  , message : String
  , mediaFileName : String
  , mediaFileUri : String
  , error : String
  , token : String
  }

type alias SimpleResponse =
  { success : String
  , error : String
  }

type alias ContactUsData =
  { name : String
  , email : String
  , message : String
  , error : String
  }

type InnovatorsPlan =
  NotSelectedForInnovators
  | FreeInnovator
  | BasicInnovator
  | PlusInnovator
  | PremiumInnovator

type OrganizationsPlan =
  NotSelectedForOrganizations
  | BasicOrganization
  | PlusOrganization
  | PremiumOrganization
  | MaxOrganization

type alias InnovatorExtended =
  { id : Int
  , name : String
  , pic_uri : String
  , rating : Int
  , country : String
  , email : String
  , ideas_count : Int
  , innovators_plan_id : Int
  , description : String
  , about_me : String
  , education : String
  , experience : String
  , username : String
  , phone : String
  , connections_count : Int
  }

type alias OrganizationExtended =
  { id : Int
  , name : String
  , pic_uri : String
  , country : String
  , email : String
  , complete_ideas_count : Int
  , organizations_plan_id : Int
  , description : String
  , webpage : String
  , about_us : String
  , industry : String
  , interested_industries : String
  , username : String
  , phone : String
  , rating : Int
  , connections_count : Int
  }

type alias GetInnovatorDataResponseWrapper =
  { innovator_data : InnovatorExtended
  , token : String
  }

type alias GetOrganizationDataResponseWrapper =
  { organization_data : OrganizationExtended
  , token : String
  }

type alias GetDataRequestStruct =
  { id : Int
  , token : String
  }

type alias LoggedInMemberWrapper =
  { login_data : LoggedInMember
  , error : String
  }

type alias LoggedInMember =
  { id : Int
  , name : String
  , email : String
  , isOrganization : Bool
  , token : String
  }

type alias LoggingInMember =
  { email : String
  , password : String
  , loginError : String
  }

type alias TopMembers =
  { organizations : List TopOrganization
  , innovators : List TopInnovator
  }

type alias ChatMessageReceiverData =
  { id : Int
  , name : String
  , is_organization : Bool
  }

type alias TopInnovator =
  { id : Int
  , name : String
  , pic_uri : String
  , rating : Int
  , country : String
  }

type alias TopOrganization =
  { id : Int
  , name : String
  , pic_uri : String
  , country : String
  }

type alias DataRegisteredWrapper =
  { reg_data : DataRegistered
  , error : String
  }

type alias DataRegistered =
  { id : Int
  , name : String
  , email : String
  , token : String
  }

type alias CompanyRegistration =
  { name : String
  , email : String
  , password : String
  , country : String
  , termsOfServiceAgreemant : Bool
  , receiveNewsletterAgreement : Bool
  , registrationError : String
  }

type alias InnovatorRegistration =
  { full_name : String
  , email : String
  , password : String
  , country : String
  , termsOfServiceAgreemant : Bool
  , receiveNewsletterAgreement : Bool
  , registrationError : String
  }

type alias AdminPanelSignInData =
  { first_password : String
  , second_password : String
  }

type alias RegisteredDataList =
  { reg_data : List PromoRegData
  , error : String
  }

type alias PromoRegData =
  { id : Int
  , full_name : String
  , email : String
  , prefered_organization : String
  , idea_id : Int
  , short_description : String
  , register_date : String
  }

type alias PromoRegistration =
  { full_name : String
  , email : String
  , prefered_organization : String
  , short_description : String
  , error : String
  }

type DesktopPage =
  HomePage
  | NewsfeedPage
  | ProfilePage
  | NewIdeaPage
  | SettingsPage
  | TariffPlansPage
  | SearchPage
  | SeeOtherInnovatorPage
  | SeeOtherOrganizationPage
  | ViewIdeaPage
  | ViewFullIdeaPage
  | NDAsPage

type MobilePage =
  MobileHomePage
  | MobileNewsfeedPage
  | MobileProfilePage
  | MobileSettingsPage
  | MobilePostAnIdeaPage
  | MobileSearchPage
  | MobileSeeOtherInnovatorPage
  | MobileSeeOtherOrganizationPage
  | MobileViewIdeaPage
  | MobileViewFullIdeaPage
  | MobileNDAsPage

type alias IncomingChatMessage =
  { id : Int
  , sender_id : Int
  , receiver_id : Int
  , body : String
  , sender_is_organization : Bool
  , receiver_is_organization : Bool
  , inserted_at : String
  }

type alias IncomingUnredChatMessage =
  { id : Int
  , sender_id : Int
  , receiver_id : Int
  , body : String
  , sender_is_organization : Bool
  , receiver_is_organization : Bool
  , inserted_at : String
  , sender_picture_uri : String
  }

type alias SignOutResponse =
  { response : String }

type PricingOpen =
  Opened
  | Closed
