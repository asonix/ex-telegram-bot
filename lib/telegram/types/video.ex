defmodule Telegram.Types.Video do
  @moduledoc """
  This struct represents video data provided by Telegram's bot API
  """

  import Telegram.Util, only: [{:to_struct, 2}]

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => integer,
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.PhotoSize.input_type,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    integer,
              width:      integer,
              height:     integer,
              duration:   integer,
              thumb:      Telegram.Types.PhotoSize.t | nil,
              mime_type:  String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:   0,
            width:     0,
            height:    0,
            duration:  0,
            thumb:     nil,
            mime_type: nil,
            file_size: nil

  @doc """
  Creates a Video struct from a map object.

  This requires the presence of "file_id" and "duration",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a video
  map to a Video struct.

  ## Examples

    iex> Telegram.Types.Video.from_map(%{ "file_id" => 5, "width" => 0, "height" => 0, "duration" => 0 })
    {:ok, %Telegram.Types.Video{file_id: 5, width: 0, height: 0, duration: 0}}

    iex> Telegram.Types.Video.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Video data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "file_id" => id,
    "width" => width,
    "height" => height,
    "duration" => duration
  }=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      width:      width,
      height:     height,
      duration:   duration,
      thumb:      to_struct(map["thumb"], Telegram.Types.PhotoSize),
      mime_type:  Map.get(map, "mime_type"),
      file_size:  Map.get(map, "file_size")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Video data"}}
  end

  @doc """
  Creates a Video struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Video.from_map!(%{ "file_id" => 5, "width" => 0, "height" => 0, "duration" => 0 })
      %Telegram.Types.Video{file_id: 5, width: 0, height: 0, duration: 0}

      iex> Telegram.Types.Video.from_map!(%{})
      ** (Telegram.Error) Invalid Video data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, video} ->
        video
      {:error, error} ->
        raise error
    end
  end
end
