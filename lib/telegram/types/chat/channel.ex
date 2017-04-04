defmodule Telegram.Types.Chat.Channel do
  @moduledoc """
  This struct represents chat data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => String.t,
    optional(String.t) => String.t,
  }

  @type t :: %__MODULE__{
              id:       integer,
              title:    String.t,
              username: String.t | nil}

  defstruct id:       0,
            title:    nil,
            username: nil

  @doc """
  Creates a Chat struct from a map object.

  This requires the presence of "id" and "type",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a chat
  map to a Chat struct.

  ## Examples

      iex> Telegram.Types.Chat.Channel.from_map(%{ "id" => 5, "type" => "channel", "title" => "hey" })
      {:ok,
        %Telegram.Types.Chat.Channel{
          id: 5,
          title: "hey"
        }
      }

      iex> Telegram.Types.Chat.Channel.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Chat data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "id" => id,
    "type" => "channel",
    "title" => title
  }=map) do
    {:ok, %__MODULE__{
      id:       id,
      title:    title,
      username: Map.get(map, "username")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Chat data"}}
  end

  @doc """
  Creates a Chat struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Chat.Channel.from_map!(%{ "id" => 5, "type" => "channel", "title" => "hey" })
      %Telegram.Types.Chat.Channel{
        id: 5,
        title: "hey"
      }

      iex> Telegram.Types.Chat.Channel.from_map!(%{})
      ** (Telegram.Error) Invalid Chat data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, chat} ->
        chat
      {:error, error} ->
        raise error
    end
  end
end
