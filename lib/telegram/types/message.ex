defmodule Telegram.Types.Message do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

  import Telegram.Util, only: [to_struct: 2, to_structs: 2]

  @type input_type :: %{
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.User.input_type,
    required(String.t) => integer,
    optional(String.t) => Telegram.Types.Chat.input_type,
    optional(String.t) => Telegram.Types.User.input_type,
    optional(String.t) => Telegram.Types.Chat.input_type,
    optional(String.t) => integer,
    optional(String.t) => integer,
    optional(String.t) => __MODULE__.input_type,
    optional(String.t) => integer,
    optional(String.t) => String.t,
    optional(String.t) => [Telegram.Types.Chat.input_type],
    optional(String.t) => Telegram.Types.Audio.input_type,
    optional(String.t) => Telegram.Types.Document.input_type,
    optional(String.t) => Telegram.Types.Game.input_type,
    optional(String.t) => [Telegram.Types.PhotoSize.input_type],
    optional(String.t) => Telegram.Types.Sticker.input_type,
    optional(String.t) => Telegram.Types.Video.input_type,
    optional(String.t) => Telegram.Types.Voice.input_type,
    optional(String.t) => String.t,
    optional(String.t) => Telegram.Contact.input_type,
    optional(String.t) => Telegram.Location.input_type,
    optional(String.t) => Telegram.Venue.input_type,
    optional(String.t) => Telegram.Types.User.input_type,
    optional(String.t) => Telegram.Types.User.input_type,
    optional(String.t) => String.t,
    optional(String.t) => [Telegram.Types.PhotoSize.input_type],
    optional(String.t) => boolean,
    optional(String.t) => boolean,
    optional(String.t) => boolean,
    optional(String.t) => boolean,
    optional(String.t) => integer,
    optional(String.t) => integer,
    optional(String.t) => __MODULE__.input_type
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
              reply_to_message:         __MODULE__.t | nil,
              edit_date:                integer | nil,
              text:                     String.t | nil,
              entities:                 [Telegram.Types.MessageEntity.t],
              audio:                    Telegram.Types.Audio.t | nil,
              document:                 Telegram.Types.Document.t | nil,
              game:                     Telegram.Types.Game.t | nil,
              photo:                    [Telegram.Types.PhotoSize.t],
              sticker:                  Telegram.Types.Sticker.t | nil,
              video:                    Telegram.Types.Video.t | nil,
              voice:                    Telegram.Types.Voice.t | nil,
              caption:                  String.t | nil,
              contact:                  Telegram.Contact.t | nil,
              location:                 Telegram.Location.t | nil,
              venue:                    Telegram.Venue.t | nil,
              new_chat_member:          Telegram.Types.User.t | nil,
              left_chat_member:         Telegram.Types.User.t | nil,
              new_chat_title:           String.t | nil,
              new_chat_photo:           [Telegram.Types.PhotoSize.t],
              delete_chat_photo:        boolean,
              group_chat_created:       boolean,
              supergroup_chat_created:  boolean,
              channel_chat_created:     boolean,
              migrate_to_chat_id:       integer | nil,
              migrate_from_chat_id:     integer | nil,
              pinned_message:           __MODULE__.t | nil}

  defstruct message_id:               0,
            from:                     nil,
            date:                     0,
            chat:                     nil,
            forward_from:             nil,
            forward_from_chat:        nil,
            forward_from_message_id:  nil,
            forward_date:             nil,
            reply_to_message:         nil,
            edit_date:                nil,
            text:                     nil,
            entities:                 [],
            audio:                    nil,
            document:                 nil,
            game:                     nil,
            photo:                    [],
            sticker:                  nil,
            video:                    nil,
            voice:                    nil,
            caption:                  nil,
            contact:                  nil,
            location:                 nil,
            venue:                    nil,
            new_chat_member:          nil,
            left_chat_member:         nil,
            new_chat_title:           nil,
            new_chat_photo:           [],
            delete_chat_photo:        false,
            group_chat_created:       false,
            supergroup_chat_created:  false,
            channel_chat_created:     false,
            migrate_to_chat_id:       nil,
            migrate_from_chat_id:     nil,
            pinned_message:           nil

  @doc """
  Creates a Message struct from a map object.

  This requires the presence of "message_id" and "date",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a message
  map to a Message struct.

  ## Examples

      iex> Telegram.Types.Message.from_map(%{ "message_id" => 5, "date" => 0 })
      {:ok, %Telegram.Types.Message{message_id: 5, date: 0}}

      iex> Telegram.Types.Message.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"message_id" => message_id, "date" => date}=map) do
    {:ok, %__MODULE__{
      message_id:               message_id,
      from:                     to_struct(map["from"], Telegram.Types.User),
      date:                     date,
      chat:                     to_struct(map["chat"], Telegram.Types.Chat),
      forward_from:             to_struct(map["forward_from"], Telegram.Types.User),
      forward_from_chat:        to_struct(map["forward_from_chat"], Telegram.Types.Chat),
      forward_from_message_id:  map["forward_from_message_id"],
      forward_date:             map["forward_date"],
      reply_to_message:         to_struct(map["reply_to_message"], __MODULE__),
      edit_date:                map["edit_date"],
      text:                     map["text"],
      entities:                 to_structs(map["entities"], Telegram.Types.MessageEntity),
      audio:                    to_struct(map["audio"], Telegram.Types.Audio),
      document:                 to_struct(map["document"], Telegram.Types.Document),
      game:                     to_struct(map["game"], Telegram.Types.Game),
      photo:                    to_structs(map["photo"], Telegram.Types.PhotoSize),
      sticker:                  to_struct(map["sticker"], Telegram.Types.Sticker),
      video:                    to_struct(map["video"], Telegram.Types.Video),
      voice:                    to_struct(map["voice"], Telegram.Types.Voice),
      caption:                  map["caption"],
      contact:                  to_struct(map["contact"], Telegram.Contact),
      location:                 to_struct(map["location"], Telegram.Location),
      venue:                    to_struct(map["venue"], Telegram.Venue),
      new_chat_member:          to_struct(map["new_chat_member"], Telegram.Types.User),
      left_chat_member:         to_struct(map["left_chat_member"], Telegram.Types.User),
      new_chat_title:           map["new_chat_title"],
      new_chat_photo:           to_structs(map["new_chat_photo"], Telegram.Types.PhotoSize),
      delete_chat_photo:        Map.get(map, "delete_chat_photo", false),
      group_chat_created:       Map.get(map, "group_chat_created", false),
      supergroup_chat_created:  Map.get(map, "supergroup_chat_created", false),
      channel_chat_created:     Map.get(map, "channel_chat_created", false),
      migrate_to_chat_id:       map["migrate_to_chat_id"],
      migrate_from_chat_id:     map["migrate_from_chat_id"],
      pinned_message:           to_struct(map["pinned_message"], __MODULE__)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Message.from_map!(%{ "message_id" => 5, "date" => 0 })
      %Telegram.Types.Message{message_id: 5, date: 0}

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
