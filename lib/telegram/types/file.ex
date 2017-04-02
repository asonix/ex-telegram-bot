defmodule Telegram.Types.File do
  @moduledoc """
  This struct represents file data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => String.t,
    optional(String.t) => integer,
    optional(String.t) => String.t
  }

  @type t :: %__MODULE__{
              file_id:    String.t,
              file_size:  integer | nil,
              file_path:  String.t | nil}

  defstruct file_id:    0,
            file_size:  nil,
            file_path:  nil

  @doc """
  Creates a File struct from a map object.

  This requires the presence of "file_id" and "width",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a file
  map to a File struct.

  ## Examples

    iex> Telegram.Types.File.from_map(%{ "file_id" => "abcd" })
    {:ok, %Telegram.Types.File{file_id: "abcd"}}

    iex> Telegram.Types.File.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid File data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"file_id" => file_id}=map) do
    {:ok, %__MODULE__{
      file_id:    file_id,
      file_size:  map["file_size"],
      file_path:  map["file_path"]
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid File data"}}
  end

  @doc """
  Creates a File struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.File.from_map!(%{ "file_id" => "abcd" })
      %Telegram.Types.File{file_id: "abcd"}

      iex> Telegram.Types.File.from_map!(%{})
      ** (Telegram.Error) Invalid File data

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
