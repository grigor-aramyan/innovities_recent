defmodule Innovities.ContentTest do
  use Innovities.DataCase

  alias Innovities.Content

  describe "ideas" do
    alias Innovities.Content.Idea

    @valid_attrs %{long_description: "some long_description", short_description: "some short_description"}
    @update_attrs %{long_description: "some updated long_description", short_description: "some updated short_description"}
    @invalid_attrs %{long_description: nil, short_description: nil}

    def idea_fixture(attrs \\ %{}) do
      {:ok, idea} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_idea()

      idea
    end

    test "list_ideas/0 returns all ideas" do
      idea = idea_fixture()
      assert Content.list_ideas() == [idea]
    end

    test "get_idea!/1 returns the idea with given id" do
      idea = idea_fixture()
      assert Content.get_idea!(idea.id) == idea
    end

    test "create_idea/1 with valid data creates a idea" do
      assert {:ok, %Idea{} = idea} = Content.create_idea(@valid_attrs)
      assert idea.long_description == "some long_description"
      assert idea.short_description == "some short_description"
    end

    test "create_idea/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_idea(@invalid_attrs)
    end

    test "update_idea/2 with valid data updates the idea" do
      idea = idea_fixture()
      assert {:ok, idea} = Content.update_idea(idea, @update_attrs)
      assert %Idea{} = idea
      assert idea.long_description == "some updated long_description"
      assert idea.short_description == "some updated short_description"
    end

    test "update_idea/2 with invalid data returns error changeset" do
      idea = idea_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_idea(idea, @invalid_attrs)
      assert idea == Content.get_idea!(idea.id)
    end

    test "delete_idea/1 deletes the idea" do
      idea = idea_fixture()
      assert {:ok, %Idea{}} = Content.delete_idea(idea)
      assert_raise Ecto.NoResultsError, fn -> Content.get_idea!(idea.id) end
    end

    test "change_idea/1 returns a idea changeset" do
      idea = idea_fixture()
      assert %Ecto.Changeset{} = Content.change_idea(idea)
    end
  end

  describe "posts" do
    alias Innovities.Content.Post

    @valid_attrs %{likes: 42, media_file_uri: "some media_file_uri", message: "some message"}
    @update_attrs %{likes: 43, media_file_uri: "some updated media_file_uri", message: "some updated message"}
    @invalid_attrs %{likes: nil, media_file_uri: nil, message: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Content.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Content.create_post(@valid_attrs)
      assert post.likes == 42
      assert post.media_file_uri == "some media_file_uri"
      assert post.message == "some message"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Content.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.likes == 43
      assert post.media_file_uri == "some updated media_file_uri"
      assert post.message == "some updated message"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_attrs)
      assert post == Content.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Content.change_post(post)
    end
  end

  describe "comments" do
    alias Innovities.Content.Comment

    @valid_attrs %{author_id: 42, author_is_org: true, author_name: "some author_name", body: "some body", input_date: "some input_date", post_id: 42}
    @update_attrs %{author_id: 43, author_is_org: false, author_name: "some updated author_name", body: "some updated body", input_date: "some updated input_date", post_id: 43}
    @invalid_attrs %{author_id: nil, author_is_org: nil, author_name: nil, body: nil, input_date: nil, post_id: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Content.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Content.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Content.create_comment(@valid_attrs)
      assert comment.author_id == 42
      assert comment.author_is_org == true
      assert comment.author_name == "some author_name"
      assert comment.body == "some body"
      assert comment.input_date == "some input_date"
      assert comment.post_id == 42
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Content.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.author_id == 43
      assert comment.author_is_org == false
      assert comment.author_name == "some updated author_name"
      assert comment.body == "some updated body"
      assert comment.input_date == "some updated input_date"
      assert comment.post_id == 43
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_comment(comment, @invalid_attrs)
      assert comment == Content.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Content.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Content.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Content.change_comment(comment)
    end
  end

  describe "ndas" do
    alias Innovities.Content.Nda

    @valid_attrs %{author_id: 42, author_is_org: true, idea_id: 42, recipient_id: 42, recipient_is_org: true}
    @update_attrs %{author_id: 43, author_is_org: false, idea_id: 43, recipient_id: 43, recipient_is_org: false}
    @invalid_attrs %{author_id: nil, author_is_org: nil, idea_id: nil, recipient_id: nil, recipient_is_org: nil}

    def nda_fixture(attrs \\ %{}) do
      {:ok, nda} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_nda()

      nda
    end

    test "list_ndas/0 returns all ndas" do
      nda = nda_fixture()
      assert Content.list_ndas() == [nda]
    end

    test "get_nda!/1 returns the nda with given id" do
      nda = nda_fixture()
      assert Content.get_nda!(nda.id) == nda
    end

    test "create_nda/1 with valid data creates a nda" do
      assert {:ok, %Nda{} = nda} = Content.create_nda(@valid_attrs)
      assert nda.author_id == 42
      assert nda.author_is_org == true
      assert nda.idea_id == 42
      assert nda.recipient_id == 42
      assert nda.recipient_is_org == true
    end

    test "create_nda/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_nda(@invalid_attrs)
    end

    test "update_nda/2 with valid data updates the nda" do
      nda = nda_fixture()
      assert {:ok, nda} = Content.update_nda(nda, @update_attrs)
      assert %Nda{} = nda
      assert nda.author_id == 43
      assert nda.author_is_org == false
      assert nda.idea_id == 43
      assert nda.recipient_id == 43
      assert nda.recipient_is_org == false
    end

    test "update_nda/2 with invalid data returns error changeset" do
      nda = nda_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_nda(nda, @invalid_attrs)
      assert nda == Content.get_nda!(nda.id)
    end

    test "delete_nda/1 deletes the nda" do
      nda = nda_fixture()
      assert {:ok, %Nda{}} = Content.delete_nda(nda)
      assert_raise Ecto.NoResultsError, fn -> Content.get_nda!(nda.id) end
    end

    test "change_nda/1 returns a nda changeset" do
      nda = nda_fixture()
      assert %Ecto.Changeset{} = Content.change_nda(nda)
    end
  end
end
