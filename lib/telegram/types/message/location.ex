defmodule Telegram.Types.Message.Location do
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
    optional(String.t) => Telegram.Types.Location.input_type
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
              location:                 Telegram.Types.Location.t}

  defstruct message_id:               0,
            from:                     nil,
            date:                     0,
            chat:                     nil,
            forward_from:             nil,
            forward_from_chat:        nil,
            forward_from_message_id:  nil,
            forward_date:             nil,
            reply_to_message:         nil,
            location:                 %Telegram.Types.Location{}

  @doc """
  Creates a Message struct from a map object.

  This requires the presence of "message_id" and "date",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message
  map to a Message struct.

  ## Examples

      iex> Telegram.Types.Message.Location.from_map(%{ "message_id" => 5, "date" => 0, "location" => %{ "longitude" => 1.0, "latitude" => 1.0 } })
      {:ok,
        %Telegram.Types.Message.Location{
          message_id: 5,
          date: 0,
          location: %Telegram.Types.Location{
            longitude: 1.0,
            latitude: 1.0
          }
        }
      }

      iex> Telegram.Types.Message.Location.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{
    "message_id" => message_id,
    "date" => date,
    "location" => location
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
      location:                 to_struct(location, Telegram.Types.Location)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Message.Location.from_map!(%{ "message_id" => 5, "date" => 0, "location" => %{ "longitude" => 1.0, "latitude" => 1.0 } })
      %Telegram.Types.Message.Location{
        message_id: 5,
        date: 0,
        location: %Telegram.Types.Location{
          longitude: 1.0,
          latitude: 1.0
        }
      }

      iex> Telegram.Types.Message.Location.from_map!(%{})
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
