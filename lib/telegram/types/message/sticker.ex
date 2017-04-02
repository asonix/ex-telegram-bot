defmodule Telegram.Types.Message.Sticker do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2]

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.User.input_type,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.Chat.input_type,
    optional(String.t) => Telegram.Types.User.input_type,
    optional(String.t) => Telegram.Types.Chat.input_type,
    optional(String.t) => integer,
    optional(String.t) => integer,
    optional(String.t) => Telegram.Types.Message.input_type,
    required(String.t) => Telegram.Types.Sticker.input_type
  }

  @type t :: %__MODULE__{
              message_id:               integer,
              from:                     Telegram.Types.User.t | nil,
              date:                     integer,
              chat:                     Telegram.Types.Chat.t | nil,
              forward_from:             Telegram.Types.User.t | nil,
              forward_from_chat:        Telegram.Types.Chat.t | nil,
              forward_from_message_id:  integer | nil,
              forward_date:             integer | nil,
              reply_to_message:         Telegram.Types.Message.t | nil,
              sticker:                  Telegram.Types.Sticker.t}

  defstruct message_id:               0,
            from:                     nil,
            date:                     0,
            chat:                     nil,
            forward_from:             nil,
            forward_from_chat:        nil,
            forward_from_message_id:  nil,
            forward_date:             nil,
            reply_to_message:         nil,
            sticker:                  %Telegram.Types.Sticker{}

  @doc """
  Creates a Message struct from a map object.

  This requires the presence of "message_id" and "date",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message
  map to a Message struct.

  ## Examples

      iex> Telegram.Types.Message.Sticker.from_map(%{ "message_id" => 5, "date" => 0, "sticker" => %{ "file_id" => 6, "width" => 1, "height" => 1 } })
      {:ok,
        %Telegram.Types.Message.Sticker{
          message_id: 5,
          date: 0,
          sticker: %Telegram.Types.Sticker{
            file_id: 6,
            width: 1,
            height: 1
          }
        }
      }

      iex> Telegram.Types.Message.Sticker.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "message_id" => message_id,
    "date" => date,
    "sticker" => sticker,
  }=map) do
    {:ok, %__MODULE__{
      message_id:               message_id,
      from:                     to_struct(map["from"], Telegram.Types.User),
      date:                     date,
      chat:                     to_struct(map["chat"], Telegram.Types.Chat),
      forward_from:             to_struct(map["forward_from"], Telegram.Types.User),
      forward_from_chat:        to_struct(map["forward_from_chat"], Telegram.Types.Chat),
      forward_from_message_id:  map["forward_from_message_id"],
      forward_date:             map["forward_date"],
      reply_to_message:         to_struct(map["reply_to_message"], Telegram.Types.Message),
      sticker:                  to_struct(sticker, Telegram.Types.Sticker)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Message.Sticker.from_map!(%{ "message_id" => 5, "date" => 0, "sticker" => %{ "file_id" => 6, "width" => 1, "height" => 1 } })
      %Telegram.Types.Message.Sticker{
        message_id: 5,
        date: 0,
        sticker: %Telegram.Types.Sticker{
          file_id: 6,
          width: 1,
          height: 1
        }
      }

      iex> Telegram.Types.Message.from_map!(%{})
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
