defmodule Telegram.Types.Update do

  @type t :: Telegram.Types.Update.Message.t |
             Telegram.Types.Update.EditedMessage.t |
             Telegram.Types.Update.ChannelPost.t |
             Telegram.Types.Update.EditedChannelPost.t |
             Telegram.Types.Update.InlineQuery.t |
             Telegram.Types.Update.ChosenInlineResult.t |
             Telegram.Types.Update.CallbackQuery.t

  @type input_type :: Telegram.Types.Update.Message.input_type |
                      Telegram.Types.Update.EditedMessage.input_type |
                      Telegram.Types.Update.ChannelPost.input_type |
                      Telegram.Types.Update.EditedChannelPost.input_type |
                      Telegram.Types.Update.InlineQuery.input_type |
                      Telegram.Types.Update.ChosenInlineResult.input_type |
                      Telegram.Types.Update.CallbackQuery.input_type

  @type output_type :: Telegram.Types.Update.Message.output_type |
                       Telegram.Types.Update.EditedMessage.output_type |
                       Telegram.Types.Update.ChannelPost.output_type |
                       Telegram.Types.Update.EditedChannelPost.output_type |
                       Telegram.Types.Update.InlineQuery.output_type |
                       Telegram.Types.Update.ChosenInlineResult.output_type |
                       Telegram.Types.Update.CallbackQuery.output_type

  @doc """
  ## Examples

      iex> Telegram.Types.Update.from_map(%{ "update_id" => 5, "message" => %{ "message_id" => 6, "date" => 0, "text" => "hey" } })
      {:ok,
        %Telegram.Types.Update.Message{
          update_id: 5,
          message: %Telegram.Types.Message.Text{
            message_id: 6,
            date: 0,
            text: "hey"
          }
        }
      }
  """
  @spec from_map(input_type) :: output_type
  def from_map(%{"update_id" => _}=map) do
    cond do
      not is_nil(Map.get(map, "message")) ->
        Telegram.Types.Update.Message.from_map(map)
      not is_nil(Map.get(map, "edited_message")) ->
        Telegram.Types.Update.EditedMessage.from_map(map)
      not is_nil(Map.get(map, "channel_post")) ->
        Telegram.Types.Update.ChannelPost.from_map(map)
      not is_nil(Map.get(map, "edited_channel_post")) ->
        Telegram.Types.Update.EditedChannelPost.from_map(map)
      not is_nil(Map.get(map, "inline_query")) ->
        Telegram.Types.Update.InlineQuery.from_map(map)
      not is_nil(Map.get(map, "chosen_inline_result")) ->
        Telegram.Types.Update.ChosenInlineResult.from_map(map)
      not is_nil(Map.get(map, "callback_query")) ->
        Telegram.Types.Update.CallbackQuery.from_map(map)
      true ->
        {:error, %Telegram.Error{message: "Invalid Update data"}}
    end
  end
  def from_map(_), do: {:error, %Telegram.Error{message: "Invalid Update data"}}
end
