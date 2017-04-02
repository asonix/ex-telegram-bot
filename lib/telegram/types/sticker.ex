defmodule Telegram.Types.Sticker do
  @moduledoc """
  This struct represents file data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.PhotoSize,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    String.t,
              width:      integer,
              height:     integer,
              thumb:      Telegram.Types.PhotoSize.t | nil,
              emoji:      String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:    0,
            width:      0,
            height:     0,
            thumb:      nil,
            emoji:      nil,
            file_size:  nil

  @doc """
  Creates a Sticker struct from a map object.

  This requires the presence of "file_id" and "width",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a file
  map to a Sticker struct.

  ## Examples

    iex> Telegram.Types.Sticker.from_map(%{ "file_id" => "abcd" })
    {:ok, %Telegram.Types.Sticker{file_id: "abcd"}}

    iex> Telegram.Types.Sticker.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Sticker data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "file_id" => file_id,
    "width" => width,
    "height" => height
  }=map) do
    {:ok, %__MODULE__{
      file_id:    file_id,
      width:      width,
      height:     height,
      thumb:      to_struct(map["thumb"], Telegram.PhotoSize),
      emoji:      map["emoji"],
      file_size:  map["file_size"]
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Sticker data"}}
  end

  @doc """
  Creates a Sticker struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Sticker.from_map!(%{ "file_id" => "abcd" })
      %Telegram.Types.Sticker{file_id: "abcd"}

      iex> Telegram.Types.Sticker.from_map!(%{})
      ** (Telegram.Error) Invalid Sticker data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, file} ->
        file
      {:error, error} ->
        raise error
    end
  end
end
