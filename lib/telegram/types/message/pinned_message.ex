defmodule Telegram.Types.Message.PinnedMessage do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.User.input_type,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.Chat.input_type,
    required(String.t) => Telegram.Types.Message.input_type
  }

  @type t :: %__MODULE__{
              message_id:               integer,
              from:                     Telegram.Types.User.t | nil,
              date:                     integer,
              chat:                     Telegram.Types.Chat.t | nil,
              pinned_message:           Telegram.Types.Message.t}

  defstruct message_id:               0,
            from:                     nil,
            date:                     0,
            chat:                     nil,
            pinned_message:           nil

  @doc """
  Creates a Message struct from a map object.

  This requires the presence of "message_id" and "date",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message
  map to a Message struct.

  ## Examples

      iex> Telegram.Types.Message.PinnedMessage.from_map(%{ "message_id" => 5, "date" => 0 })
      {:ok, %Telegram.Types.Message.PinnedMessage{message_id: 5, date: 0}}

      iex> Telegram.Types.Message.PinnedMessage.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "message_id" => message_id,
    "date" => date,
    "pinned_message" => pinned_message
  }=map) do
    {:ok, %__MODULE__{
      message_id:     message_id,
      from:           to_struct(map["from"], Telegram.Types.User),
      date:           date,
      chat:           to_struct(map["chat"], Telegram.Types.Chat),
      pinned_message: to_struct(pinned_message, Telegram.Types.Message)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Message.PinnedMessage.from_map!(%{ "message_id" => 5, "date" => 0 })
      %Telegram.Types.Message.PinnedMessage{message_id: 5, date: 0}

      iex> Telegram.Types.Message.PinnedMessage.from_map!(%{})
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
