defmodule MessageTest do
  use ExUnit.Case
  doctest Telegram.Types.Message

  test "Forwarded Text Message" do
    data = %{
      "message_id" => 5,
      "from" => %{
        "id" => 6,
        "first_name" => "John",
        "last_name" => "Doe",
        "username" => "@JohnDoe"
      },
      "date" => 123456789,
      "chat" => %{
        "id" => 7,
        "type" => "supergroup",
        "title" => "Bananas"
      },
      "forward_from" => %{
        "id" => 8,
        "first_name" => "Jill",
        "last_name" => "Buck",
        "username" => "@JillBuck"
      },
      "forward_from_chat" => %{
        "id" => 9,
        "type" => "group",
        "title" => "Apples"
      },
      "forward_from_message_id" => 10,
      "forward_date" => 234567890,
      "text" => "hello @CharlieDeer",
      "entities" => [
        %{
          "type" => "mention",
          "offset" => 6,
          "length" => 12,
          "user" => %{
            "id" => 10,
            "first_name" => "Some",
            "last_name" => "Dude",
            "username" => "@SomeDude"
          }
        }
      ]
    }

    expected =
      {:ok,
        %Telegram.Types.Message.Text{
          message_id: 5,
          from: %Telegram.Types.User{
            id: 6,
            first_name: "John",
            last_name: "Doe",
            username: "@JohnDoe"
          },
          date: 123456789,
          chat: %Telegram.Types.Chat.Supergroup{
            id: 7,
            title: "Bananas"
          },
          forward_from: %Telegram.Types.User{
            id: 8,
            first_name: "Jill",
            last_name: "Buck",
            username: "@JillBuck"
          },
          forward_from_chat: %Telegram.Types.Chat.Group{
            id: 9,
            title: "Apples"
          },
          forward_from_message_id: 10,
          forward_date: 234567890,
          text: "hello @CharlieDeer",
          entities: [
            %Telegram.Types.MessageEntity{
              type: "mention",
              offset: 6,
              length: 12,
              user: %Telegram.Types.User{
                id: 10,
                first_name: "Some",
                last_name: "Dude",
                username: "@SomeDude"
              }
            }
          ]
        }
      }

    assert Telegram.Types.Message.from_map(data) == expected
  end
end
