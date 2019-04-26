defmodule Innovities.Mailing.Emails do
  import Bamboo.Email

  def email_for_contact_us(name, email, text) do
    #|> to("info@innovities.com")
    new_email
      #|> to("grigori.aramyan@gmail.com")
      |> to("info@innovities.com")
      |> from({name, email})
      |> subject("Message from Contact Us section")
      |> text_body(text)
  end
end
