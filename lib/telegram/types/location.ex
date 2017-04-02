defmodule Telegram.Types.Location do
  @moduledoc """
  This struct represents location data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => float,
    required(String.t) => float
  }

  @type t :: %__MODULE__{
              longitude: float,
              latitude:  float}

  defstruct longitude: 0.0,
            latitude:  0.0

  @doc """
  Creates a Location struct from a map object.

  This requires the presence of "longitude" and "latitude",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a location
  map to a Location struct.

  ## Examples

    iex> Telegram.Types.Location.from_map(%{ "longitude" => 1.0, "latitude" => 1.0 })
    {:ok, %Telegram.Types.Location{longitude: 1.0, latitude: 1.0}}

    iex> Telegram.Types.Location.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Location data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"longitude" => longitude, "latitude" => latitude}) do
    {:ok, %__MODULE__{
      longitude:  longitude,
      latitude:   latitude
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Location data"}}
  end

  @doc """
  Creates a Location struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Location.from_map!(%{ "longitude" => 1.0, "latitude" => 1.0 })
      %Telegram.Types.Location{longitude: 1.0, latitude: 1.0}

      iex> Telegram.Types.Location.from_map!(%{})
      ** (Telegram.Error) Invalid Location data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, location} ->
        location
      {:error, error} ->
        raise error
    end
  end
end
