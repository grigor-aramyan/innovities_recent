module Updater exposing (..)

import Navigation exposing (Location)

import Messages exposing (..)
import Models exposing (..)
import Routes exposing (..)
import Networking exposing (..)
import Ports exposing (..)
import TypeToStringUtils as TTSUtils exposing (..)




-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        OnConnectInitiated receiverId receiverIsOrg ->
          let
            currentUser = model.loggedInMember

            data = (ConnectionData currentUser.id currentUser.isOrganization
              receiverId receiverIsOrg currentUser.token)

            cmd =
              checkConnectionAndConnectCmd data
          in
            ( model, cmd )
        OnCheckConnectionAndConnectCompleted res ->
          case res of
            Ok res ->
              let
                currentConnections = model.connections
                updatedConnections =
                  if (String.isEmpty res.success) then
                    currentConnections
                  else
                    [(MapItem res.success res.error)] ++ currentConnections
              in
                ( { model | connections = updatedConnections }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnSeeOtherInnovator otherInnovator ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileSeeOtherInnovatorPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSeeOtherInnovatorPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (SeeOtherInnovatorPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString SeeOtherInnovatorPage) otherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | seeOtherInnovator = otherInnovator
              , desktopPage = SeeOtherInnovatorPage
              , dashboardMobilePage = MobileSeeOtherInnovatorPage
              , mobilePageHistory = MobileSeeOtherInnovatorPage :: model.mobilePageHistory
              , pageHistory = SeeOtherInnovatorPage :: model.pageHistory
              }, cmd )
        OnSeeOtherOrganization otherOrganization ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileSeeOtherOrganizationPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSeeOtherOrganizationPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (SeeOtherOrganizationPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString SeeOtherOrganizationPage) model.seeOtherInnovator otherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | seeOtherOrganization = otherOrganization
              , desktopPage = SeeOtherOrganizationPage
              , dashboardMobilePage = MobileSeeOtherOrganizationPage
              , mobilePageHistory = MobileSeeOtherOrganizationPage :: model.mobilePageHistory
              , pageHistory = SeeOtherOrganizationPage :: model.pageHistory
              }, cmd )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Search ************ --
        OnSubmitSearch ->
          let
            data = model.searchProgress

            currentUser = model.loggedInMember

            mobilePageStr = TTSUtils.mobilePageToString MobileSearchPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSearchPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (SearchPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString SearchPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            msVisibility =
              if (String.isEmpty data.typedSearch) then
                True
              else
                False

            cmd =
              if (String.isEmpty data.typedSearch) then
                Cmd.none
              else
                Cmd.batch
                  [ processSearchCmd (SearchData data.typedSearch currentUser.token
                      currentUser.id currentUser.isOrganization)
                  , cacheAllData cachedData
                  ]

            updatedData =
              if (String.isEmpty data.typedSearch) then
                data
              else
                { data | typedSearch = "", progressStatus = Loading }
          in
            ( { model | searchProgress = updatedData
              , desktopPage = SearchPage
              , dashboardMobilePage = MobileSearchPage
              , mobilePageHistory = MobileSearchPage :: model.mobilePageHistory
              , pageHistory = SearchPage :: model.pageHistory
              , mobileSearchVisible = msVisibility
              }, cmd )
        OnInputSearch newQuery ->
          let
            oldData = model.searchProgress
            updatedData =
              { oldData | typedSearch = newQuery }
          in
            ( { model | searchProgress = updatedData }, Cmd.none )
        OnProcessSearchCompleted res ->
          case res of
            Ok res ->
              let
                oldData = model.searchProgress
                updatedData =
                  { oldData | progressStatus = Loaded, typedSearch = "" }
              in
                ( { model | searchedData = res, searchProgress = updatedData }, Cmd.none )
            Err error ->
              let
                oldData = model.searchProgress
                updatedData =
                  { oldData | progressStatus = Idle }
              in
                ( { model | searchProgress = updatedData }, Cmd.none )


        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Navigation ************ --
        OnDoubleLocationSwitch pathString ->
          let
            cmd =
              scrollToElement pathString
          in
            ( model, cmd )
        OnSwitchToHomePage pathString ->
          let
            cmd =
              Cmd.batch
                [ reverseBackgroundImage ""
                , Navigation.newUrl ("#" ++ pathString)
                , initFakeInterOpForLocationSwitch pathString
                ]
          in
            ( { model | pricingOpened = Closed }, cmd )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Mixed ************ --
        OnCustomNdaInput newCustomNda ->
          let
            oldIdeaData = model.newIdeaData
            updatedIdeaData = { oldIdeaData | customNda = newCustomNda }
          in
            ( { model | newIdeaData = updatedIdeaData }, Cmd.none )
        OnNdaTypeClicked ndaType ->
          let
            oldIdeaData = model.newIdeaData

            updatedIdeaData =
              case ndaType of
                "Default" -> { oldIdeaData | isDefaultNda = True }
                "Custom" -> { oldIdeaData | isDefaultNda = False }
                _ -> oldIdeaData
          in
            ( { model | newIdeaData = updatedIdeaData }, Cmd.none )
        OnHasNdaClicked ->
          let
            oldIdeaData = model.newIdeaData
            updatedIdeaData = { oldIdeaData | hasNda = not oldIdeaData.hasNda }
          in
            ( { model | newIdeaData = updatedIdeaData }, Cmd.none )
        OnBackButtonPressedMobile ->
          let
            oldPageHistoryMobile = model.mobilePageHistory
            newPageHistoryMobile = List.drop 1 oldPageHistoryMobile

            currentPageMobile =
              case (List.head newPageHistoryMobile) of
                Just mp -> mp
                Nothing -> MobileHomePage

            mobilePageStr = TTSUtils.mobilePageToString currentPageMobile
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) newPageHistoryMobile
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              if currentPageMobile == MobileHomePage then
                Cmd.batch
                  [ Navigation.newUrl "#"
                  , reverseBackgroundImage ""
                  , cacheAllData cachedData
                  ]
              else
                cacheAllData cachedData
          in
            ( { model | mobilePageHistory = newPageHistoryMobile
              , dashboardMobilePage = currentPageMobile
              }, cmd )
        OnBackButtonPressed ->
          let
            oldPageHistory = model.pageHistory
            newPageHistory = List.drop 1 oldPageHistory

            currentPage =
              case (List.head newPageHistory) of
                Just dp -> dp
                Nothing -> HomePage

            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) newPageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString currentPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              if currentPage == HomePage then
                Cmd.batch
                  [ Navigation.newUrl "#"
                  , reverseBackgroundImage ""
                  , cacheAllData cachedData
                  ]
              else
                cacheAllData cachedData
          in
            ( { model | pageHistory = newPageHistory
              , desktopPage = currentPage
              }, cmd )
        OnOpenNDAsIdea ideaId ->
          let
            currentUser = model.loggedInMember

            mobilePageStr = TTSUtils.mobilePageToString MobileViewFullIdeaPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileViewFullIdeaPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (ViewFullIdeaPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString ViewFullIdeaPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              Cmd.batch
                [ getFullIdeaDataCmd (GetDataRequestStruct ideaId currentUser.token)
                , cacheAllData cachedData
                ]
          in
            ( { model | desktopPage = ViewFullIdeaPage
            , dashboardMobilePage = MobileViewFullIdeaPage
            , mobilePageHistory = MobileViewFullIdeaPage :: model.mobilePageHistory
            , pageHistory = ViewFullIdeaPage :: model.pageHistory
            } , cmd )
        OnFetchSignedNdasCompleted res ->
          case res of
            Ok res ->
              let
                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  res)

                cmd =
                  Cmd.batch [ cacheAllData cachedData ]
              in
                ( { model | signedNDAs = res }, cmd )
            Err error ->
              ( { model | signedNDAs = [] }, Cmd.none )
        OnSwitchNDAsPage ->
          let
            currentUser = model.loggedInMember

            updatedMobilePageHistory = MobileNDAsPage :: model.mobilePageHistory
            updatedPageHistory = NDAsPage :: model.pageHistory

            mobilePageStr = TTSUtils.mobilePageToString MobileNDAsPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) updatedMobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) updatedPageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString NDAsPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              Cmd.batch
                [ cacheAllData cachedData
                , fetchSignedNdasCmd (UserIdentifierWrapper currentUser.id currentUser.isOrganization currentUser.token)
                ]

          in
            ( { model | dashboardMobilePage = MobileNDAsPage
              , desktopPage = NDAsPage
              , mobilePageHistory = updatedMobilePageHistory
              , pageHistory = updatedPageHistory
              }, cmd )
        OnSwitchToDashboard ->
          let

            oldPageHistory = model.pageHistory
            newPageHistory = NewsfeedPage :: oldPageHistory
            oldPageHistoryMobile = model.mobilePageHistory
            newPageHistoryMobile = MobileNewsfeedPage :: oldPageHistoryMobile

            mobilePageStr = TTSUtils.mobilePageToString MobileNewsfeedPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) newPageHistoryMobile
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) newPageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString NewsfeedPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              Cmd.batch
                [ Navigation.newUrl "#dashboard"
                , setWhiteBackground ""
                , cacheAllData cachedData
                ]

          in
            ( { model | dashboardMobilePage = MobileNewsfeedPage
              , desktopPage = NewsfeedPage
              , pageHistory = newPageHistory
              , mobilePageHistory = newPageHistoryMobile }, cmd )
        OnFetchCachedDataCompleted data ->
          let
            mPageHistory =
              List.map(\p -> TTSUtils.stringToMobilePage p) data.mobilePageHistory

            pHistory =
              List.map(\p -> TTSUtils.stringToDesktopPage p) data.pageHistory
          in
            ( { model | loggedInMember = data.loggedInMember
              , dashboardMobilePage = TTSUtils.stringToMobilePage data.dashboardMobilePage
              , currentInnovatorExtended = data.currentInnovatorExtended
              , currentOrganizationExtended = data.currentOrganizationExtended
              , postList = data.postList
              , currentChatHistory = data.currentChatHistory
              , pendingUnredMessages = data.pendingUnredMessages
              , suggestedUsers = data.suggestedUsers
              , notifications = data.notifications
              , language = TTSUtils.stringToLang data.language
              , desktopPage = TTSUtils.stringToDesktopPage data.desktopPage
              , seeOtherInnovator = data.seeOtherInnovator
              , seeOtherOrganization = data.seeOtherOrganization
              , viewingCurrentIdea = data.viewingCurrentIdea
              , viewingCurrentFullIdea = data.viewingCurrentFullIdea
              , mobilePageHistory = mPageHistory
              , pageHistory = pHistory
              , signedNDAs = data.signedNDAs
              }, Cmd.none )
        OnSaveNdaCallCompleted res ->
          case res of
            Ok res ->
              let
                organizationExtended = model.currentOrganizationExtended
                updatedOrganizationExtended =
                  { organizationExtended | complete_ideas_count = organizationExtended.complete_ideas_count + 1 }
              in
                ( { model | currentOrganizationExtended = updatedOrganizationExtended }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnNDAAccepted data ->
          let
            currentUser = model.loggedInMember

            currentIdeaInView = model.viewingCurrentFullIdea

            payload =
              case data of
                "default_nda" ->
                  (NDAFullDataWrapper currentIdeaInView.innovator_id False currentIdeaInView.id
                    currentUser.id currentUser.isOrganization currentUser.token True)
                "custom_nda" ->
                  (NDAFullDataWrapper currentIdeaInView.innovator_id False currentIdeaInView.id
                    currentUser.id currentUser.isOrganization currentUser.token False)
                _ ->
                  (NDAFullDataWrapper currentIdeaInView.innovator_id False currentIdeaInView.id
                    currentUser.id currentUser.isOrganization currentUser.token True)

            cmd =
              saveNdaCmd payload
          in
            ( model, cmd )
        OnNDARejected data ->
          let
            emptyFullIdea = (FullIdeaData 0 "" "" "" "" "" "" "" 0 "" "" "" False True "")

            mobilePageStr = TTSUtils.mobilePageToString MobileHomePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileHomePage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (NewsfeedPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString NewsfeedPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea emptyFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | viewingCurrentFullIdea = emptyFullIdea
              , desktopPage = NewsfeedPage
              , dashboardMobilePage = MobileHomePage
              , mobilePageHistory = MobileHomePage :: model.mobilePageHistory
              , pageHistory = NewsfeedPage :: model.pageHistory
              }, cmd )
        OnGetFullIdeaDataCompleted res ->
          case res of
            Ok res ->
              let
                viewingFullIdea = model.viewingCurrentFullIdea

                updatedCurrentFullIdea =
                  if (res.id == 0) then
                    viewingFullIdea
                  else
                    res

                currentOrganization = model.currentOrganizationExtended

                langString =
                  if (model.language == Arm) then
                    "arm"
                  else if (model.language == Eng) then
                    "eng"
                  else
                    ""

                ndaData =
                  if ((res.id /= 0) && res.has_nda && res.is_default_nda) then
                    (NDADataWrapper currentOrganization.name res.innovator_name res.idea_name langString "")
                  else if ((res.id /= 0) && res.has_nda && (not res.is_default_nda)) then
                    (NDADataWrapper currentOrganization.name res.innovator_name res.idea_name langString res.custom_nda)
                  else
                    (NDADataWrapper "" "" "" "" "")

                cmd =
                  if ((res.id == 0) || (not res.has_nda)) then
                    Cmd.none
                  else
                    showNDAConfirmDialog ndaData
              in
                ( { model | viewingCurrentFullIdea = updatedCurrentFullIdea }, cmd )
            Err error ->
              ( model, Cmd.none )
        OnFullDescRequestInitiated ideaId addressedToId ->
          let
            currentUser = model.loggedInMember

            data =
              (FullDescReqWrapper 0 ideaId addressedToId False currentUser.id currentUser.isOrganization currentUser.token)

            cmd =
              fullDescRequestCmd data
          in
            ( model, cmd )
        OnFullDescRequestCompleted res ->
          case res of
            Ok res ->
              let
                hasError =
                  if (not (String.isEmpty res.error)) then
                    True
                  else
                    False

                nextDesktopPage =
                  if hasError then
                    model.desktopPage
                  else
                    NewsfeedPage

                nextMobilePage =
                  if hasError then
                    model.dashboardMobilePage
                  else
                    MobileHomePage

                updatedPageHistory =
                  if hasError then
                    model.pageHistory
                  else
                    NewsfeedPage :: model.pageHistory

                mobileUpdatedPageHistory =
                  if hasError then
                    model.mobilePageHistory
                  else
                    MobileHomePage :: model.mobilePageHistory

                mobilePageStr = TTSUtils.mobilePageToString nextMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) mobileUpdatedPageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) updatedPageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString nextDesktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  cacheAllData cachedData
              in
                ( { model | desktopPage = nextDesktopPage
                  , dashboardMobilePage = nextMobilePage
                  , mobilePageHistory = mobileUpdatedPageHistory
                  , pageHistory = updatedPageHistory }
                  , cmd )
            Err error ->
              ( model, Cmd.none )
        OnViewIdeaPageSwitch ideaData ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileViewIdeaPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileViewIdeaPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (ViewIdeaPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString ViewIdeaPage) model.seeOtherInnovator model.seeOtherOrganization
              ideaData model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | viewingCurrentIdea = ideaData
              , desktopPage = ViewIdeaPage
              , dashboardMobilePage = MobileViewIdeaPage
              , mobilePageHistory = MobileViewIdeaPage :: model.mobilePageHistory
              , pageHistory = ViewIdeaPage :: model.pageHistory
              }, cmd )
        OnToggleMobileSearchInput ->
          ( { model | mobileSearchVisible = not model.mobileSearchVisible }, Cmd.none )
        OnShareProfileOnFacebook profileInfo ->
          let
            cmd =
              shareProfileOnFacebook profileInfo
          in
            ( model, cmd )
        OnSharePostOnFacebook postText ->
          let
            cmd =
              sharePostOnFacebook postText
          in
            ( model, cmd )
        OnSubmitComment ->
          let
            currentUser = model.loggedInMember
            selectedPostId = model.currentPostWithComments
            commentData = model.currentCommentData

            data = (PostCommentData currentUser.id currentUser.isOrganization "" commentData.body "" selectedPostId currentUser.token)
            cmd =
              createCommentCmd data
          in
            ( model, cmd )
        OnCurrentPostCommentInput newBody ->
          let
            oldCommentData = model.currentCommentData
            updatedCommentData =
              { oldCommentData | body = newBody }
          in
            ( { model | currentCommentData = updatedCommentData }, Cmd.none )
        OnPostCommentsFetchCompleted res ->
          case res of
            Ok res ->
              ( { model | currentPostComments = res }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnPostCommentsClicked postId ->
          let
            currentUser = model.loggedInMember

            cmd = fetchPostCommentsCmd (GetDataRequestStruct postId currentUser.token)
          in
            ( { model | currentPostComments = []
              , currentCommentData = (PostCommentData 0 False "" "" "" 0 "")
              , currentPostWithComments = postId }, cmd )
        OnPostCommentSubmitCompleted res ->
          case res of
            Ok res ->
              let
                currentPostCommentsOld = model.currentPostComments

                currentPostCommentsUpdated =
                  if (String.isEmpty res.body) then
                    currentPostCommentsOld
                  else
                    currentPostCommentsOld ++ [res]
              in
                ( { model | currentPostComments = currentPostCommentsUpdated }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnPostLikedCompleted res ->
          case res of
            Ok res ->
              let
                oldList = model.postList

                updatedPostIdStr = res.success

                updatedPostList =
                  if (String.isEmpty updatedPostIdStr) then
                    oldList
                  else
                    List.map (\p ->
                      if (toString(p.post_id) == updatedPostIdStr) then
                        (ExtendedPostData p.author_name p.author_desc p.author_pic p.author_id p.post_id p.post_media_file p.post_message (p.post_likes + 1))
                      else
                        p
                      ) oldList
              in
                ( { model | postList = updatedPostList }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnPostLikeClicked postId ->
          let
            currentUser = model.loggedInMember

            cmd = likePostCmd (GetDataRequestStruct postId currentUser.token)

          in
            ( model, cmd )
        OnSwitchLang lang ->
          ( { model | language = lang }, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Notifications ************ --
        OnViewFullIdeaData ideaId notifId notifBody ->
          let
            currentUser = model.loggedInMember
            currentOrganization = model.currentOrganizationExtended

            langString =
              if (model.language == Arm) then
                "arm"
              else if (model.language == Eng) then
                "eng"
              else
                ""

            mobilePageStr = TTSUtils.mobilePageToString MobileViewFullIdeaPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileViewFullIdeaPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (ViewFullIdeaPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString ViewFullIdeaPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              Cmd.batch
                [ getFullIdeaDataCmd (GetDataRequestStruct ideaId currentUser.token)
                , markNotifAsRedCmd (GetDataRequestStruct notifId currentUser.token)
                --, showNDAConfirmDialog (NDADataWrapper currentOrganization.name notifBody langString)
                , cacheAllData cachedData
                ]
          in
            ( { model | desktopPage = ViewFullIdeaPage
              , dashboardMobilePage = MobileViewFullIdeaPage
              , mobilePageHistory = MobileViewFullIdeaPage :: model.mobilePageHistory
              , pageHistory = ViewFullIdeaPage :: model.pageHistory }, cmd )
        OnAcceptRejectFullDescInitiated notifId code ->
          -- code: 0 -> rejected, 1 -> accepted
          let
            currentUser = model.loggedInMember

            data =
              (AcceptRejectFullDescWrapper notifId code currentUser.token)

            cmd =
              acceptRejectFullDescCmd data
          in
            ( model, cmd )
        OnAcceptRejectFullDescCompleted res ->
          case res of
            Ok res ->
              let
                oldNotifs = model.notifications

                updatedNotifs =
                  if (String.isEmpty res.error) then
                    List.filter (\n -> toString(n.id) /= res.success) oldNotifs
                  else
                    oldNotifs
              in
                ( { model | notifications = updatedNotifs }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnRegularNewNotifsFetch data ->
          let
            loginData = model.loggedInMember

            unredMessagesRequestWrapper =
                  (UnredChatMessagesRequestWrapper loginData.id loginData.isOrganization loginData.token)

            cmd =
              fetchNewNotificationsCmd unredMessagesRequestWrapper
          in
            ( model, cmd )
        OnMarkNotifAsRedCompleted res ->
          case res of
            Ok res ->
              let
                notifId =
                  if (String.isEmpty res.success) then
                    "0"
                  else
                    res.success

                notifsOldList = model.notifications
                updatedList =
                  List.filter (\n -> (toString n.id) /= notifId) notifsOldList

              in
                ( { model | notifications = updatedList }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnNewNotifItemClick notifId ->
          let
            currentUser = model.loggedInMember

            cmd =
              markNotifAsRedCmd (GetDataRequestStruct notifId currentUser.token)
          in
            ( model, cmd )
        OnNewNotifsVisibilityToggle ->
          ( { model | newNotificationsVisible = not model.newNotificationsVisible }, Cmd.none )
        OnFetchNewNotificationsCompleted res ->
          case res of
            Ok res ->
              let
                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers res (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  cacheAllData cachedData
              in
                ( { model | notifications = res }, cmd )
            Err error ->
              ( model, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Tariff Plan Subscription ************ --
        OnSelectTariffPlan tariffPlanName ->
          let
            currentUser = model.loggedInMember

            data =
              (TariffPlanSubscriptionData currentUser.id currentUser.isOrganization
                tariffPlanName currentUser.token)
          in
            ( model, subscribeTariffPlanCmd data )
        OnSubscribeTariffPlanCompleted res ->
          case res of
            Ok res ->
              -- TODO: notify somehow about subscription success
              -- notify from notifications section
              ( { model | tariffPlanSubError = res.error }, Cmd.none )
            Err error ->
              ( { model | tariffPlanSubError = "Couldn't update your tariff plan! Contact with us, please." }
                , Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Organization Settings Fields Input************ --
        OnUpdateOrganizationSettingsCompleted res ->
          case res of
            Ok res ->
              let
                resOrgData = res.organization_data

                oldData = model.organizationSettingsFields
                initialData = { oldData | error = "" }

                currentOldOrgData = model.currentOrganizationExtended

                updatedData =
                  if (resOrgData.id == 0) then
                    { initialData | error = resOrgData.industry }
                  else
                    { initialData | error = "Saved!" }

                updatedOrgData =
                  if (resOrgData.id == 0) then
                    currentOldOrgData
                  else
                    resOrgData

                editables =
                  (InnovatorSettingsFieldsEditable False False False False False False False False False False)
                orgEditables =
                  (OrganizationSettingsFieldsEditable False False False False False False False False False False False)

              in
                ( { model | organizationSettingsFields = updatedData
                  , currentOrganizationExtended = updatedOrgData
                  , innovatorSettingsFieldsEditable = editables
                  , organizationSettingsFieldsEditable = orgEditables }
                  , Cmd.none )
            Err error ->
              let
                oldData = model.organizationSettingsFields
                initialData = { oldData | error = "" }

                updatedData = { initialData | error = "Couldn't update your settings! Try to reload the page and contact with us, please." }
              in
                ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsSaveChanges ->
          let
            initialData = model.organizationSettingsFields
            orgData = { initialData | error = "" }

            round1 =
              if ((String.isEmpty orgData.error) && (String.isEmpty orgData.name)) then
                { orgData | error = "Name required!" }
              else
                orgData

            round2 =
              if ((String.isEmpty round1.error) && (String.isEmpty round1.email)) then
                { round1 | error = "Email required!" }
              else
                round1

            round3 =
              if ((String.isEmpty round2.error) && (String.isEmpty round2.country)) then
                { round2 | error = "Country required!" }
              else
                round2

            currentUser = model.loggedInMember
            dataToSend =
              { round3 | token = currentUser.token }

            cmd =
              if ((String.isEmpty round3.error) && (not (String.isEmpty round3.pic_name))) then
                submitOrgSettingsPicToFirebase round3.pic_name
              else if (String.isEmpty round3.error) then
                -- Submit data to backend
                updateOrganizationSettingsCmd dataToSend
              else
                Cmd.none
          in
            ( { model | organizationSettingsFields = round3 }, cmd )
        OnGetUploadedOrgSettingsPicUri data ->
          let
            oldData = model.organizationSettingsFields
            initialData = { oldData | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | pic_uri = data.uri }
              else
                { initialData | error = data.error }

            currentUser = model.loggedInMember
            dataToSend =
              { updatedData | token = currentUser.token }

            cmd =
              if (String.isEmpty updatedData.error) then
                updateOrganizationSettingsCmd dataToSend
              else
                Cmd.none
          in
            ( { model | organizationSettingsFields = updatedData }, cmd )

        OnOrganizationSettingsPicNameReceived data ->
          let
            initialData = model.organizationSettingsFields
            updatedData =
              { initialData | pic_name = data.fileName
              , error = data.error }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnGetFakeInterOpResponse3 data ->
          ( model, initOrgSettingsMediaBtn "" )
        OnOrganizationSettingsChangePasswordInput newChangePassword ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | changePassword = newChangePassword }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsDescriptionInput newDesc ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | description = newDesc }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsWebpageInput newWebpage ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | webpage = newWebpage }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsCountryInput newCountry ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | country = newCountry }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsInterestedIndustriesInput newInterestedIndustries ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | interested_industries = newInterestedIndustries }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsIndustryInput newIndustry ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | industry = newIndustry }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsAboutInput newAbout ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | about_us = newAbout }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsEmailInput newEmail ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | email = newEmail }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsPhoneInput newPhone ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | phone = newPhone }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        OnOrganizationSettingsNameInput newName ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | name = newName }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )

        OnOrganizationSettingsUsernameInput newUsername ->
          let
            oldData = model.organizationSettingsFields
            updatedData =
              { oldData | username = newUsername }
          in
            ( { model | organizationSettingsFields = updatedData }, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Organization Settings Fields Editable************ --
        OnOrgSettingsUsernameEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | username = not oldData.username }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsNameEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | name = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsWebpageEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | webpage = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsPhoneEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | phone = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsEmailEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | email = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsAboutEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | about_us = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsDescriptionEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | description = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsIndustryEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | industry = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsInterestedIndustriesEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | interested_industries = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsCountryEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | country = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        OnOrgSettingsChangePasswordEditable ->
          let
            oldData = model.organizationSettingsFieldsEditable
            updatedData =
              { oldData | changePassword = True }
          in
            ( { model | organizationSettingsFieldsEditable = updatedData }, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Innovator Settings Fields Input************ --
        OnUpdateInnovatorSettingsCompleted response ->
          case response of
            Ok response ->
              let
                res = response.innovator_data

                oldData = model.innovatorSettingsFields
                initialData = { oldData | error = "" }

                updatedData =
                  if (res.id == 0) then
                    { initialData | error = res.experience }
                  else
                    { initialData | error = "Saved!" }

                currentInnovatorOldData = model.currentInnovatorExtended
                currentInnovatorUpdatedData =
                  if (res.id == 0) then
                    currentInnovatorOldData
                  else
                    res

                editables =
                  (InnovatorSettingsFieldsEditable False False False False False False False False False False)

              in
                ( { model | innovatorSettingsFields = updatedData
                  , currentInnovatorExtended = currentInnovatorUpdatedData
                  , innovatorSettingsFieldsEditable = editables
                  }, Cmd.none )
            Err error ->
              let
                oldData = model.innovatorSettingsFields
                initialData = { oldData | error = "" }

                updatedData =
                  { initialData | error = "Something went wrong! Try again or contact with us, please!" }
              in
                ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnGetUploadedSettingsPicUri data ->
          let
            oldData = model.innovatorSettingsFields
            initialData = { oldData | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | pic_uri = data.uri }
              else
                { initialData | error = data.error }

            currentUser = model.loggedInMember
            dataToSend =
              if (String.isEmpty updatedData.error) then
                { updatedData | token = currentUser.token }
              else
                updatedData

            cmd =
              if (String.isEmpty updatedData.error) then
                updateInnovatorSettingsCmd dataToSend
              else
                Cmd.none
          in
            ( { model | innovatorSettingsFields = updatedData }, cmd )
        OnGetFakeInterOpResponse2 data ->
          ( model, initSettingsMediaBtn "" )
        OnInnovatorSettingsPicNameReceived data ->
          let
            oldData = model.innovatorSettingsFields
            initialData = { oldData | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | pic_name = data.fileName }
              else
                { initialData | error = data.error }

          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsSaveChanges ->
          let
            oldData = model.innovatorSettingsFields
            initialData = { oldData | error = "" }

            round1 =
              if (String.isEmpty initialData.name) then
                { initialData | error = "Name required!" }
              else
                initialData

            round2 =
              if ((String.isEmpty round1.error) && (String.isEmpty round1.surname)) then
                { round1 | error = "Surname required!" }
              else
                round1

            round3 =
              if ((String.isEmpty round2.error) && (String.isEmpty round2.email)) then
                { round2 | error = "Email required!" }
              else
                round2

            round4 =
              if ((String.isEmpty round3.error) && (String.isEmpty round3.country)) then
                { round3 | error = "Country required!" }
              else
                round3

            currentUser = model.loggedInMember
            round5 =
              if (String.isEmpty round4.error) then
                { round4 | token = currentUser.token }
              else
                round4

            cmd =
              if ((String.isEmpty round4.error) && (not (String.isEmpty round4.pic_name))) then
                submitSettingsPicToFirebase round4.pic_name
              else if (String.isEmpty round4.error) then
                updateInnovatorSettingsCmd round5
              else
                Cmd.none
          in
            ( { model | innovatorSettingsFields = round4 }, cmd )
        OnInnovatorSettingsUsernameInput newUsername ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | username = newUsername }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )

        OnInnovatorSettingsNameInput newName ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | name = newName }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsSurnameInput newSurname ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | surname = newSurname }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsPhoneInput newPhone ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | phone = newPhone }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsEmailInput newEmail ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | email = newEmail }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsAboutInput newAbout ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | about_me = newAbout }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsEducationInput newEducation ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | education = newEducation }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsExperienceInput newExperience ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | experience = newExperience }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsCountryInput newCountry ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | country = newCountry }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        OnInnovatorSettingsChangePasswordInput newChangePassword ->
          let
            oldData = model.innovatorSettingsFields
            updatedData =
              { oldData | changePassword = newChangePassword }
          in
            ( { model | innovatorSettingsFields = updatedData }, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Settings Page Editables************ --
        OnSettingsUsernameEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | username = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsNameEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | name = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsSurnameEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | surname = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsPhoneEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | phone = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsEmailEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | email = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsAboutEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | about = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsEducationEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | education = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsExperienceEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | experience = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsCountryEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | country = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        OnSettingsChangePasswordEditable ->
          let
            initialData = model.innovatorSettingsFieldsEditable
            updatedData =
              { initialData | changePassword = True }
          in
            ( { model | innovatorSettingsFieldsEditable = updatedData }, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Settings Page ************ --
        OnSwitchTariffPlansPage ->
          let
            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSettingsPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (TariffPlansPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString TariffPlansPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | desktopPage = TariffPlansPage
              , mobilePageHistory = MobileSettingsPage :: model.mobilePageHistory
              , pageHistory = TariffPlansPage :: model.pageHistory
              }, cmd )
        OnSwitchSettingsPage ->
          let
            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSettingsPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (SettingsPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString SettingsPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

          in
            ( { model | desktopPage = SettingsPage
              , dashboardMobilePage = MobileSettingsPage
              , mobilePageHistory = MobileSettingsPage :: model.mobilePageHistory
              , pageHistory = SettingsPage :: model.pageHistory
              }, Cmd.batch [ initFakeInterOp2 "", initFakeInterOp3 "", cacheAllData cachedData ] )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Connections ************ --
        OnMakeConnectionCompleted res ->
          case res of
            Ok res ->
              let
                currentUser = model.loggedInMember

                cmd =
                  if ((String.isEmpty res.error) && (res.success == "True") && currentUser.isOrganization) then
                    fetchSuggestionsCmd (GetDataRequestStruct currentUser.id currentUser.token) fetchSuggestedInnovatorsUri
                  else if ((String.isEmpty res.error) && (res.success == "True") && (not currentUser.isOrganization)) then
                    fetchSuggestionsCmd (GetDataRequestStruct currentUser.id currentUser.token) fetchSuggestedOrganizationsUri
                  else
                    Cmd.none

                --TODO: increment connections number of current user
              in
                ( model, cmd )
            Err error ->
              ( model, Cmd.none )

        OnMakeConnectionInitiated receiverId ->
          let
            currentUser = model.loggedInMember

            cmd =
              if (currentUser.isOrganization) then
                makeConnectionCmd (ConnectionData currentUser.id True receiverId False currentUser.token)
              else
                makeConnectionCmd (ConnectionData currentUser.id False receiverId True currentUser.token)

          in
            ( model, cmd )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Suggestions ************ --
        OnFetchSuggestionsCompleted res ->
          case res of
            Ok res ->
              let
                currentSuggestions = model.suggestedUsers

                suggestionsList =
                  if ((List.length res) == 3) then
                    res
                  else if ((List.length res) == 0) then
                    currentSuggestions
                  else
                    List.drop (List.length res) currentSuggestions |> (\ cl -> res ++ cl )

              in
                ( { model | suggestedUsers = suggestionsList }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        --*********** Chat messages ************ --
        OnMarkMessageAsRedReply sendersData ->
          let
            -- fetch chat history based on it and show in chat window

            pendingNewMessagesList = model.pendingUnredMessages
            updatedPendingMessagesList =
              List.filter (\m -> m.id /= sendersData.message_id) pendingNewMessagesList

            --/////////////////////////
            newMessageData = (NewChatMessageData sendersData.receiver_id 0 False sendersData.receiver_is_org ""
              sendersData.receiver_name "" "")

            currentUser = model.loggedInMember


            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper currentUser mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory updatedPendingMessagesList
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)


            cmd =
                --**************************************************
                --**************************************
                --TODO: change to dynamic from_id and sender_id_organization and token
                Cmd.batch
                  [ fetchChatHistoryCmd (ChatHistoryRequestWrapper newMessageData.to_id currentUser.id
                      newMessageData.receiver_is_organization currentUser.isOrganization currentUser.token)
                  , cacheAllData cachedData
                  ]

          in
            ( { model | pendingUnredMessages = updatedPendingMessagesList
              , chatWindowOpened = True
              , newChatMessageData = newMessageData }, cmd)
        OnUnredChatMessageClick unredMessageId ->
          let
            -- mark this and previous msgs from this sender as red, return some data,
            -- fetch chat history based on it and show in chat window
            currentUser = model.loggedInMember
            reqDataWrapper = (MarkMessageAsRedWrapper unredMessageId currentUser.token)
          in
            ( model, markAsRedChatMessage reqDataWrapper )
        OnNewMessagesNotifsVisibilityToggle ->
          ( { model | newMessagesNotifsVisible = not model.newMessagesNotifsVisible }, Cmd.none )
        OnFetchUnredChatMessagesCompleted res ->
          case res of
            Ok res ->
              let
                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory res
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  cacheAllData cachedData
              in
                ( { model | pendingUnredMessages = res }, cmd )
            Err error ->
              ( model, Cmd.none )
        OnExtendedUnredMessageIncome unredMessage ->
          -- new unred message with senders pic received, show it in unred messages tab
          let
            initialList = model.pendingUnredMessages

            filteredList =
              List.filter (\m -> (m.sender_id /= unredMessage.sender_id)
                || (m.sender_is_organization /= unredMessage.sender_is_organization)) initialList

            finalList = unredMessage :: filteredList


            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory finalList
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData

          in
            ( { model | pendingUnredMessages = finalList }, cmd )
        OnChatHistoryFetchCompleted res ->
          case res of
            Ok res ->
              let
                tmp = model.newChatMessageData
                initialData = { tmp | error = "" }


                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList res model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  cacheAllData cachedData
              in
                ( { model | newChatMessageData = initialData
                  , currentChatHistory = res }, cmd )
            Err error ->
              let
                tmp = model.newChatMessageData
                initialData = { tmp | error = "Error submitting your message! Try again or contact with us, please" }
              in
                ( { model | newChatMessageData = initialData }, Cmd.none )
        OnChatMessageError data ->
          let
            tmp = model.newChatMessageData
            initialData = { tmp | error = "" }

            updatedData =
              { initialData | error = data.error }
          in
            ( { model | newChatMessageData = updatedData }, Cmd.none )
        OnIncomingChatMessage messageData ->
          let
            chatHistory = model.currentChatHistory
            initialData = model.newChatMessageData

            --**********************************************
            --**********************************************
            newMessageId = messageData.id
            newMessageSenderId = messageData.sender_id
            newMessageSenderIsOrganization = messageData.sender_is_organization
            newMessageReceiverId = messageData.receiver_id
            newMessageReceiverIsOrganization = messageData.receiver_is_organization

            currentUser = model.loggedInMember
            currentUserId = currentUser.id
            currentUserIsOrganization = currentUser.isOrganization

            currentReceiverId = initialData.to_id
            currentReceiverIsOrganization = initialData.receiver_is_organization

            --**************************************************
            --**************************************************

            updatedChatHistory =
              if (((currentUserId == newMessageSenderId) && (currentUserIsOrganization == newMessageSenderIsOrganization) && (currentReceiverId == newMessageReceiverId) && (currentReceiverIsOrganization == newMessageReceiverIsOrganization)) ||
                (currentUserId == newMessageReceiverId) && (currentUserIsOrganization == newMessageReceiverIsOrganization) && (currentReceiverId == newMessageSenderId) && (currentReceiverIsOrganization == newMessageSenderIsOrganization)) then
                --show incoming new message in chat window
                messageData :: chatHistory
              else
                chatHistory

            finalChatHistory =
              if ((List.length updatedChatHistory) > 20) then
                List.take 20 updatedChatHistory
              else
                updatedChatHistory


            pendingMessageData =
              if ((currentUserId == newMessageSenderId) && (currentUserIsOrganization == newMessageSenderIsOrganization) && (currentReceiverId == newMessageReceiverId) && (currentReceiverIsOrganization == newMessageReceiverIsOrganization)) then
                --sent message successfully stored, clear text field and current errors
                { initialData | body = "", error = "" }
              else
                initialData

            cmd =
              if ((currentUserId == newMessageReceiverId) && (currentUserIsOrganization == newMessageReceiverIsOrganization) && ((currentReceiverId /= newMessageSenderId) || (currentReceiverIsOrganization /= newMessageSenderIsOrganization))) then
                --fetch sender pic and show in messages notifs
                fetchMessageSenderPicture messageData
              else if ((currentUserId == newMessageReceiverId) && (currentUserIsOrganization == newMessageReceiverIsOrganization) && (currentReceiverId == newMessageSenderId) && (currentReceiverIsOrganization == newMessageSenderIsOrganization)) then
                markIncomingMessageAsRed (MarkMessageAsRedWrapper newMessageId currentUser.token)
              else
                Cmd.none

          in
            ( { model | currentChatHistory = finalChatHistory
              , newChatMessageData = pendingMessageData }, cmd )
        OnSubmitChatMessage ->
          let
            tmp = model.newChatMessageData
            initialData = { tmp | error = "" }

            round1 =
              if (String.isEmpty initialData.body) then
                { initialData | error = "Type some message to send" }
              else
                initialData

            currentUser = model.loggedInMember

            round2 =
              { round1 | from_id = currentUser.id
              , sender_is_organization = currentUser.isOrganization
              , token = currentUser.token }

            cmd =
              if (String.isEmpty round2.error) then
                --**************************************************
                --**************************************
                --TODO: change to dynamic from_id and sender_id_organization and token
                submitChatMessageToChannel (NewChatMessageWrapper round2.body 20
                  round2.receiver_is_organization round2.sender_is_organization round2.to_id
                  "$2b$12$hlIgRLnkBKntpWFClZZJZevDfRrY5zZyOLgGrnQYPxRrWzYMEGBgK")

              else
                Cmd.none

          in
            ( { model | newChatMessageData = round2 }, cmd )
        OnInputChatMessage newBody ->
          let
            initialData = model.newChatMessageData
            updatedData =
              { initialData | body = newBody }
          in
            ( { model | newChatMessageData = updatedData }, Cmd.none )
        OnToggleChatWindow maybeData ->
          let
            newMessageData =
              case maybeData of
                Nothing ->
                  (NewChatMessageData 0 0 False False "" "" "" "")
                Just data ->
                  (NewChatMessageData data.id 0 False data.is_organization "" data.name "" "")

            windowOpened =
              if (newMessageData.to_id == 0) then
                False
              else
                True

            currentUser = model.loggedInMember

            cmd =
              if (newMessageData.to_id == 0) then
                Cmd.none
              else
                --**************************************************
                --**************************************
                --TODO: change to dynamic from_id and sender_id_organization and token
                --fetchChatHistoryCmd (ChatHistoryRequestWrapper newMessageData.to_id 20
                  --newMessageData.receiver_is_organization False "$2b$12$hlIgRLnkBKntpWFClZZJZevDfRrY5zZyOLgGrnQYPxRrWzYMEGBgK")
                fetchChatHistoryCmd (ChatHistoryRequestWrapper newMessageData.to_id currentUser.id
                  newMessageData.receiver_is_organization currentUser.isOrganization currentUser.token)

          in
            ( { model | chatWindowOpened = windowOpened
              , newChatMessageData = newMessageData }
              , cmd )

        --////////////////////////////////////////////////////////
        --////////////////////////////////////////////
        --/////////////////////////////////
        OnGetIdeaPictureUris data ->
          let
            tmp = model.newIdeaData
            initialData = { tmp | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | pictureUris = data.uri }
              else
                { initialData | error = data.error }

            cmd =
              if ((String.isEmpty updatedData.error) && (not (String.isEmpty updatedData.videoName))) then
                submitVideoFileToFirebase updatedData.videoName
              else if (String.isEmpty updatedData.error) then
                submitNewIdeaCmd updatedData
              else
                Cmd.none

          in
            ( { model | newIdeaData = updatedData }, cmd )

        OnIdeaPicNameChoosen data ->
          let
            tmp = model.newIdeaData
            initialData = { tmp | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | pictureNames = (initialData.pictureNames ++ data.fileName ++ ", ") }
              else
                { initialData | error = data.error }

          in
            ( { model | newIdeaData = updatedData }, Cmd.none )
        OnGetUploadedVideoFileUri data ->
          let
            tmp = model.newIdeaData
            initialData = { tmp | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | videoUri = data.uri }
              else
                { initialData | error = data.error }

            loggedInMember = model.loggedInMember
            loggedInInno = model.currentInnovatorExtended
            round2 =
              if (String.isEmpty updatedData.error) then
                { updatedData | token = loggedInMember.token, innovator_id = loggedInInno.id }
              else
                updatedData

            cmd =
              if (String.isEmpty round2.error) then
                submitNewIdeaCmd round2
              else
                Cmd.none
          in
            ( { model | newIdeaData = round2 }, cmd )
        OnIdeaVideoNameChoosen data ->
          let
            tmp = model.newIdeaData
            initialData = { tmp | error = "" }

            updatedData =
              if (String.isEmpty data.error) then
                { initialData | videoName = data.fileName }
              else
                { initialData | error = data.error }

          in
            ( { model | newIdeaData = updatedData }, Cmd.none )
        OnSubmitIdeaCompleted res ->
          case res of
            Ok res ->
              let
                initialData = model.newIdeaData
                innovatorExtended = model.currentInnovatorExtended

                updatedInnovatorExtended =
                  if (String.isEmpty res.error) then
                    { innovatorExtended | ideas_count = innovatorExtended.ideas_count + 1 }
                  else
                    innovatorExtended

                updatedData =
                  if (String.isEmpty res.error) then
                    { initialData | ideaName = "", industry = "", tags = "", shortDescription = ""
                    , ideaPrice = "", longDescription = "", pictureUris = "", videoUri = ""
                    , error = "", token = "", innovator_id = 0, videoName = "", pictureNames = ""
                    , hasNda = False, isDefaultNda = True, customNda = "" }
                  else
                    { initialData | error = res.error }

                nextPage =
                  if (String.isEmpty res.error) then
                    ProfilePage
                  else
                    NewIdeaPage

                updatedMobilePage =
                  if (String.isEmpty res.error) then
                    MobileProfilePage
                  else
                    MobilePostAnIdeaPage

                mobilePageStr = TTSUtils.mobilePageToString updatedMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr updatedInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString nextPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  if (String.isEmpty res.error) then
                    Cmd.batch
                      [ Navigation.newUrl "#profile"
                      , cacheAllData cachedData
                      ]
                  else
                    Cmd.none

              in
                ( { model | newIdeaData = updatedData
                  , desktopPage = nextPage
                  , dashboardMobilePage = updatedMobilePage
                  , currentInnovatorExtended = updatedInnovatorExtended
                  }, cmd )
            Err error ->
              let
                initialData = model.newIdeaData
                updatedData = { initialData | error = (toString error) }
              in
                ( { model | newIdeaData = updatedData }, Cmd.none )
        OnNewIdeaSubmit ->
          let
            initialData = model.newIdeaData
            round1 = { initialData | error = "" }

            round2 =
              if ((String.isEmpty round1.error) && (String.isEmpty round1.ideaName)) then
                { round1 | error = "Idea/Project name required" }
              else
                round1

            round3 =
              if ((String.isEmpty round2.error) && (String.isEmpty round2.industry)) then
                { round2 | error = "Industry required" }
              else
                round2

            round4 =
              if ((String.isEmpty round3.error) && (String.isEmpty round3.shortDescription)) then
                { round3 | error = "Short description required" }
              else
                round3

            round5 =
              if ((String.isEmpty round4.error) && (String.isEmpty round4.longDescription)) then
                { round4 | error = "Long description required" }
              else
                round4

            round6 =
              if ((String.isEmpty round5.error) && round5.hasNda && (not round5.isDefaultNda) && (String.isEmpty round5.customNda)) then
                { round5 | error = "Custom NDA required!" }
              else
                round5

            loggedInMember = model.loggedInMember
            loggedInInno = model.currentInnovatorExtended
            round7 =
              if (String.isEmpty round6.error) then
                { round6 | token = loggedInMember.token, innovator_id = loggedInInno.id }
              else
                round6

            cmd =
              if ((String.isEmpty round7.error) && (not (String.isEmpty round7.pictureNames))) then
                submitPicturesToFirebase round7.pictureNames
              else if ((String.isEmpty round7.error) && (not (String.isEmpty round7.videoName))) then
                -- no errors, outgoing calls can be executed
                submitVideoFileToFirebase round7.videoName
              else if (String.isEmpty round7.error) then
                submitNewIdeaCmd round7
              else
                Cmd.none

          in
            ( { model | newIdeaData = round7 }, cmd )
        OnNewIdeaLongDescriptionInput newLongDesc ->
          let
            oldData = model.newIdeaData
            newData = { oldData | longDescription = newLongDesc }
          in
            ( { model | newIdeaData = newData }, Cmd.none )
        OnNewIdeaPriceInput newPrice ->
          let
            oldData = model.newIdeaData
            newData = { oldData | ideaPrice = newPrice }
          in
            ( { model | newIdeaData = newData }, Cmd.none )
        OnNewIdeaShortDescriptionInput newShortDesc ->
          let
            oldData = model.newIdeaData
            newData = { oldData | shortDescription = newShortDesc }
          in
            ( { model | newIdeaData = newData }, Cmd.none )
        OnNewIdeaTagsInput newTags ->
          let
            oldData = model.newIdeaData
            newData = { oldData | tags = newTags }
          in
            ( { model | newIdeaData = newData }, Cmd.none )
        OnNewIdeaIndustryInput newIndustry ->
          let
            oldData = model.newIdeaData
            newData = { oldData | industry = newIndustry }
          in
            ( { model | newIdeaData = newData }, Cmd.none )
        OnNewIdeaNameInput newName ->
          let
            oldData = model.newIdeaData
            newData = { oldData | ideaName = newName }
          in
            ( { model | newIdeaData = newData }, Cmd.none )


        OnGetFakeInterOpResponse data ->
          ( model, initIdeaMediaBtns "" )



        OnMobileDashboardNewIdeaPageVisible ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobilePostAnIdeaPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobilePostAnIdeaPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              Cmd.batch
                [ initFakeInterOp ""
                , cacheAllData cachedData
                ]
          in
            ( { model | dashboardMobilePage = MobilePostAnIdeaPage
              , mobilePageHistory = MobilePostAnIdeaPage :: model.mobilePageHistory
              }
              , cmd )
        OnDashboardNewIdeaPageVisible ->
          let
            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (NewIdeaPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString NewIdeaPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)
          in
            ( { model | desktopPage = NewIdeaPage
              , pageHistory = NewIdeaPage :: model.pageHistory
              }
              , Cmd.batch
                  [ initFakeInterOp ""
                  , cacheAllData cachedData
                  ] )



        OnFetchExtendedPostsCompleted res ->
          case res of
            Ok res ->
              let
                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended res model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                cmd =
                  cacheAllData cachedData
              in
                ( { model | postList = res }, cmd )
            Err error ->
              ( model, Cmd.none )
        OnSubmitPostCompleted res ->
          case res of
            Ok res ->
              let
                initialData = model.postData

                updatedData =
                  if (String.isEmpty res.error) then
                    { initialData | innovator_id = 0, organization_id = 0, message = ""
                    , mediaFileName = "", mediaFileUri = "", error = "", token = "" }
                  else
                    { initialData | error = res.error }

                loggedInUser = model.loggedInMember

                cmd =
                  if (String.isEmpty res.error) then
                    fetchExtendedPostsCmd loggedInUser.token
                  else
                    Cmd.none
              in
                ( { model | postData = updatedData }, cmd )
            Err error ->
              let
                initialData = model.postData
                updatedData = { initialData | error = (toString error) }
              in
                ( { model | postData = updatedData }, Cmd.none )
        OnGetUploadedMediaFileUri data ->
          let
            initialData = model.postData
            firstRound = { initialData | error = "" }

            secondRound =
              if (String.isEmpty data.error) then
                { firstRound | mediaFileUri = data.uri }
              else
                { firstRound | error = data.error }

            loggedInMember = model.loggedInMember
            loggedInOrg = model.currentOrganizationExtended
            loggedInInno = model.currentInnovatorExtended

            thirdRound =
              if (loggedInMember.isOrganization) then
                { secondRound | organization_id = loggedInOrg.id, token = loggedInMember.token }
              else
                { secondRound | innovator_id = loggedInInno.id, token = loggedInMember.token }


            cmd =
              if (String.isEmpty thirdRound.error) then
                submitNewPostCmd thirdRound
              else
                Cmd.none
          in
            ( { model | postData = thirdRound }, cmd )
        OnSubmitPost ->
          let
            initialData = model.postData
            firstRound = { initialData | error = "" }

            secondRound =
              if ((String.isEmpty firstRound.message) && (String.isEmpty firstRound.mediaFileName)) then
                { firstRound | error = "Some message or media file required!" }
              else
                firstRound

            loggedInMember = model.loggedInMember
            loggedInOrg = model.currentOrganizationExtended
            loggedInInno = model.currentInnovatorExtended

            thirdRound =
              if (loggedInMember.isOrganization) then
                { secondRound | organization_id = loggedInOrg.id, token = loggedInMember.token }
              else
                { secondRound | innovator_id = loggedInInno.id, token = loggedInMember.token }

            cmd =
              if ((String.isEmpty thirdRound.error) && (not (String.isEmpty thirdRound.mediaFileName))) then
                submitMediaFileToFirebase thirdRound.mediaFileName
              else if (String.isEmpty thirdRound.error) then
                -- network call to submit post with message
                submitNewPostCmd thirdRound
              else
                Cmd.none
          in
            ( { model | postData = thirdRound }, cmd)
        OnPostMessageInput newMessage ->
          let
            oldPostData = model.postData
            updatedPostData = { oldPostData | message = newMessage }
          in
            ( { model | postData = updatedPostData }, Cmd.none )
        OnPostImageNameChoosen data ->
          let
            fileName =
              if (String.isEmpty data.error) then
                data.fileName
              else
                ""

            oldPostData = model.postData
            updatedPostData = { oldPostData | mediaFileName = fileName, error = data.error }
          in
            ( { model | postData = updatedPostData }, Cmd.none )
        OnContactUsFormSubmitCompleted res ->
          case res of
            Ok res ->
              let
                output =
                  if (String.isEmpty res.error) then
                    "Your message has been submitted. Thank you!"
                  else
                    res.error

                oldData = model.contactUsData
                newData =
                  if (String.contains "message has been submitted" output) then
                    { oldData | error = output, name = "", email = "", message = "" }
                  else
                    { oldData | error = output }
              in
                ( { model | contactUsData = newData }, Cmd.none )
            Err error ->
              let
                oldData = model.contactUsData
                newData = { oldData | error = "Something weird happened. Try later, please!" }
              in
                ( { model | contactUsData = newData }, Cmd.none )
        OnContactUsFormSubmit ->
          let
            initialData = model.contactUsData
            i1 = { initialData | error = "" }

            i2 =
              if (String.isEmpty i1.name) then
                { i1 | error = "Name required!" }
              else
                i1

            i3 =
              if ((String.isEmpty i2.error) && ((not (String.contains "@" i2.email)) || (not (String.contains "." i2.email)))) then
                { i2 | error = "Wrong email format!" }
              else
                i2

            i4 =
              if ((String.isEmpty i3.error) && (String.isEmpty i3.message)) then
                { i3 | error = "Message required!" }
              else
                i3

            cmd =
              if (String.isEmpty i4.error) then
                submitContactUsFormCmd i4
              else
                Cmd.none

          in
            ( { model | contactUsData = i4 }, cmd )
        OnContactUsMessageInput newMessage ->
          let
            oldData = model.contactUsData
            newData = { oldData | message = newMessage }
          in
            ( { model | contactUsData = newData }, Cmd.none )
        OnContactUsEmailInput newEmail ->
          let
            oldData = model.contactUsData
            newData = { oldData | email = newEmail }
          in
            ( { model | contactUsData = newData }, Cmd.none )
        OnContactUsNameInput newName ->
          let
            oldData = model.contactUsData
            newData = { oldData | name = newName }
          in
            ( { model | contactUsData = newData }, Cmd.none )

        OnSubscribeMaxOrganization ->
          ( { model | selectedOrganizationsPlan = MaxOrganization }, Cmd.none )
        OnSubscribePremiumOrganization ->
          ( { model | selectedOrganizationsPlan = PremiumOrganization }, Cmd.none )
        OnSubscribePlusOrganization ->
          ( { model | selectedOrganizationsPlan = PlusOrganization }, Cmd.none )
        OnSubscribeBasicOrganization ->
          ( { model | selectedOrganizationsPlan = BasicOrganization }, Cmd.none )
        OnSubscribeMaxOrganizationMobile ->
          ( { model | selectedOrganizationsPlan = MaxOrganization
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = False, mobileRegisterCompanyOpened = True }, Cmd.none )
        OnSubscribePremiumOrganizationMobile ->
          ( { model | selectedOrganizationsPlan = PremiumOrganization
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = False, mobileRegisterCompanyOpened = True}, Cmd.none )
        OnSubscribePlusOrganizationMobile ->
          ( { model | selectedOrganizationsPlan = PlusOrganization
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = False, mobileRegisterCompanyOpened = True }, Cmd.none )
        OnSubscribeBasicOrganizationMobile ->
          ( { model | selectedOrganizationsPlan = BasicOrganization
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = False, mobileRegisterCompanyOpened = True }, Cmd.none )
        OnSubscribePremiumInnovatorsMobile ->
          ( { model | selectedInnovatorsPlan = PremiumInnovator
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = True, mobileRegisterCompanyOpened = False }, Cmd.none )
        OnSubscribePlusInnovatorsMobile ->
          ( { model | selectedInnovatorsPlan = PlusInnovator
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = True, mobileRegisterCompanyOpened = False }, Cmd.none )
        OnSubscribeBasicInnovatorsMobile ->
          ( { model | selectedInnovatorsPlan = BasicInnovator
          , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
          , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
          , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
          , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
          , mobileRegisterIdeaGeneratorOpened = True, mobileRegisterCompanyOpened = False }, Cmd.none )
        OnSubscribeFreeInnovatorsMobile ->
          ( { model | selectedInnovatorsPlan = FreeInnovator
            , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
            , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
            , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
            , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
            , mobileRegisterIdeaGeneratorOpened = True, mobileRegisterCompanyOpened = False }, Cmd.none )
        OnSubscribeFreeInnovators ->
          ( { model | selectedInnovatorsPlan = FreeInnovator }, Cmd.none )

        OnSubscribeBasicInnovators ->
          ( { model | selectedInnovatorsPlan = BasicInnovator }, Cmd.none )
        OnSubscribePlusInnovators ->
          ( { model | selectedInnovatorsPlan = PlusInnovator }, Cmd.none )
        OnSubscribePremiumInnovators ->
          ( { model | selectedInnovatorsPlan = PremiumInnovator }, Cmd.none )

        OnGetOrganizationDataCompleted res ->
          case res of
            Ok res ->
              let
                data = res.organization_data

                orgExtended =
                  if (data.id == 0) then
                    (OrganizationExtended 0 "" "" "" "" 0 0 "" "" "" "" "" "" "" 0 0)
                  else
                    data

                cmd =
                  if (data.id == 0) then
                    Cmd.none
                  else
                    initPostMediaBtn ""

                orgSettingsFields =
                  if (data.id == 0) then
                    (OrganizationSettingsFields 0 "" "" "" "" 0 0 "" "" "" "" "" "" "" "" "" "" "")
                  else
                    (OrganizationSettingsFields data.id data.name data.pic_uri data.country data.email
                      data.complete_ideas_count data.organizations_plan_id data.description data.webpage data.about_us
                      data.industry data.interested_industries data.username data.phone "" "" "" "")
              in
                ( { model | currentOrganizationExtended = orgExtended
                , organizationSettingsFields = orgSettingsFields
                }, cmd )
            Err error ->
              ( model, Cmd.none )
        OnGetInnovatorDataCompleted res ->
          case res of
            Ok res ->
              let
                data = res.innovator_data

                cmd =
                  if (data.id == 0) then
                    Cmd.none
                  else
                    initPostMediaBtn ""

                innData =
                  if (data.id == 0) then
                    (InnovatorExtended 0 "" "" 0 "" "" 0 0 "" "" "" "" "" "" 0)
                  else
                    data

                nameList = (String.split " " data.name)
                name =
                  case (List.head nameList) of
                    Just n -> n
                    Nothing -> ""
                surnameList = (List.drop 1 nameList)
                surname =
                  case (List.head surnameList) of
                    Just s -> s
                    Nothing -> ""

                innSettingsFields =
                  if (data.id == 0) then
                    (InnovatorSettingsFields 0 "" "" "" 0 "" "" 0 0 "" "" "" "" "" "" "" "" "" "")
                  else
                    (InnovatorSettingsFields data.id name surname data.pic_uri data.rating data.country
                      data.email data.ideas_count data.innovators_plan_id data.description data.about_me data.education
                      data.experience data.username data.phone "" "" "" "")
              in
                ( { model | currentInnovatorExtended = innData
                  , innovatorSettingsFields = innSettingsFields }
                  , cmd )
            Err error ->
              ( model, Cmd.none )
        OnSignOutInitiated ->
          let
            data = model.loggedInMember
          in
            ( model, signOutCmd data.token )
        OnSignOutCompleted res ->
          case res of
            Ok res ->
              let
                cmd =
                  if res.response == "Sucess!" then
                    Cmd.batch
                      [ Navigation.newUrl "#"
                      , reverseBackgroundImage ""
                      , turnOffNewNotifsFetch ""
                      , clearCachedData ""
                      ]
                  else
                    Cmd.none

                editables =
                  (InnovatorSettingsFieldsEditable False False False False False False False False False False)
                orgEditables =
                  (OrganizationSettingsFieldsEditable False False False False False False False False False False False)

              in
                ( { model | loggingInMember = (LoggingInMember "" "" "")
                  , loggedInMember = (LoggedInMember 0 "" "" True "")
                  , dashboardOptionsVisible = False
                  , newMessagesNotifsVisible = False
                  , desktopPage = HomePage
                  , dashboardMobilePage = MobileHomePage
                  , getStartedOpened = False
                  , loginOpened = False
                  , innovatorSettingsFieldsEditable = editables
                  , organizationSettingsFieldsEditable = orgEditables
                  , chatWindowOpened = False
                  , connections = []
                  , mobilePageHistory = []
                  , pageHistory = []
                  , signedNDAs = []
                  , mobileMenuView = False
                  , mobileDefaultView = True
                  , mobileIdeaGeneratorsView = False
                  , mobileOrganizationsView = False
                  , mobilePricingToggleOpen = False
                  , mobilePricingIdeaGeneratorsView = False
                  , mobilePricingOrganizationsView = False
                  , mobileAboutUsView = False
                  , mobileContactView = False
                  , mobileFaqView = False
                  , mobileTarrifPlansView = False
                  , mobileGetStartedOpened = False
                  , mobileRegisterIdeaGeneratorOpened = False
                  , mobileRegisterCompanyOpened = False
                  , registerIdeaGeneratorOpened = False
                  , registerCompanyOpened = False }, cmd )
            Err error ->
              ( model, Cmd.none )
        OnDashboardMobileSettingsPageOpen ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileSettingsPage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileSettingsPage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (SettingsPage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString SettingsPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | dashboardMobilePage = MobileSettingsPage
              , desktopPage = SettingsPage
              , mobilePageHistory = MobileSettingsPage :: model.mobilePageHistory
              , pageHistory = SettingsPage :: model.pageHistory
              }, cmd )
        OnDashboardMobileProfilePageOpen ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileProfilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileProfilePage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | dashboardMobilePage = MobileProfilePage
              , mobilePageHistory = MobileProfilePage :: model.mobilePageHistory
              }, cmd )
        OnDashboardMobileHomePageOpen ->
          let
            mobilePageStr = TTSUtils.mobilePageToString MobileHomePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) (MobileHomePage :: model.mobilePageHistory)
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | dashboardMobilePage = MobileHomePage
              , mobilePageHistory = MobileHomePage :: model.mobilePageHistory
              }, cmd )
        OnLocationChangeProfilePage ->
          let
            mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
            mobilePageHistoryStr =
              List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
            pageHistoryString =
              List.map (\ p -> TTSUtils.desktopPageToString p) (ProfilePage :: model.pageHistory)

            cachedData = (CacheDataWrapper model.loggedInMember mobilePageStr model.currentInnovatorExtended
              model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
              model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
              (TTSUtils.desktopPageToString ProfilePage) model.seeOtherInnovator model.seeOtherOrganization
              model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
              model.signedNDAs)

            cmd =
              cacheAllData cachedData
          in
            ( { model | desktopPage = ProfilePage
              , pageHistory = ProfilePage :: model.pageHistory
              }, cmd )
        OnSwitchDashboardOptionsVisible ->
          ( { model | dashboardOptionsVisible = not model.dashboardOptionsVisible }, Cmd.none )

        --*************************************
        --*****************************
        --************************
        OnLoggingInMemberCompleted data ->
          case data of
            Ok data ->
              let
                loggingInData = model.loggingInMember
                newLoggingInData = { loggingInData | loginError = data.error }

                loginData = data.login_data
                getExtendedDataCmd =
                  if loginData.isOrganization then
                    getOrganizationDataCmd (GetDataRequestStruct loginData.id loginData.token)
                  else
                    getInnovatorDataCmd (GetDataRequestStruct loginData.id loginData.token)

                unredMessagesRequestWrapper =
                  (UnredChatMessagesRequestWrapper loginData.id loginData.isOrganization loginData.token)

                getSuggestions =
                  if loginData.isOrganization then
                    fetchSuggestionsCmd (GetDataRequestStruct loginData.id loginData.token) fetchSuggestedInnovatorsUri
                  else
                    fetchSuggestionsCmd (GetDataRequestStruct loginData.id loginData.token) fetchSuggestedOrganizationsUri

                mobilePageStr = TTSUtils.mobilePageToString model.dashboardMobilePage
                mobilePageHistoryStr =
                  List.map (\ p -> TTSUtils.mobilePageToString p) model.mobilePageHistory
                pageHistoryString =
                  List.map (\ p -> TTSUtils.desktopPageToString p) model.pageHistory

                cachedData = (CacheDataWrapper loginData mobilePageStr model.currentInnovatorExtended
                  model.currentOrganizationExtended model.postList model.currentChatHistory model.pendingUnredMessages
                  model.suggestedUsers model.notifications (TTSUtils.langToString model.language)
                  (TTSUtils.desktopPageToString model.desktopPage) model.seeOtherInnovator model.seeOtherOrganization
                  model.viewingCurrentIdea model.viewingCurrentFullIdea mobilePageHistoryStr pageHistoryString
                  model.signedNDAs)

                oldPageHistory = model.pageHistory
                newPageHistory = NewsfeedPage :: oldPageHistory
                oldPageHistoryMobile = model.mobilePageHistory
                newPageHistoryMobile = MobileNewsfeedPage :: oldPageHistoryMobile

              in
                if (String.isEmpty data.error) then
                  ( { model | loggedInMember = loginData
                    , pageHistory = newPageHistory
                    , mobilePageHistory = newPageHistoryMobile }
                    , Cmd.batch [ Navigation.newUrl "#dashboard", setWhiteBackground ""
                    , getExtendedDataCmd, fetchExtendedPostsCmd loginData.token
                    , fetchUnredMessagesCmd unredMessagesRequestWrapper, getSuggestions
                    , fetchNewNotificationsCmd unredMessagesRequestWrapper
                    , turnOnNewNotifsFetch ""
                    , cacheAllData cachedData
                    ] )
                else
                  ( { model | loggingInMember = newLoggingInData }, Cmd.none )
            Err error ->
              let
                loggingInData = model.loggingInMember
                newLoggingInData = { loggingInData | loginError = (toString error) }
              in
                ( { model | loggingInMember = newLoggingInData }, Cmd.none )
        OnLoggingInMemberLogin ->
          let
            initialData = model.loggingInMember
            memberData = { initialData | loginError = "" }
            email = memberData.email
            password = memberData.password

            emailError =
              if ( ( not (String.contains "@" email)) || ( not (String.contains "." email)) ) then
                "Invalid email format"
              else
                ""

            passwordError =
              if (String.length password) < 8 then
                "Password at least 8 chars long"
              else
                ""

            errorOutput =
              if (not (String.isEmpty emailError)) then
                emailError
              else if (not (String.isEmpty passwordError)) then
                passwordError
              else
                ""

            newMember = { memberData | loginError = errorOutput }

            cmd =
              if ((String.isEmpty emailError) && (String.isEmpty passwordError)) then
                memberLoginCmd memberData
              else
                Cmd.none
          in
            ( { model | loggingInMember = newMember }, cmd )
        OnLoggingInMemberUsernameInput newEmail ->
          let
            oldMember = model.loggingInMember
            newMember = { oldMember | email = newEmail }
          in
            ( { model | loggingInMember = newMember }, Cmd.none )
        OnLoggingInMemberPasswordInput newPassword ->
          let
            oldMember = model.loggingInMember
            newMember = { oldMember | password = newPassword }
          in
            ( { model | loggingInMember = newMember }, Cmd.none )
        TopMembersFetchCompleted topMembers ->
          case topMembers of
            Ok topMembers ->
              ( { model | topInnovators = topMembers.innovators
                , topOrganizations = topMembers.organizations }, Cmd.none )
            Err error ->
              ( model, Cmd.none )
        OnInnovatorRegistrationSubmit ->
          let
            initialData = model.innovatorUnderRegistration
            tarrifPlan = model.selectedInnovatorsPlan

            oldInnovatorData = { initialData | registrationError = "" }
            name = oldInnovatorData.full_name
            email = oldInnovatorData.email
            password = oldInnovatorData.password
            country = oldInnovatorData.country
            agreedWithTS = oldInnovatorData.termsOfServiceAgreemant

            newInnovatorData =
              if (String.isEmpty name) then
                { oldInnovatorData | registrationError = "Name required" }
              else
                oldInnovatorData

            newInnovatorData1 =
              if ((String.isEmpty newInnovatorData.registrationError) && ((not (String.contains "@" email))
                || (not (String.contains "." email)))) then
                { newInnovatorData | registrationError = "Email is invalid" }
              else
                newInnovatorData

            newInnovatorData2 =
              if ((String.isEmpty newInnovatorData1.registrationError) && (String.length password < 8)) then
                { newInnovatorData1 | registrationError = "Password at least 8 characters long" }
              else
                newInnovatorData1

            newInnovatorData3 =
              if ((String.isEmpty newInnovatorData2.registrationError) && (String.isEmpty country)) then
                { newInnovatorData2 | registrationError = "Country required" }
              else
                newInnovatorData2

            newInnovatorData4 =
              if ((String.isEmpty newInnovatorData3.registrationError) && (not agreedWithTS)) then
                { newInnovatorData3 | registrationError = "Should be agreed with our TS" }
              else
                newInnovatorData3

            newInnovatorData5 =
              if ((String.isEmpty newInnovatorData4.registrationError) && (tarrifPlan == NotSelectedForInnovators)) then
                { newInnovatorData4 | registrationError = "Select tariff plan, please" }
              else
                newInnovatorData4

            tp =
              case tarrifPlan of
                NotSelectedForInnovators ->
                  "Weird Error"
                FreeInnovator ->
                  "Free"
                BasicInnovator ->
                  "Basic"
                PlusInnovator ->
                  "Plus"
                PremiumInnovator ->
                  "Premium"

            cmd =
              if ((String.isEmpty newInnovatorData5.registrationError) && (tarrifPlan /= NotSelectedForInnovators)) then
                innovatorRegisterCmd newInnovatorData5 tp
              else
                Cmd.none
          in
            ( { model | innovatorUnderRegistration = newInnovatorData5 }, cmd )
        OnInnovatorRegistrationSubmitMobile ->
          let
            initialData = model.innovatorUnderRegistration
            tarrifPlan = model.selectedInnovatorsPlan

            oldInnovatorData = { initialData | registrationError = "" }
            name = oldInnovatorData.full_name
            email = oldInnovatorData.email
            password = oldInnovatorData.password
            country = oldInnovatorData.country
            agreedWithTS = oldInnovatorData.termsOfServiceAgreemant

            newInnovatorData =
              if (String.isEmpty name) then
                { oldInnovatorData | registrationError = "Name required" }
              else
                oldInnovatorData

            newInnovatorData1 =
              if ((String.isEmpty newInnovatorData.registrationError) && ((not (String.contains "@" email))
                || (not (String.contains "." email)))) then
                { newInnovatorData | registrationError = "Email is invalid" }
              else
                newInnovatorData

            newInnovatorData2 =
              if ((String.isEmpty newInnovatorData1.registrationError) && (String.length password < 8)) then
                { newInnovatorData1 | registrationError = "Password at least 8 characters long" }
              else
                newInnovatorData1

            newInnovatorData3 =
              if ((String.isEmpty newInnovatorData2.registrationError) && (String.isEmpty country)) then
                { newInnovatorData2 | registrationError = "Country required" }
              else
                newInnovatorData2

            newInnovatorData4 =
              if ((String.isEmpty newInnovatorData3.registrationError) && (not agreedWithTS)) then
                { newInnovatorData3 | registrationError = "Should be agreed with our TS" }
              else
                newInnovatorData3

            newModel =
              if ((String.isEmpty newInnovatorData4.registrationError) && (tarrifPlan /= NotSelectedForInnovators)) then
                { model | innovatorUnderRegistration = newInnovatorData4 }
              else if (not (String.isEmpty newInnovatorData4.registrationError)) then
                { model | innovatorUnderRegistration = newInnovatorData4 }
              else if (tarrifPlan == NotSelectedForInnovators) then
                { model | innovatorUnderRegistration = newInnovatorData4
                , mobileMenuView = False, mobileDefaultView = True, mobileIdeaGeneratorsView = False
                , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
                , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
                , mobileFaqView = False, mobileTarrifPlansView = False, mobileGetStartedOpened = True
                , mobileRegisterIdeaGeneratorOpened = True, mobileRegisterCompanyOpened = False }
              else
                { model | innovatorUnderRegistration = newInnovatorData4 }

            tp =
              case tarrifPlan of
                NotSelectedForInnovators ->
                  "Weird Error"
                FreeInnovator ->
                  "Free"
                BasicInnovator ->
                  "Basic"
                PlusInnovator ->
                  "Plus"
                PremiumInnovator ->
                  "Premium"

            cmd =
              if ((String.isEmpty newInnovatorData4.registrationError) && (tarrifPlan /= NotSelectedForInnovators)) then
                innovatorRegisterCmd newInnovatorData4 tp
              else
                Cmd.none
          in
            ( newModel, cmd )
        InnovatorRegisterCompleted regData ->
          case regData of
            Ok regData ->
              if (not (String.isEmpty regData.error)) then
                let
                  oldData = model.innovatorUnderRegistration
                  newData = { oldData | registrationError = regData.error }
                in
                  ( { model | innovatorUnderRegistration = newData }, Cmd.none )
              else
                let
                  regDataNew = regData.reg_data
                  loggedInMem = (LoggedInMember regDataNew.id regDataNew.name regDataNew.email False regDataNew.token)
                in
                  ( { model | loggedInData = regData.reg_data, loggedInMember = loggedInMem }, Cmd.batch [ Navigation.newUrl "#dashboard", setWhiteBackground "", getInnovatorDataCmd (GetDataRequestStruct regDataNew.id regDataNew.token) ] )
            Err error ->
              let
                oldData = model.innovatorUnderRegistration
                newData = { oldData | registrationError = "Some weird stuff. Try again and contact us, please!" }
              in
                ( { model | innovatorUnderRegistration = newData }, Cmd.none )
        OnInnovatorRegistrationReceiveNewletterCheck ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | receiveNewsletterAgreement = not oldInnovator.receiveNewsletterAgreement }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnInnovatorRegistrationTSAgreementCheck ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | termsOfServiceAgreemant = not oldInnovator.termsOfServiceAgreemant }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnInnovatorRegistrationCountryInput newCountry ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | country = newCountry }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnInnovatorRegistrationPasswordInput newPassword ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | password = newPassword }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnInnovatorRegistrationEmailInput newEmail ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | email = newEmail }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnInnovatorRegistrationNameInput newName ->
          let
            oldInnovator = model.innovatorUnderRegistration
            newInnovator = { oldInnovator | full_name = newName }
          in
            ( { model | innovatorUnderRegistration = newInnovator }, Cmd.none )
        OnCompanyRegistrationSubmit ->
          let
            initialData = model.companyUnderRegistration
            tarrifPlan = model.selectedOrganizationsPlan

            oldCompanyData = { initialData | registrationError = "" }
            name = oldCompanyData.name
            email = oldCompanyData.email
            password = oldCompanyData.password
            country = oldCompanyData.country
            agreedWithTS = oldCompanyData.termsOfServiceAgreemant

            newCompanyData =
              if (String.isEmpty name) then
                { oldCompanyData | registrationError = "Name required" }
              else
                oldCompanyData

            newCompanyData1 =
              if ((String.isEmpty newCompanyData.registrationError) && ((not (String.contains "@" email))
                || (not (String.contains "." email)))) then
                { newCompanyData | registrationError = "Email is invalid" }
              else
                newCompanyData

            newCompanyData2 =
              if ((String.isEmpty newCompanyData1.registrationError) && (String.length password < 8)) then
                { newCompanyData1 | registrationError = "Password at least 8 characters long" }
              else
                newCompanyData1

            newCompanyData3 =
              if ((String.isEmpty newCompanyData2.registrationError) && (String.isEmpty country)) then
                { newCompanyData2 | registrationError = "Country required" }
              else
                newCompanyData2

            newCompanyData4 =
              if ((String.isEmpty newCompanyData3.registrationError) && (not agreedWithTS)) then
                { newCompanyData3 | registrationError = "Should be agreed with our TS" }
              else
                newCompanyData3

            newCompanyData5 =
              if ((String.isEmpty newCompanyData4.registrationError) && (tarrifPlan == NotSelectedForOrganizations)) then
                { newCompanyData4 | registrationError = "Select tariff plan, please" }
              else
                newCompanyData4

            tp =
              case tarrifPlan of
                NotSelectedForOrganizations ->
                  "Weird Error"
                BasicOrganization ->
                  "Basic"
                PlusOrganization ->
                  "Plus"
                PremiumOrganization ->
                  "Premium"
                MaxOrganization ->
                  "Max"

            cmd =
              if ((String.isEmpty newCompanyData5.registrationError) && (tarrifPlan /= NotSelectedForOrganizations)) then
                organizationRegisterCmd newCompanyData5 tp
              else
                Cmd.none

          in
            ( { model | companyUnderRegistration = newCompanyData5 }, cmd )
        OnCompanyRegistrationSubmitMobile ->
          let
            initialData = model.companyUnderRegistration
            tarrifPlan = model.selectedOrganizationsPlan

            oldCompanyData = { initialData | registrationError = "" }
            name = oldCompanyData.name
            email = oldCompanyData.email
            password = oldCompanyData.password
            country = oldCompanyData.country
            agreedWithTS = oldCompanyData.termsOfServiceAgreemant

            newCompanyData =
              if (String.isEmpty name) then
                { oldCompanyData | registrationError = "Name required" }
              else
                oldCompanyData

            newCompanyData1 =
              if ((String.isEmpty newCompanyData.registrationError) && ((not (String.contains "@" email))
                || (not (String.contains "." email)))) then
                { newCompanyData | registrationError = "Email is invalid" }
              else
                newCompanyData

            newCompanyData2 =
              if ((String.isEmpty newCompanyData1.registrationError) && (String.length password < 8)) then
                { newCompanyData1 | registrationError = "Password at least 8 characters long" }
              else
                newCompanyData1

            newCompanyData3 =
              if ((String.isEmpty newCompanyData2.registrationError) && (String.isEmpty country)) then
                { newCompanyData2 | registrationError = "Country required" }
              else
                newCompanyData2

            newCompanyData4 =
              if ((String.isEmpty newCompanyData3.registrationError) && (not agreedWithTS)) then
                { newCompanyData3 | registrationError = "Should be agreed with our TS" }
              else
                newCompanyData3

            newModel =
              if ((String.isEmpty newCompanyData4.registrationError) && (tarrifPlan /= NotSelectedForOrganizations)) then
                { model | companyUnderRegistration = newCompanyData4 }
              else if (not (String.isEmpty newCompanyData4.registrationError)) then
                { model | companyUnderRegistration = newCompanyData4 }
              else if (tarrifPlan == NotSelectedForOrganizations) then
                { model | companyUnderRegistration = newCompanyData4
                , mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False
                , mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False
                , mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False
                , mobileFaqView = False, mobileTarrifPlansView = True, mobileGetStartedOpened = False
                , mobileRegisterIdeaGeneratorOpened = False, mobileRegisterCompanyOpened = False }
              else
                { model | companyUnderRegistration = newCompanyData4 }

            tp =
              case tarrifPlan of
                NotSelectedForOrganizations ->
                  "Weird Error"
                BasicOrganization ->
                  "Basic"
                PlusOrganization ->
                  "Plus"
                PremiumOrganization ->
                  "Premium"
                MaxOrganization ->
                  "Max"

            cmd =
              if ((String.isEmpty newCompanyData4.registrationError) && (tarrifPlan /= NotSelectedForOrganizations)) then
                organizationRegisterCmd newCompanyData4 tp
              else
                Cmd.none

          in
            ( newModel, cmd )
        CompanyRegisterCompleted regData ->
          case regData of
            Ok regData ->
              if (not (String.isEmpty regData.error)) then
                let
                  oldData = model.companyUnderRegistration
                  newData = { oldData | registrationError = regData.error }
                in
                  ( { model | companyUnderRegistration = newData }, Cmd.none )
              else
                let
                  regDataNew = regData.reg_data
                  loggedInMem = (LoggedInMember regDataNew.id regDataNew.name regDataNew.email True regDataNew.token)
                in
                  ( { model | loggedInData = regData.reg_data, loggedInMember = loggedInMem }, Cmd.batch [ Navigation.newUrl "#dashboard", setWhiteBackground "", getOrganizationDataCmd (GetDataRequestStruct regDataNew.id regDataNew.token) ] )
            Err error ->
              let
                oldData = model.companyUnderRegistration
                newData = { oldData | registrationError = "Some weird stuff. Try again and contact us, please!" }
              in
                ( { model | companyUnderRegistration = newData }, Cmd.none )
        OnCompanyRegistrationReceiveNewletterCheck ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | receiveNewsletterAgreement = not oldCompany.receiveNewsletterAgreement }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnCompanyRegistrationTSAgreementCheck ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | termsOfServiceAgreemant = not oldCompany.termsOfServiceAgreemant }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnCompanyRegistrationCountryInput newCountry ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | country = newCountry }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnCompanyRegistrationPasswordInput newPassword ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | password = newPassword }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnCompanyRegistrationEmailInput newEmail ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | email = newEmail }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnCompanyRegistrationNameInput newName ->
          let
            oldCompany = model.companyUnderRegistration
            newCompany = { oldCompany | name = newName }
          in
            ( { model | companyUnderRegistration = newCompany }, Cmd.none )
        OnMobileTarrifPlansViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = True }, Cmd.none )
        OnMobileFaqViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = True, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileContactUsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = True,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileAboutUsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = True, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobilePricingOrganizationsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = True, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobilePricingIdeaGeneratorsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = True,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobilePricingToggle ->
          let
            newToggleStatus = not model.mobilePricingToggleOpen
          in
            ( { model | mobileDefaultView = False, mobileIdeaGeneratorsView = False,
              mobileOrganizationsView = False, mobilePricingToggleOpen = newToggleStatus, mobilePricingIdeaGeneratorsView = False,
              mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
              mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileOrganizationsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = True, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileIdeaGeneratorsViewOpen ->
          ( { model | mobileMenuView = False, mobileDefaultView = False, mobileIdeaGeneratorsView = True,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileMenuOpen ->
          ( { model | mobileMenuView = True, mobileDefaultView = False, mobileIdeaGeneratorsView = False,
            mobileOrganizationsView = False, mobilePricingToggleOpen = False, mobilePricingIdeaGeneratorsView = False,
            mobilePricingOrganizationsView = False, mobileAboutUsView = False, mobileContactView = False,
            mobileFaqView = False, mobileTarrifPlansView = False }, Cmd.none )
        OnMobileRegisterIdeaGeneratorViewOpen ->
          ( { model | mobileRegisterIdeaGeneratorOpened = True }, Cmd.none )
        OnMobileRegisterCompanyViewOpen ->
          ( { model | mobileRegisterCompanyOpened = True }, Cmd.none )
        OnMobileGetStartedViewOpen ->
          ( { model | mobileGetStartedOpened = True }, Cmd.none )
        OnAdminPanelSignIn ->
          if ((String.length model.adminPanelFirstPassword == 0) || (String.length model.adminPanelSecondPassword == 0)) then
            ( { model | adminPanelSignInError = "Երկու դաշտերն էլ պարտադիր են լրացման համար" }, Cmd.none )
          else
            ( model, adminPanelSignInCmd (AdminPanelSignInData model.adminPanelFirstPassword model.adminPanelSecondPassword) )
        OnAdminPanelFirstPasswordInput newPassword ->
          ( { model | adminPanelFirstPassword = newPassword }, Cmd.none )
        OnAdminPanelSecondPasswordInput newPassword ->
          ( { model | adminPanelSecondPassword = newPassword }, Cmd.none )
        AdminPanelSignInCompleted adminPanelSignInData ->
          case adminPanelSignInData of
            Ok adminPanelSignInData ->
              if (String.length adminPanelSignInData.error == 0) then
                ( { model | adminPanelRegDataList = adminPanelSignInData.reg_data, adminPanelSignedIn = True }, Cmd.none )
              else
                ( { model | adminPanelSignInError = adminPanelSignInData.error }, Cmd.none )
            Err error ->
              ( { model | adminPanelSignInError = (toString error) }, Cmd.none )
        PromoRegistrationCallCompleted promoRegData ->
          case promoRegData of
            Ok promoRegData ->
              if (String.length promoRegData.error == 0) then
                ( { model | landingInputFieldsVisible = False }, showPromoRegistrationConfirmDialog "" )
              else
                ( { model | landingPromoRegisterError = promoRegData.error }, Cmd.none )
            Err error ->
              ( { model | landingPromoRegisterError = "Չսպասված սխալ գրանցման ժամանակ: Կապվեք մեզ հետ, խնդրեմ" }, Cmd.none )
        OnLandingSignUpMobileClick ->
          ( { model | landingSignUpMobileVisible = True }, Cmd.none )
        OnLandingSignUp ->
          let
            username = model.landingUsername
            email = model.landingEmail
            prefOrganization = model.landingCompany
            shortIdea = model.landingShortIdea


            usernameError =
              if (String.isEmpty username) then
                "Պարտադիր է լրացնել"
              else
                ""

            emailError =
              if (String.isEmpty email) then
                "Պարտադիր է լրացնել"
              else if (not ((String.contains "@" email) && (String.contains "." email))) then
                "Էլ. հասցեի ֆորմատը սխալ է"
              else
                ""

            cmd =
              if (String.isEmpty usernameError && String.isEmpty emailError && String.isEmpty model.landingCompanyError && String.isEmpty model.landingShortIdeaError) then
                promoRegisterCmd (PromoRegistration username email prefOrganization shortIdea "")
              else
                Cmd.none
          in
            ( { model | landingUsernameError = usernameError, landingEmailError = emailError }, cmd )
        OnLandingShortIdeaType shortIdea ->
          let
            ideaError =
              if (String.length shortIdea) > 200 then
                "Առավելագույնը 200 նիշ:"
              else
                ""
          in
            ( { model | landingShortIdea = shortIdea, landingShortIdeaError = ideaError }, Cmd.none )
        OnLandingCompanyType company ->
          let
            companyError =
              if (String.length company) > 30 then
                "Առավելագույնը 30 նիշ:"
              else
                ""
          in
            ( { model | landingCompany = company, landingCompanyError = companyError }, Cmd.none )
        OnLandingEmailType email ->
          ( { model | landingEmail = email }, Cmd.none )
        OnLandingUsernameType name ->
          ( { model | landingUsername = name }, Cmd.none )
        OnIdeaGeneratorRegistrationOpen ->
          ( { model | registerIdeaGeneratorOpened = True }, Cmd.none )
        OnCompanyRegistrationOpen ->
          ( { model | registerCompanyOpened = True }, Cmd.none )
        OnLoginButtonSwitch ->
          ( { model | loginOpened = not model.loginOpened }, Cmd.none )
        OnGetStartedButtonsSwitch ->
          ( { model | getStartedOpened = not model.getStartedOpened }, Cmd.none )
        OnPricingClose ->
          ( { model | pricingOpened = Closed }, Cmd.none )
        OnPricingOpen ->
          let
            reverted =
              case model.pricingOpened of
                Opened -> Closed
                Closed -> Opened
          in
            ( { model | pricingOpened = reverted }, Cmd.none )
        OnLocationChange location ->
          let
            newRoute =
              parseLocation location
          in
            ( { model | route = newRoute }, Cmd.none)
        OnTestMessage ->
          ( model, Cmd.none )
