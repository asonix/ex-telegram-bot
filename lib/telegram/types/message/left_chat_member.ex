defmodule Telegram.Types.Message.LeftChatMember do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.Chat.input_type,
    required(String.t) => Telegram.Types.User.input_type
  }

  @type t :: %__MODULE__{
              message_id:       integer,
              date:             integer,
              chat:             Telegram.Types.Chat.t | nil,
              left_chat_member: Telegram.Types.User.t}

  defstruct message_id:       0,
            date:             0,
            chat:             nil,
            left_chat_member: %Telegram.Types.User{}

  @doc """
  Creates a Message struct from a map object.

  This requires the presence of "message_id" and "date",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message
  map to a Message struct.

  ## Examples

      iex> Telegram.Types.Message.LeftChatMember.from_map(%{ "message_id" => 5, "date" => 0 })
      {:ok, %Telegram.Types.Message.LeftChatMember{message_id: 5, date: 0}}

      iex> Telegram.Types.Message.LeftChatMember.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "message_id" => message_id,
    "date" => date,
    "left_chat_member" => left_chat_member
  }=map) do
    {:ok, %__MODULE__{
      message_id:       message_id,
      date:             date,
      chat:             to_struct(map["chat"], Telegram.Types.Chat),
      left_chat_member: to_struct(left_chat_member, Telegram.Types.User),
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Message.LeftChatMember.from_map!(%{ "message_id" => 5, "date" => 0 })
      %Telegram.Types.Message.LeftChatMember{message_id: 5, date: 0}

      iex> Telegram.Types.Message.LeftChatMember.from_map!(%{})
      ** (Telegram.Error) Invalid Message data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, message} ->
        message
      {:error, error} ->
        raise error
    end
  end
end
