defmodule InnovitiesWeb.Router do
  use InnovitiesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InnovitiesWeb do
    pipe_through :api

    post "/promo/registration", LandingController, :promotion_registration
    post "/admin_login", LandingController, :admin_login

    post "/organization/register", MainController, :register_company
    post "/innovator/register", MainController, :register_innovator
    get "/top_members", MainController, :fetch_top_members
    post "/member/login", MainController, :member_login
    post "/get_innovator_data", MainController, :get_innovator_data
    post "/get_organization_data", MainController, :get_organization_data
    post "/sign_out", MainController, :sign_out
    post "/submit_post", MainController, :submit_post
    post "/submit_idea", MainController, :submit_idea
    post "/fetch_extended_posts", MainController, :fetch_extended_posts
    post "/fetch_chat_history", MainController, :fetch_chat_history
    post "/fetch_unred_messages", MainController, :fetch_unred_messages
    post "/fetch_suggested_companies", MainController, :fetch_suggested_companies
    post "/fetch_suggested_innovators", MainController, :fetch_suggested_innovators
    post "/make_connection", MainController, :make_connection
    post "/check_connection_and_connect", MainController, :check_connection_and_connect

    post "/update_innovator_settings", MainController, :update_innovator_settings
    post "/update_organization_settings", MainController, :update_organization_settings
    post "/subscribe_tariff_plan", MainController, :subscribe_tariff_plan

    post "/make_token", MainController, :make_token

    post "/send_contact_email", MainController, :send_contact_us_email

    post "/mark_notif_as_red", MainController, :mark_notif_as_red
    post "/fetch_unred_notifs", MainController, :fetch_unred_notifs
    post "/like_post", MainController, :like_post

    post "/create_comment", MainController, :create_comment
    post "/fetch_comments", MainController, :fetch_comments

    post "/process_search", MainController, :process_search

    post "/create_full_desc_req_notification", MainController, :create_full_desc_req_notification
    post "/accept_or_reject_full_desc_req", MainController, :accept_or_reject_full_desc_req

    post "/get_full_idea", MainController, :get_full_idea

    post "/save_nda", MainController, :save_nda
    post "/fetch_signed_ndas", MainController, :fetch_signed_ndas

  end

  scope "/", InnovitiesWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/admin_panel", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", InnovitiesWeb do
  #   pipe_through :api
  # end
end
