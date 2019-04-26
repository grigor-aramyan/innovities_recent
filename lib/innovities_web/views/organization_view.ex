defmodule InnovitiesWeb.OrganizationView do
  use InnovitiesWeb, :view

  def render("organization.json", %{organization: organization}) do
    %{ id: organization.id,
      name: organization.name,
      pic_uri: organization.logo_uri,
      country: organization.country
    }
  end

  def render("organization_extended.json", %{organization: organization, connections_count: cc, token: token}) do
    %{ data: %{
      organization_data: %{ id: organization.id,
        name: organization.name,
        pic_uri: organization.logo_uri,
        country: organization.country,
        email: organization.email,
        complete_ideas_count: organization.complete_ideas_count,
        organizations_plan_id: organization.organizations_plan_id,
        description: organization.description,
        webpage: organization.webpage,
        about_us: organization.about_us,
        industry: organization.industry,
        interested_industries: organization.interested_industries,
        username: organization.username,
        phone: organization.phone,
        rating: organization.rating,
        connections_count: cc
      },
      token: token
      }
    }
  end

end
