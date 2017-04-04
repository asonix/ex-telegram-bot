defmodule Telegram.Types.Chat do
  @moduledoc """
  This struct represents chat data provided by Telegram's bot API
  """

  @type input_type :: Telegram.Types.Chat.Private.input_type |
                      Telegram.Types.Chat.Group.input_type |
                      Telegram.Types.Chat.Supergroup.input_type |
                      Telegram.Types.Chat.Channel.input_type

  @type t :: Telegram.Types.Chat.Private.t |
             Telegram.Types.Chat.Group.t |
             Telegram.Types.Chat.Supergroup.t |
             Telegram.Types.Chat.Channel.t

  @doc """
  Creates a Chat struct from a map object.

  This requires the presence of "id" and "type",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a chat
  map to a Chat struct.

  ## Examples

      iex> Telegram.Types.Chat.from_map(%{ "id" => 5, "type" => "group", "title" => "hey" })
      {:ok, %Telegram.Types.Chat.Group{id: 5, title: "hey"}}

      iex> Telegram.Types.Chat.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Chat data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"type" => type}=map) do
    case type do
      "private" ->
        Telegram.Types.Chat.Private.from_map(map)

      "group" ->
        Telegram.Types.Chat.Group.from_map(map)

      "supergroup" ->
        Telegram.Types.Chat.Supergroup.from_map(map)

      "channel" ->
        Telegram.Types.Chat.Channel.from_map(map)

      _ ->
        {:error, %Telegram.Error{message: "Invalid Chat data"}}
    end
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Chat data"}}
  end

  @doc """
  Creates a Chat struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Chat.from_map!(%{ "id" => 5, "type" => "private", "first_name" => "yo" })
      %Telegram.Types.Chat.Private{id: 5, first_name: "yo"}

      iex> Telegram.Types.Chat.from_map!(%{})
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
