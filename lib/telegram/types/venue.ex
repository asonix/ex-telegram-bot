defmodule Telegram.Types.Venue do
  @moduledoc """
  This struct represents venue data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => Telegram.Types.Location.input_type,
    required(String.t) => String.t,
    required(String.t) => String.t,
    optional(String.t) => String.t
  }

  @type t :: %__MODULE__{
              location:       Telegram.Types.Location.t,
              title:          String.t,
              address:        String.t,
              foursquare_id:  String.t | nil}

  defstruct location:       %Telegram.Types.Location{},
            title:          "",
            address:        "",
            foursquare_id:  nil

  @doc """
  Creates a Venue struct from a map object.

  This requires the presence of "location" and "title",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a venue
  map to a Venue struct.

  ## Examples

      iex> Telegram.Types.Venue.from_map(%{ "location" => %{"longitude" => 1.0, "latitude" => 1.0}, "title" => "A House", "address" => "1234 Road Dr"})
      {:ok, %Telegram.Types.Venue{location: %Telegram.Types.Location{longitude: 1.0, latitude: 1.0}, title: "A House", address: "1234 Road Dr"}}

      iex> Telegram.Types.Venue.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Venue data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"location" => location, "title" => title, "address" => address}=map) do
    {:ok, %__MODULE__{
      location:       to_struct(location, Telegram.Types.Location),
      title:          title,
      address:        address,
      foursquare_id:  Map.get(map, "foursquare_id")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Venue data"}}
  end

  @doc """
  Creates a Venue struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Venue.from_map!(%{ "location" => %{"longitude" => 1.0, "latitude" => 1.0}, "title" => "A House", "address" => "1234 Road Dr"})
      %Telegram.Types.Venue{location: %Telegram.Types.Location{longitude: 1.0, latitude: 1.0}, title: "A House", address: "1234 Road Dr"}

      iex> Telegram.Types.Venue.from_map!(%{})
      ** (Telegram.Error) Invalid Venue data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, venue} ->
        venue
      {:error, error} ->
        raise error
    end
  end
end
