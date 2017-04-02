defmodule Telegram.Types.Animation do
  @moduledoc """
  This struct represents file data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => String.t,
    optional(String.t) => [Telegram.Types.PhotoSize.input_type],
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    String.t,
              thumb:      Telegram.Types.PhotoSize.t | nil,
              file_name:  String.t | nil,
              mime_type:  String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:    0,
            thumb:      nil,
            file_name:  nil,
            mime_type:  nil,
            file_size:  nil

  @doc """
  Creates a Animation struct from a map object.

  This requires the presence of "file_id" and "width",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a file
  map to a Animation struct.

  ## Examples

    iex> Telegram.Types.Animation.from_map(%{ "file_id" => "abcd" })
    {:ok, %Telegram.Types.Animation{file_id: "abcd"}}

    iex> Telegram.Types.Animation.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Animation data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => id}=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      thumb:      to_struct(map["thumb"], Telegram.Types.PhotoSize),
      file_name:  map["file_name"],
      mime_type:  map["mime_type"],
      file_size:  map["file_size"]
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Animation data"}}
  end

  @doc """
  Creates a Animation struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Animation.from_map!(%{ "file_id" => "abcd" })
      %Telegram.Types.Animation{file_id: "abcd"}

      iex> Telegram.Types.Animation.from_map!(%{})
      ** (Telegram.Error) Invalid Animation data

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
