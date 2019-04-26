defmodule Innovities.Locations.Locals do
  @regions %{
    "Central Africa": ["Angola", "Cameroon", "Central African Republic", "Chad", "Congo", "Congo, The Democratic Republic of the",
      "Equatorial Guinea", "Gabon", "Sao Tome and Principe", "South Sudan"],
    "Eastern Africa": ["Burundi", "Comoros", "Djibouti", "Eritrea", "Ethiopia", "Kenya", "Madagascar", "Malawi",
      "Mauritius", "Mayotte", "Mozambique", "Reunion", "Rwanda", "Seychelles", "Somalia", "Tanzania, United Republic of",
      "Uganda", "Zambia", "Zimbabwe"],
    "Northern Africa": ["Algeria", "Egypt", "Libya", "Morocco", "Sudan", "Tunisia", "Western Sahara"],
    "South Africa": ["Botswana", "Lesotho", "Namibia", "South Africa", "Swaziland"],
    "West Africa": ["Benin", "Burkina Faso", "Cape Verde", "Côte D'Ivoire", "Gambia", "Ghana", "Guinea",
      "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Niger", "Nigeria", "Senegal", "Sierra Leone", "Togo"],
    "Caribbean Islands": ["Anguilla", "Antigua and Barbuda", "Aruba", "Bahamas", "Barbados", "Cayman Islands",
      "Cuba", "Dominica", "Dominican Republic", "Grenada", "Guadeloupe", "Haiti", "Jamaica", "Martinique",
      "Montserrat", "Netherlands Antilles", "Puerto Rico", "Saint Kitts and Nevis", "Saint Lucia",
      "Saint Vincent and the Grenadines", "Trinidad and Tobago", "Turks and Caicos Islands", "Virgin Islands, British",
      "Virgin Islands, U.S."],
    "Central America": ["Belize", "Costa Rica", "El Salvador", "Guatemala", "Honduras", "Nicaragua", "Panama"],
    "North America": ["Bermuda", "Canada", "Greenland", "Mexico", "United States", "Alabama", "Alaska", "Arizona",
      "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho",
      "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts",
      "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
      "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
      "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
      "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"],
    "South America": ["Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Falkland Islands (Malvinas)",
      "French Guiana", "Guyana", "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela"],
    "Australia/Oceania": ["American Samoa", "Australia", "Cook Islands", "Fiji", "French Polynesia",
      "Guam", "Kiribati", "Marshall Islands", "Micronesia, Federated States of", "Nauru", "New Caledonia",
      "New Zealand", "Niue", "Northern Mariana Islands", "Palau", "Papua New Guinea", "Pitcairn Islands",
      "Samoa", "Solomon Islands", "Tokelau", "Tonga", "Tuvalu", "Vanuatu", "Wallis and Futuna"],
    "CIS": ["Armenia", "Azerbaijan", "Belarus", "Kazakhstan", "Kyrgyzstan", "Tajikistan", "Turkmenistan", "Uzbekistan"],
    "Eastern Asia": ["China", "Hong Kong", "Japan", "Korea, Democratic People's Republic of", "Korea, Republic of", "Macau", "Mongolia", "Taiwan"],
    "Eastern Europe - Northern Asia": ["Russian Federation", "Central District", "Southern District", "Northwestern District",
      "Far Eastern District", "Siberian District", "Urals District", "Volga District"],
    "Middle East": ["Bahrain", "Iraq", "Israel", "Jordan", "Kuwait", "Lebanon", "Oman", "Palestinian Territory", "Qatar",
      "Saudi Arabia", "Syrian Arab Republic", "United Arab Emirates", "Yemen"],
    "South - Central Asia": ["Afghanistan", "Bangladesh", "Bhutan", "India", "Iran, Islamic Republic of",
      "Maldives", "Nepal", "Pakistan", "Sri Lanka"],
    "South - East Asia": ["Brunei Darussalam", "Cambodia", "Christmas Island",
      "Cocos (Keeling) Islands", "Indonesia", "Lao People's Democratic Republic", "Malaysia",
      "Myanmar", "Philippines", "Singapore", "Thailand", "Timor-Leste", "Vietnam"],
    "Western Asia": ["Cyprus", "Georgia", "Turkey"],
    "Eeastern Europe": ["Bulgaria", "Czech Republic", "Hungary", "Moldova, Republic of",
      "Poland", "Romania", "Slovakia", "Ukraine"],
    "Northern Europe": ["Denmark", "Estonia", "Faroe Islands", "Finland", "Iceland",
      "Ireland", "Latvia", "Lithuania", "Norway", "Sweden", "United Kingdom"],
    "Southern Europe": ["Albania", "Andorra", "Bosnia and Herzegovina", "Croatia",
      "Gibraltar", "Greece", "Holy See (Vatican City State)", "Italy", "Macedonia",
      "Malta", "Monaco", "Montenegro", "Portugal", "San Marino", "Serbia", "Slovenia", "Spain"],
    "Western Europe": ["Austria", "Belgium", "France", "Germany", "Liechtenstein", "Luxembourg",
      "Netherlands", "Switzerland"]
  }

  @continents %{
    "Africa": ["Central Africa", "Eastern Africa", "Northern Africa", "South Africa", "West Africa"],
    "America": ["Caribbean Islands", "Central America", "North America", "South America"],
    "Australia": ["Australia/Oceania"],
    "Asia": ["CIS", "Eastern Asia", "Eastern Europe - Northern Asia", "Middle East", "South - Central Asia", "South - East Asia",
      "Western Asia"],
    "Europe": ["Eastern Europe", "Northern Europe", "Northern Europe", "Southern Europe", "Western Europe"]
  }

  def get_continent(region) do
    o =
      @continents
      |> Enum.filter(fn {_continent, regions} ->
        Enum.member?(regions, region)
      end)
      |> hd

    {c, _} = o
    Atom.to_string(c)
  end

  def get_region(country) do
    o =
      @regions
      |> Enum.filter(fn {_region, countries} ->
        Enum.member?(countries, country)
      end)
      |> hd

    {r, _} = o
    Atom.to_string(r)
  end
end
