defmodule Telegram.Types.UserProfilePhotos do
  @moduledoc """
  This struct represents user_profile_photos data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_structs: 2]

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => [Telegram.Types.PhotoSize.input_type]
  }

  @type t :: %__MODULE__{
              total_count:    integer,
              photos:         [Telegram.Types.PhotoSize.t]}

  defstruct total_count:    0,
            photos:         []

  @doc """
  Creates a UserProfilePhotos struct from a map object.

  This requires the presence of "location" and "title",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a user_profile_photos
  map to a UserProfilePhotos struct.

  ## Examples

      iex> Telegram.Types.UserProfilePhotos.from_map(%{ "total_count" => 0, "photos" => [] })
      {:ok, %Telegram.Types.UserProfilePhotos{total_count: 0, photos: []}}

      iex> Telegram.Types.UserProfilePhotos.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid UserProfilePhotos data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"total_count" => total_count, "photos" => photos}) do
    {:ok, %__MODULE__{
      total_count:  total_count,
      photos:       to_structs(photos, Telegram.Types.PhotoSize)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid UserProfilePhotos data"}}
  end

  @doc """
  Creates a UserProfilePhotos struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.UserProfilePhotos.from_map!(%{ "total_count" => 0, "photos" => [] })
      %Telegram.Types.UserProfilePhotos{total_count: 0, photos: []}

      iex> Telegram.Types.UserProfilePhotos.from_map!(%{})
      ** (Telegram.Error) Invalid UserProfilePhotos data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, user_profile_photos} ->
        user_profile_photos
      {:error, error} ->
        raise error
    end
  end
end
