defmodule Telegram.Types.Message do
  @moduledoc """
  This struct represents message data provided by Telegram's bot API
  """

  @type input_type :: Telegram.Types.Message.Audio.input_type |
                      Telegram.Types.Message.ChannelChatCreated.input_type |
                      Telegram.Types.Message.ChatMigration.input_type |
                      Telegram.Types.Message.Contact.input_type |
                      Telegram.Types.Message.DeleteChatPhoto.input_type |
                      Telegram.Types.Message.Document.input_type |
                      Telegram.Types.Message.Game.input_type |
                      Telegram.Types.Message.GroupChatCreated.input_type |
                      Telegram.Types.Message.LeftChatMember.input_type |
                      Telegram.Types.Message.Location.input_type |
                      Telegram.Types.Message.NewChatMember.input_type |
                      Telegram.Types.Message.NewChatPhoto.input_type |
                      Telegram.Types.Message.NewChatTitle.input_type |
                      Telegram.Types.Message.PhotoSize.input_type |
                      Telegram.Types.Message.PinnedMessage.input_type |
                      Telegram.Types.Message.Sticker.input_type |
                      Telegram.Types.Message.SupergroupChatCreated.input_type |
                      Telegram.Types.Message.Text.input_type |
                      Telegram.Types.Message.Venue.input_type |
                      Telegram.Types.Message.Video.input_type |
                      Telegram.Types.Message.Voice.input_type

  @type t :: Telegram.Types.Message.Audio.t |
             Telegram.Types.Message.ChannelChatCreated.t |
             Telegram.Types.Message.ChatMigration.t |
             Telegram.Types.Message.Contact.t |
             Telegram.Types.Message.DeleteChatPhoto.t |
             Telegram.Types.Message.Document.t |
             Telegram.Types.Message.Game.t |
             Telegram.Types.Message.GroupChatCreated.t |
             Telegram.Types.Message.LeftChatMember.t |
             Telegram.Types.Message.Location.t |
             Telegram.Types.Message.NewChatMember.t |
             Telegram.Types.Message.NewChatPhoto.t |
             Telegram.Types.Message.NewChatTitle.t |
             Telegram.Types.Message.PhotoSize.t |
             Telegram.Types.Message.PinnedMessage.t |
             Telegram.Types.Message.Sticker.t |
             Telegram.Types.Message.SupergroupChatCreated.t |
             Telegram.Types.Message.Text.t |
             Telegram.Types.Message.Venue.t |
             Telegram.Types.Message.Video.t |
             Telegram.Types.Message.Voice.t

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
