defmodule Telegram.Types.Chat do
  @moduledoc """
  This struct represents chat data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => boolean
  }

  @type t :: %__MODULE__{
              id:                             integer,
              type:                           String.t,
              title:                          String.t | nil,
              username:                       String.t | nil,
              first_name:                     String.t | nil,
              last_name:                      String.t | nil,
              all_members_are_administrators: boolean | nil}

  defstruct id:                             0,
            type:                           "",
            title:                          nil,
            username:                       nil,
            first_name:                     nil,
            last_name:                      nil,
            all_members_are_administrators: nil

  @doc """
  Creates a Chat struct from a map object.

  This requires the presence of "id" and "type",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a chat
  map to a Chat struct.

  ## Examples

      iex> Telegram.Types.Chat.from_map(%{ "id" => 5, "type" => "private" })
      {:ok, %Telegram.Types.Chat{id: 5, type: "private"}}

      iex> Telegram.Types.Chat.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Chat data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"id" => id, "type" => type}=map) do
    {:ok, %__MODULE__{
      id:                             id,
      type:                           type,
      title:                          Map.get(map, "title"),
      username:                       Map.get(map, "username"),
      first_name:                     Map.get(map, "first_name"),
      last_name:                      Map.get(map, "last_name"),
      all_members_are_administrators: Map.get(map, "all_members_are_administrators")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Chat data"}}
  end

  @doc """
  Creates a Chat struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Chat.from_map!(%{ "id" => 5, "type" => "private" })
      %Telegram.Types.Chat{id: 5, type: "private"}

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
