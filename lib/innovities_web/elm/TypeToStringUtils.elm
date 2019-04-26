module TypeToStringUtils exposing (..)

import Models exposing (Language, DesktopPage, MobilePage)



stringToMobilePage : String -> MobilePage
stringToMobilePage pageStr =
  let
    page =
      case pageStr of
        "home" -> Models.MobileHomePage
        "mobileNewsfeed" -> Models.MobileNewsfeedPage
        "profile" -> Models.MobileProfilePage
        "settings" -> Models.MobileSettingsPage
        "newIdea" -> Models.MobilePostAnIdeaPage
        "search" -> Models.MobileSearchPage
        "seeOtherInnovator" -> Models.MobileSeeOtherInnovatorPage
        "seeOtherOrganization" -> Models.MobileSeeOtherOrganizationPage
        "viewIdea" -> Models.MobileViewIdeaPage
        "viewFullIdea" -> Models.MobileViewFullIdeaPage
        "mobileNDA" -> Models.MobileNDAsPage
        _ -> Models.MobileHomePage
  in
    page


mobilePageToString : MobilePage -> String
mobilePageToString page =
  let
    pageStr =
      case page of
        Models.MobileHomePage -> "home"
        Models.MobileNewsfeedPage -> "mobileNewsfeed"
        Models.MobileProfilePage -> "profile"
        Models.MobileSettingsPage -> "settings"
        Models.MobilePostAnIdeaPage -> "newIdea"
        Models.MobileSearchPage -> "search"
        Models.MobileSeeOtherInnovatorPage -> "seeOtherInnovator"
        Models.MobileSeeOtherOrganizationPage -> "seeOtherOrganization"
        Models.MobileViewIdeaPage -> "viewIdea"
        Models.MobileViewFullIdeaPage -> "viewFullIdea"
        Models.MobileNDAsPage -> "mobileNDA"
  in
    pageStr




desktopPageToString : DesktopPage -> String
desktopPageToString page =
  let
    pageStr =
      case page of
        Models.HomePage -> "home"
        Models.NewsfeedPage -> "newsfeed"
        Models.ProfilePage -> "profile"
        Models.NewIdeaPage -> "newIdea"
        Models.SettingsPage -> "settings"
        Models.TariffPlansPage -> "tariffPlans"
        Models.SearchPage -> "search"
        Models.SeeOtherInnovatorPage -> "seeOtherInnovator"
        Models.SeeOtherOrganizationPage -> "seeOtherOrganization"
        Models.ViewIdeaPage -> "viewIdea"
        Models.ViewFullIdeaPage -> "viewFullIdea"
        Models.NDAsPage -> "desktopNDA"
  in
    pageStr


stringToDesktopPage : String -> DesktopPage
stringToDesktopPage pageStr =
  let
    page =
      case pageStr of
        "home" -> Models.HomePage
        "newsfeed" -> Models.NewsfeedPage
        "profile" -> Models.ProfilePage
        "newIdea" -> Models.NewIdeaPage
        "settings" -> Models.SettingsPage
        "tariffPlans" -> Models.TariffPlansPage
        "search" -> Models.SearchPage
        "seeOtherInnovator" -> Models.SeeOtherInnovatorPage
        "seeOtherOrganization" -> Models.SeeOtherOrganizationPage
        "viewIdea" -> Models.ViewIdeaPage
        "viewFullIdea" -> Models.ViewFullIdeaPage
        "desktopNDA" -> Models.NDAsPage
        _ -> Models.HomePage
  in
    page



langToString : Language -> String
langToString lang =
  let
    langStr =
      case lang of
        Models.Arm -> "arm"
        Models.Eng -> "eng"
  in
    langStr



stringToLang : String -> Language
stringToLang langStr =
  let
    lang =
      case langStr of
        "arm" -> Models.Arm
        "eng" -> Models.Eng
        _ -> Models.Eng
  in
    lang
