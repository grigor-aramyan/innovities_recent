defmodule InnovitiesWeb.LandingView do
  use InnovitiesWeb, :view

  def render("preregs_list.json", %{reg_data: reg_data, error: error}) do
    %{ data: %{
          reg_data: reg_data,
          error: error
        }
      }
  end

  def render("promo_registration.json", %{innovator: innovator, idea: idea, error: error}) do
        pref_org =
          case innovator.prefered_organization do
            nil -> ""
            _ -> innovator.prefered_organization
          end
        %{data:
          %{ full_name: innovator.full_name,
          email: innovator.email,
          prefered_organization: pref_org,
          short_description: idea.short_description,
          error: error}
        }
  end

end
