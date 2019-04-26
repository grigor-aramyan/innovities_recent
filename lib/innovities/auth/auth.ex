defmodule Innovities.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Innovities.Repo

  alias Innovities.Auth.Token

  @doc """
  Returns the Token provided token string.

  ## Examples

  iex> find_token("valid token string")
  %Token{}

  iex> find_token("invalid or inexistent token")
  nil

  """

  def find_token(token) do
    Repo.get_by(Token, token: token)
  end

  @doc """
  Returns the list of tokens.

  ## Examples

      iex> list_tokens()
      [%Token{}, ...]

  """
  def list_tokens do
    Repo.all(Token)
  end

  @doc """
  Gets a single token.

  Raises `Ecto.NoResultsError` if the Token does not exist.

  ## Examples

      iex> get_token!(123)
      %Token{}

      iex> get_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_token!(id), do: Repo.get!(Token, id)

  @doc """
  Creates a token.

  ## Examples

      iex> create_token(%{field: value})
      {:ok, %Token{}}

      iex> create_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_token(attrs \\ %{}) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a token updated_at field provided token string.

  ## Examples

      iex> update_token_time("some valid token string")
      {:ok, %Token{}}

      iex> update_token_time("invalid or inexistent token")
      {:ok, %Token{}} - empty token

  """

  def update_token_time(token) do
    case find_token(token) do
      t = %Token{} ->
        update_token(t, %{updated_at: NaiveDateTime.utc_now()})
      _ ->
        {:ok, %Token{}}
    end
  end

  @doc """
  Updates a token.

  ## Examples

      iex> update_token(token, %{field: new_value})
      {:ok, %Token{}}

      iex> update_token(token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_token(%Token{} = token, attrs) do
    token
    |> Token.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Removes a Token provided token string.

  ## Examples

      iex> remove_token("some token string")
      {:ok, %Token{}}

      iex> remove_token("invalid or inexistent token")
      {:error, %Ecto.Changeset{}}

  """

  def remove_token(token) do
    case Repo.get_by(Token, token: token) do
      t = %Token{} ->
        delete_token(t)
      _ ->
        {:error, %Ecto.Changeset{}}
    end
  end

  @doc """
  Deletes a Token.

  ## Examples

      iex> delete_token(token)
      {:ok, %Token{}}

      iex> delete_token(token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_token(%Token{} = token) do
    Repo.delete(token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking token changes.

  ## Examples

      iex> change_token(token)
      %Ecto.Changeset{source: %Token{}}

  """
  def change_token(%Token{} = token) do
    Token.changeset(token, %{})
  end
end
