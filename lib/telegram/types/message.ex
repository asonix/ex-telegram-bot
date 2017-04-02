defmodule Telegram.Types.Message do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

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
    optional(String.t) => [Telegram.Types.MessageEntity.input_type],
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

  # iex> Telegram.Types.Message.from_map(%{ "message_id" => 5, "date" => 0 })
  # {:ok, %Telegram.Types.Message{message_id: 5, date: 0}}

      iex> Telegram.Types.Message.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Message data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"message_id" => _, "date" => _}=map) do
    cond do
      not is_nil(Map.get(map, "audio")) ->
        Telegram.Types.Message.Audio.from_map(map)
      not is_nil(Map.get(map, "channel_chat_created")) ->
        Telegram.Types.Message.ChannelChatCreated.from_map(map)
      not is_nil(Map.get(map, "migrate_to_chat_id")) ->
        Telegram.Types.Message.ChatMigration.from_map(map)
      not is_nil(Map.get(map, "contact")) ->
        Telegram.Types.Message.Contact.from_map(map)
      not is_nil(Map.get(map, "delete_chat_photo")) ->
        Telegram.Types.Message.DeleteChatPhoto.from_map(map)
      not is_nil(Map.get(map, "document")) ->
        Telegram.Types.Message.Document.from_map(map)
      not is_nil(Map.get(map, "game")) ->
        Telegram.Types.Message.Game.from_map(map)
      not is_nil(Map.get(map, "group_chat_created")) ->
        Telegram.Types.Message.GroupChatCreated.from_map(map)
      not is_nil(Map.get(map, "left_chat_member")) ->
        Telegram.Types.Message.LeftChatMember.from_map(map)
      not is_nil(Map.get(map, "location")) ->
        Telegram.Types.Message.Location.from_map(map)
      not is_nil(Map.get(map, "new_chat_member")) ->
        Telegram.Types.Message.NewChatMember.from_map(map)
      not is_nil(Map.get(map, "new_chat_photo")) ->
        Telegram.Types.Message.NewChatPhoto.from_map(map)
      not is_nil(Map.get(map, "new_chat_title")) ->
        Telegram.Types.Message.NewChatTitle.from_map(map)
      not is_nil(Map.get(map, "photo")) ->
        Telegram.Types.Message.PhotoSize.from_map(map)
      not is_nil(Map.get(map, "pinned_message")) ->
        Telegram.Types.Message.PinnedMessage.from_map(map)
      not is_nil(Map.get(map, "sticker")) ->
        Telegram.Types.Message.Sticker.from_map(map)
      not is_nil(Map.get(map, "supergroup_chat_created")) ->
        Telegram.Types.Message.SupergroupChatCreated.from_map(map)
      not is_nil(Map.get(map, "text")) ->
        Telegram.Types.Message.Text.from_map(map)
      not is_nil(Map.get(map, "venue")) ->
        Telegram.Types.Message.Venue.from_map(map)
      not is_nil(Map.get(map, "video")) ->
        Telegram.Types.Message.Video.from_map(map)
      not is_nil(Map.get(map, "voice")) ->
        Telegram.Types.Message.Voice.from_map(map)
      true ->
        {:error, %Telegram.Error{message: "Invalid Message data"}}
    end
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Message data"}}
  end

  @doc """
  Creates a Message struct from a map object (dangerous version).

  ## Examples

  # iex> Telegram.Types.Message.from_map!(%{ "message_id" => 5, "date" => 0 })
  # %Telegram.Types.Message{message_id: 5, date: 0}

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
