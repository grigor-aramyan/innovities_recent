module LangLocals exposing (..)

import Models exposing (Model, MapItem, Language)

locals : List MapItem
locals =
  [ (MapItem "Idea generators" "Գաղափար գեներացնողներ"), (MapItem "Organizations" "Կազմակերպություններ")
  , (MapItem "Pricing " "Գնացուցակ "), (MapItem "About us" "Մեր մասին"), (MapItem "Contact" "Հետադարձ կապ")
  , (MapItem "GET STARTED!" "Գրանցվել"), (MapItem "LOG IN" "Մուտք գործել")
  , (MapItem "Innovities is a social platform where innovative ideas are found by those who need them." "Innovities հարթակը նախատեսված է նորարարական լուծումներ ունեցող օգտատերերի և իրենց բիզնեսի համար նոր լուծումներ փնտրող կազմակերպությունների համար:")
  , (MapItem "For Idea generators" "Գաղափար գեներացնողների համար"), (MapItem "Free plan" "Անվճար փաթեթ")
  , (MapItem "Basic" "Հիմնական"), (MapItem "Plus" "Պլյուս"), (MapItem "Premium" "Պրեմիում"), (MapItem "save" "խնայեք")
  , (MapItem "Region" "Տարածաշրջան"), (MapItem "Current continent" "Ընթացիկ մայրցամաք")
  , (MapItem "Worldwide" "Ամբողջ աշխարհ"), (MapItem "Subscribe" "Բաժանորդագրվել")
  , (MapItem "Looking for more options?" "Ցանկանու՞մ եք լրացուցիչ հնարավորություններ:")
  , (MapItem "Contact us" "Կապվեք մեզ հետ"), (MapItem "For organizations" "Կազմակերպությունների համար")
  , (MapItem "Enterprise" "Ձեռնարկություն"), (MapItem "short version" "հակիրճ տարբերակ")
  , (MapItem "complete version" "ամբողջական տարբերակ")
  , (MapItem "Tons of innovative ideas are born every day, even every hour, but are quite often not put into action as the right users in need of them are not easy to be found, or idea generators do not know how or whom to approach. On the other hand, there are a lot of companies/organizations seeking/looking for fresh, innovative ideas or solutions, but have limited resources and/or do not know where to find them." "Ամեն օր, նույնիսկ ամեն ժամ հազարավոր նորարարական գաղափարներ են ծնվում, բայց շատ հաճախ չեն իրականանում, քանի որ հեշտ չէ գտնել նրանց, ով ունի հենց այդ ուծման կարիքը, կամ գաղափարներ գեներացնողները չգիտեն՝ ինչպես և ում առաջարկել դրանք: Մյուս կողմից, մեծ թվով կազմակերպություններ կան, որոնք փնտրում են նորարարական/թարմ գաղափարներ կամ լուծումներ, բայց ունեն սահմանափակ ռեսուրսներ և/կամ չգիտեն՝ որտեղ գտնեն այդ գաղափարները:")
  , (MapItem "That's where our platform provides a helping hand. Innovities is here to help connect both idea generators and companies who are looking for them." "Հենց այստեղ է, որ մեր հարթակը օգնության է հասնում: Innovities-ն օգնում է նորարարական լուծումներ ունեցող օգտատերերին և կազմակերպություններին գտնել իրար:")
  , (MapItem "You have a great idea or you need a solution for your business? Get registered and be a part of the world where ideas can turn into solution." "Ունեք հետաքրքիր գաղափար, կամ Ձեր բիզնեսի համար հարկավոր են թարմ լուծումնե՞ր: Գրանցվեք և այն աշխարկի մի մասը, որտեղ գաղափարները կարող են վերածվել իրականության:")
  , (MapItem "First name" "Անուն"), (MapItem "Message" "Հաղորդագրություն"), (MapItem "Send" "Ուղարկել")
  , (MapItem "All rights reserved. Terms of Service." "Բոլոր իրավունքները պաշտպանված են: Ծառայությունների մատուցման պայմաններ:")
  , (MapItem "Settings and Privacy" "Կարգավորումներ և Գաղտնիություն"), (MapItem "Help Center" "Օգնության կենտրոն")
  , (MapItem "Sign out" "Դուրս գալ"), (MapItem "Connections" "Կոնտակտներ"), (MapItem "Proposals" "Առաջարկներ")
  , (MapItem "Photo/Video" "Նկար/Վիդեո"), (MapItem "Suggestions" "Առաջարկություններ"), (MapItem "Edit profile" "Խմբագրել պրոֆիլը")
  , (MapItem "Share profile" "Կիսվել պրոֆիլով"), (MapItem "Industry" "Ոլորտ"), (MapItem "Industries we are interested in" "Ոլորտներ՝ որոնցով մենք հետաքրքրված ենք")
  , (MapItem "Education" "Կրթություն"), (MapItem "Experience" "Փորձ"), (MapItem "Generated ideas" "Գեներացված գաղափարներ")
  , (MapItem "Us" "Մենք"), (MapItem "Me" "Ես"), (MapItem "Follow" "Հետևել"), (MapItem "Share" "Կիսվել")
  , (MapItem "Post" "Գրառել"), (MapItem "Post an Idea" "Գաղափար տեղադրել"), (MapItem "Company" "Կազմակերպություն")
  , (MapItem "User name" "Օգտատիրոջ անուն")
  , (MapItem "I agree to the Terms of Service and understand the Privacy statement." "Համաձայն եմ ծառայությունների մատուցման պայմաններին և հասկանում եմ գաղտնիության քաղաքականությունը:")
  , (MapItem "Company Name" "Կազմակերպության անուն"), (MapItem "Password" "Գաղտնաբառ"), (MapItem "E-mail" "Էլ. հասցե")
  , (MapItem "Sign-Up" "Գրանցվել"), (MapItem "Idea Generator" "Գաղափար գեներացնող"), (MapItem "Name Surname" "Անուն Ազգանուն")
  -- idea generator settings
  , (MapItem "Username" "Օգտատիրոջ անուն"), (MapItem "Name" "Անուն"), (MapItem "Surname" "Ազգանուն")
  , (MapItem "Photo" "Նկար"), (MapItem "Phone number" "Հեռախոսահամար")
  , (MapItem "Email address" "Էլ. հասցե"), (MapItem "About Me" "Իմ մասին"), (MapItem "Country" "Երկիր")
  , (MapItem "Change Password" "Փոխեք գաղտնաբառը"), (MapItem "Confirm Password" "Հաստատել գաղտնաբառը")
  , (MapItem "Select your tarriff plan" "Ընտրեք Ձեր սակագնային փաթեթը"), (MapItem "Select Payment Method" "Ընտրեք վճարման եղանակը")
  -- company settings
  , (MapItem "Logo" "Լոգո"), (MapItem "Website address" "Կայք"), (MapItem "About Us" "Մեր մասին")
  ]


getLocal : String -> Model -> String
getLocal key model =
  let
    local_list =
      List.filter (\i -> i.key == key) locals

    local =
      case (List.head local_list) of
        Just l -> l
        Nothing -> (MapItem "" "")

    o =
      case model.language of
        Models.Eng -> local.key
        Models.Arm -> local.value

  in
    o
