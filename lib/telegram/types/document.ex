defmodule Telegram.Types.Document do
  @moduledoc """
  This struct represents document data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.PhotoSize.input_type,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    integer,
              thumb:      Telegram.Types.PhotoSize.t | nil,
              file_name:  String.t | nil,
              title:      String.t | nil,
              mime_type:  String.t | nil,
              file_size:  integer | nil}

  defstruct file_id:    0,
            thumb:      nil,
            file_name:  nil,
            title:      nil,
            mime_type:  nil,
            file_size:  nil

  @doc """
  Creates a Document struct from a map object.

  This requires the presence of "file_id" and "thumb",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a document
  map to a Document struct.

  ## Examples

      iex> Telegram.Types.Document.from_map(%{ "file_id" => 5 })
      {:ok, %Telegram.Types.Document{file_id: 5}}

      iex> Telegram.Types.Document.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Document data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => id}=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      thumb:      to_struct(map["thumb"], Telegram.Types.PhotoSize),
      file_name:  Map.get(map, "file_name"),
      mime_type:  Map.get(map, "mime_type"),
      file_size:  Map.get(map, "file_size")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Document data"}}
  end

  @doc """
  Creates a Document struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Document.from_map!(%{ "file_id" => 5 })
      %Telegram.Types.Document{file_id: 5}

      iex> Telegram.Types.Document.from_map!(%{})
      ** (Telegram.Error) Invalid Document data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, document} ->
        document
      {:error, error} ->
        raise error
    end
  end
end
