defmodule Telegram.Types.MessageEntity do
  @moduledoc """
  This struct represents message_entity data provided by Telegram's bot API
  """

  import Telegram.Util, only: [{:to_struct, 2}]

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => String.t,
    optional(String.t) => Telegram.Types.User.input_type
  }

  @type t :: %__MODULE__{
              type:   integer,
              offset: integer,
              length: integer,
              url:    String.t | nil,
              user:   Telegram.Types.User.t | nil}

  defstruct type:   0,
            offset: 0,
            length: 0,
            url:    nil,
            user:   nil

  @doc """
  Creates a MessageEntity struct from a map object.

  This requires the presence of "type" and "offset",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message_entity
  map to a MessageEntity struct.

  ## Examples

    iex> Telegram.Types.MessageEntity.from_map(%{ "type" => "mention", "offset" => 0, "length" => 0})
    {:ok, %Telegram.Types.MessageEntity{type: "mention", offset: 0, length: 0}}

    iex> Telegram.Types.MessageEntity.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid MessageEntity data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"type" => id, "offset" => offset, "length" => length}=map) do
    {:ok, %__MODULE__{
      type:     id,
      offset:   offset,
      length:   length,
      url:      Map.get(map, "user"),
      user:     to_struct(map["user"], Telegram.Types.User)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid MessageEntity data"}}
  end

  @doc """
  Creates a MessageEntity struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.MessageEntity.from_map!(%{ "type" => "mention", "offset" => 0, "length" => 0 })
      %Telegram.Types.MessageEntity{type: "mention", offset: 0, length: 0}

      iex> Telegram.Types.MessageEntity.from_map!(%{})
      ** (Telegram.Error) Invalid MessageEntity data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, message_entity} ->
        message_entity
      {:error, error} ->
        raise error
    end
  end
end
