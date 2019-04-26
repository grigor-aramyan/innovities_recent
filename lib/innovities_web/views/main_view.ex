defmodule InnovitiesWeb.MainView do
  use InnovitiesWeb, :view


  def render("top_members.json", %{innovators: innovators, organnizations: organizations}) do
    %{ data: %{
        innovators: render_many(innovators, InnovitiesWeb.InnovatorView, "innovator.json"),
        organizations: render_many(organizations, InnovitiesWeb.OrganizationView, "organization.json")
      }}
  end

  def render("login.json", %{login_data: login_data, error: error}) do
    %{ data: %{
          login_data: login_data,
          error: error
        }
      }
  end

  def render("registration.json", %{reg_data: reg_data, error: error}) do
    %{ data: %{
          reg_data: reg_data,
          error: error
        }
      }
  end

  def render("simple_response.json", %{response: response}) do
    %{ response: response }
  end
end
