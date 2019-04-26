defmodule Innovities.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Innovities.Repo

  alias Innovities.Content.Idea

  @doc """
  Returns the list of ideas.

  ## Examples

      iex> list_ideas()
      [%Idea{}, ...]

  """
  def list_ideas do
    Repo.all(Idea)
  end

  @doc """
  Gets a single idea.

  Raises `Ecto.NoResultsError` if the Idea does not exist.

  ## Examples

      iex> get_idea!(123)
      %Idea{}

      iex> get_idea!(456)
      ** (Ecto.NoResultsError)

  """
  def get_idea!(id), do: Repo.get!(Idea, id)

  def get_ideas_by_innovator_id(id) do
    Repo.get_by(Idea, innovator_id: id)
  end

  @doc """
  Creates a idea.

  ## Examples

      iex> create_idea(%{field: value})
      {:ok, %Idea{}}

      iex> create_idea(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_idea(attrs \\ %{}) do
    %Idea{}
    |> Idea.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a idea.

  ## Examples

      iex> update_idea(idea, %{field: new_value})
      {:ok, %Idea{}}

      iex> update_idea(idea, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_idea(%Idea{} = idea, attrs) do
    idea
    |> Idea.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Idea.

  ## Examples

      iex> delete_idea(idea)
      {:ok, %Idea{}}

      iex> delete_idea(idea)
      {:error, %Ecto.Changeset{}}

  """
  def delete_idea(%Idea{} = idea) do
    Repo.delete(idea)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking idea changes.

  ## Examples

      iex> change_idea(idea)
      %Ecto.Changeset{source: %Idea{}}

  """
  def change_idea(%Idea{} = idea) do
    Idea.changeset(idea, %{})
  end

  alias Innovities.Content.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Innovities.Content.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  alias Innovities.Content.Nda

  @doc """
  Returns the list of ndas.

  ## Examples

      iex> list_ndas()
      [%Nda{}, ...]

  """
  def list_ndas do
    Repo.all(Nda)
  end

  @doc """
  Gets a single nda.

  Raises `Ecto.NoResultsError` if the Nda does not exist.

  ## Examples

      iex> get_nda!(123)
      %Nda{}

      iex> get_nda!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nda!(id), do: Repo.get!(Nda, id)

  @doc """
  Creates a nda.

  ## Examples

      iex> create_nda(%{field: value})
      {:ok, %Nda{}}

      iex> create_nda(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nda(attrs \\ %{}) do
    %Nda{}
    |> Nda.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nda.

  ## Examples

      iex> update_nda(nda, %{field: new_value})
      {:ok, %Nda{}}

      iex> update_nda(nda, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nda(%Nda{} = nda, attrs) do
    nda
    |> Nda.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Nda.

  ## Examples

      iex> delete_nda(nda)
      {:ok, %Nda{}}

      iex> delete_nda(nda)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nda(%Nda{} = nda) do
    Repo.delete(nda)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nda changes.

  ## Examples

      iex> change_nda(nda)
      %Ecto.Changeset{source: %Nda{}}

  """
  def change_nda(%Nda{} = nda) do
    Nda.changeset(nda, %{})
  end
end
