defmodule Telegram.Types.PhotoSize do
  @moduledoc """
  This struct represents photo_size data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              file_id:    String.t,
              width:      integer,
              height:     integer,
              file_size:  integer | nil}

  defstruct file_id:    "",
            width:      0,
            height:     0,
            file_size:  nil

  @doc """
  Creates a PhotoSize struct from a map object.

  This requires the presence of "file_id" and "width",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a photo_size
  map to a PhotoSize struct.

  ## Examples

    iex> Telegram.Types.PhotoSize.from_map(%{ "file_id" => "abcd", "width" => 0, "height" => 0})
    {:ok, %Telegram.Types.PhotoSize{file_id: "abcd", width: 0, height: 0}}

    iex> Telegram.Types.PhotoSize.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid PhotoSize data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => id, "width" => width, "height" => height}=map) do
    {:ok, %__MODULE__{
      file_id:    id,
      width:      width,
      height:     height,
      file_size:  Map.get(map, "file_size"),
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid PhotoSize data"}}
  end

  @doc """
  Creates a PhotoSize struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.PhotoSize.from_map!(%{ "file_id" => "abcd", "width" => 0, "height" => 0 })
      %Telegram.Types.PhotoSize{file_id: "abcd", width: 0, height: 0}

      iex> Telegram.Types.PhotoSize.from_map!(%{})
      ** (Telegram.Error) Invalid PhotoSize data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, photo_size} ->
        photo_size
      {:error, error} ->
        raise error
    end
  end
end
