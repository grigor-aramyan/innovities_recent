module Utils exposing (..)

import Models exposing (..)


makeRealOrganization : Maybe TopOrganization -> TopOrganization
makeRealOrganization topOrg =
  case topOrg of
    Just topOrg ->
      TopOrganization topOrg.id topOrg.name topOrg.pic_uri topOrg.country

    Nothing ->
      defaultOrganization


makeRealInnovator : Maybe TopInnovator -> TopInnovator
makeRealInnovator topInno =
  case topInno of
    Just topInno ->
      TopInnovator topInno.id topInno.name topInno.pic_uri topInno.rating topInno.country

    Nothing ->
      defaultInnovator


defaultOrganization : TopOrganization
defaultOrganization =
  TopOrganization 0 "Organization Name" "https://conferencesolutions.com/wp-content/uploads/2017/03/logo-1.png" "Address"


defaultInnovator : TopInnovator
defaultInnovator =
  TopInnovator 0 "Innovator Name" "https://www.bea-sensors.com/wp/wp-content/uploads/2016/10/user_profile_male.jpg" 3 "Address"


makeRealString : Maybe String -> String
makeRealString str =
  case str of
    Just str ->
      str

    Nothing ->
      ""
