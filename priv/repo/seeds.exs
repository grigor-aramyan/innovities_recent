# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Innovities.Repo.insert!(%Innovities.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Innovities.Repo
alias Innovities.Tarrifs.{InnovatorsPlan, OrganizationsPlan}
#alias Innovities.Content.Nda


#Repo.insert(%Nda{author_id: 20, author_is_org: false, idea_id: 9, recipient_id: 8, recipient_is_org: true, signing_date: "02.03.2019"})


Repo.insert!(%InnovatorsPlan{name: "Free", monthly_pay: 0, yearly_pay: 0, ideas_count: 2, organization_connection_count: 1, region: "Current country"})
Repo.insert!(%InnovatorsPlan{name: "Basic", monthly_pay: 8, yearly_pay: 88, ideas_count: 3, organization_connection_count: 3, region: "Current region"})
Repo.insert!(%InnovatorsPlan{name: "Plus", monthly_pay: 14, yearly_pay: 158, ideas_count: 6, organization_connection_count: 5, region: "Current continent"})
Repo.insert!(%InnovatorsPlan{name: "Premium", monthly_pay: 21, yearly_pay: 238, ideas_count: 8, organization_connection_count: 8, region: "Worldwide"})

Repo.insert!(%OrganizationsPlan{name: "Basic", monthly_pay: 48, yearly_pay: 548, complete_ideas_count: 5, innovator_connection_count: 15, region: "Current country"})
Repo.insert!(%OrganizationsPlan{name: "Plus", monthly_pay: 76, yearly_pay: 864, complete_ideas_count: 10, innovator_connection_count: 30, region: "Current region"})
Repo.insert!(%OrganizationsPlan{name: "Premium", monthly_pay: 128, yearly_pay: 1475, complete_ideas_count: 20, innovator_connection_count: 50, region: "Current continent"})
Repo.insert!(%OrganizationsPlan{name: "Max", monthly_pay: 216, yearly_pay: 2496, complete_ideas_count: 50, innovator_connection_count: 1_000_000, region: "Worldwide"})
