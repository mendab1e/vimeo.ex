defmodule Vimeo.Groups do
  @moduledoc """
  Provides access to the `/groups` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a list of all Groups.
  """
  def all(params \\ %{}) do
    API.get("groups", params).data
    |> Enum.map(&(Parser.parse(&1, :group)))
  end

  @doc """
  Get a Group.
  """
  def get(id) do
    API.get("groups/#{id}")
    |> Parser.parse(:group)
  end

  @doc """
  Create a new Group.
  """
  def create(data) do
    API.post("groups", data)
  end

  @doc """
  Delete a Group.
  """
  def delete(id) do
    API.delete("groups/#{id}")
  end

  @doc """
  Get a list of users that joined a Group.
  """
  def users(id, params \\ %{}) do
    API.get("groups/#{id}/users", params).data
    |> Enum.map(&(Parser.parse(&1, :user)))
  end

  @doc """
  Get a list of videos in a Group.
  """
  def videos(group_id, params \\ %{}) do
    API.get("groups/#{group_id}/videos", params).data
    |> Enum.map(&(Parser.parse(&1, :video)))
  end

  @doc """
  Check if a Group has a video.
  """
  def video(group_id, video_id) do
    API.get("groups/#{group_id}/videos/#{video_id}")
    |> Parser.parse(:video)
  end

  @doc """
  Add a video to a Group.
  """
  def add_video(group_id, video_id) do
    API.put("groups/#{group_id}/videos/#{video_id}")
  end

  @doc """
  Remove a video from a Group.
  """
  def remove_video(group_id, video_id) do
    API.delete("groups/#{group_id}/videos/#{video_id}")
  end
end