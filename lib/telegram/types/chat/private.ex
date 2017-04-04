defmodule Telegram.Types.Chat.Private do
  @moduledoc """
  This struct represents chat data provided by Telegram's bot API
  """

  @type t :: %__MODULE__{
              id:         integer,
              username:   String.t | nil,
              first_name: String.t,
              last_name:  String.t | nil}

  defstruct id:         0,
            username:   nil,
            first_name: "",
            last_name:  nil

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => String.t,
    required(String.t) => String.t,
    optional(String.t) => String.t,
  }

  @type output_type :: {:ok, t} | {:error, Telegram.Error.t}

  @doc """
  Creates a Chat struct from a map object.

  This requires the presence of "id" and "type",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a chat
  map to a Chat struct.

  ## Examples

      iex> Telegram.Types.Chat.Private.from_map(%{ "id" => 5, "type" => "private", "first_name" => "John" })
      {:ok,
        %Telegram.Types.Chat.Private{
          id: 5,
          first_name: "John"
        }
      }

      iex> Telegram.Types.Chat.Private.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Chat data"}}

  """
  @spec from_map(input_type) :: output_type
  def from_map(%{
    "id" => id,
    "type" => "private",
    "first_name" => first_name
  }=map) do
    {:ok, %__MODULE__{
      id:                             id,
      username:                       Map.get(map, "username"),
      first_name:                     first_name,
      last_name:                      Map.get(map, "last_name")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Chat data"}}
  end

  @doc """
  Creates a Chat struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Chat.Private.from_map!(%{ "id" => 5, "type" => "private", "first_name" => "John" })
      %Telegram.Types.Chat.Private{
        id: 5,
        first_name: "John"
      }

      iex> Telegram.Types.Chat.Private.from_map!(%{})
      ** (Telegram.Error) Invalid Chat data

  """
  @spec from_map!(input_type) :: t | no_return
  def from_map!(map) do
    case from_map(map) do
      {:ok, chat} ->
        chat
      {:error, error} ->
        raise error
    end
  end
end
