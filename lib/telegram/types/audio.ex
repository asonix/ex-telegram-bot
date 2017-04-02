defmodule Telegram.Types.Audio do
  @moduledoc """
  This struct represents audio data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    integer,
              duration:   integer,
              performer:  String.t | nil,
              title:      String.t | nil,
              mime_type:  String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:   0,
            duration:  0,
            performer: nil,
            title:     nil,
            mime_type: nil,
            file_size: nil

  @doc """
  Creates a Audio struct from a map object.

  This requires the presence of "file_id" and "duration",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a audio
  map to a Audio struct.

  ## Examples

      iex> Telegram.Types.Audio.from_map(%{ "file_id" => 5, "duration" => 0 })
      {:ok, %Telegram.Types.Audio{file_id: 5, duration: 0}}

      iex> Telegram.Types.Audio.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Audio data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => id, "duration" => duration}=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      duration:   duration,
      performer:  Map.get(map, "performer"),
      title:      Map.get(map, "title"),
      mime_type:  Map.get(map, "mime_type"),
      file_size:  Map.get(map, "file_size")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Audio data"}}
  end

  @doc """
  Creates a Audio struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Audio.from_map!(%{ "file_id" => 5, "duration" => 0 })
      %Telegram.Types.Audio{file_id: 5, duration: 0}

      iex> Telegram.Types.Audio.from_map!(%{})
      ** (Telegram.Error) Invalid Audio data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, audio} ->
        audio
      {:error, error} ->
        raise error
    end
  end
end
