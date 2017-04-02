defmodule Telegram.Types.Voice do
  @moduledoc """
  This struct represents voice data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => integer,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    String.t,
              duration:   integer,
              mime_type:  String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:   0,
            duration:  0,
            mime_type: nil,
            file_size: nil

  @doc """
  Creates a Voice struct from a map object.

  This requires the presence of "file_id" and "duration",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a voice
  map to a Voice struct.

  ## Examples

    iex> Telegram.Types.Voice.from_map(%{ "file_id" => "abcd", "duration" => 0 })
    {:ok, %Telegram.Types.Voice{file_id: "abcd", duration: 0}}

    iex> Telegram.Types.Voice.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Voice data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => id, "duration" => duration}=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      duration:   duration,
      mime_type:  Map.get(map, "mime_type"),
      file_size:  Map.get(map, "file_size")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Voice data"}}
  end

  @doc """
  Creates a Voice struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Voice.from_map!(%{ "file_id" => "abcd", "duration" => 0 })
      %Telegram.Types.Voice{file_id: "abcd", duration: 0}

      iex> Telegram.Types.Voice.from_map!(%{})
      ** (Telegram.Error) Invalid Voice data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, voice} ->
        voice
      {:error, error} ->
        raise error
    end
  end
end
