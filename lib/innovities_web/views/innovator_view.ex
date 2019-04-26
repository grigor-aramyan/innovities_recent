defmodule InnovitiesWeb.InnovatorView do
  use InnovitiesWeb, :view

  def render("innovator.json", %{innovator: innovator}) do
    %{ id: innovator.id,
      name: innovator.full_name,
      pic_uri: innovator.picture_uri,
      rating: innovator.rating,
      country: innovator.country
    }
  end

  def render("innovator_extended.json", %{innovator: innovator, connections_count: cc, token: token}) do
    %{ data: %{
      innovator_data: %{ id: innovator.id,
        name: innovator.full_name,
        pic_uri: innovator.picture_uri,
        rating: innovator.rating,
        country: innovator.country,
        email: innovator.email,
        ideas_count: innovator.generated_ideas_count,
        innovators_plan_id: innovator.innovators_plan_id,
        description: innovator.description,
        about_me: innovator.about_me,
        education: innovator.education,
        experience: innovator.experience,
        username: innovator.username,
        phone: innovator.phone,
        connections_count: cc
      },
    token: token
      }
    }
  end

end
