defmodule Telegram.Webhook do

  @type t :: %__MODULE__{
    url:              String.t | nil,
    certificate_path: String.t | nil,
    max_connections:  integer | nil,
    allowed_updates: [String.t] | nil
  }

  defstruct url:              nil,
            certificate_path: nil,
            max_connections:  nil,
            allowed_updates:  nil

  ### Public

  def init(map) when is_map(map) do
    map
    |> Enum.into([])
    |> init
  end
  def init([url: url]=keyword) when is_list(keyword) do
    if Keyword.keyword?(keyword) do
      cert_path =
        case Keyword.get(keyword, "certificate_path") do
          nil ->
            nil

          path ->
            %FormData.File{path: path}
        end

      {:ok,
        %__MODULE__{
          url:              url,
          certificate_path: cert_path,
          max_connections:  Keyword.get(keyword, "max_connections"),
          allowed_updates:  Keyword.get(keyword, "allowed_updates")
        }
      }
    else
      {:error, %Telegram.Error{message: "Invalid Webhook data"}}
    end
  end

  def set_webhook(%Telegram{}=telegram, %__MODULE__{}=webhook) do
    telegram
    |> Telegram.Util.url("setWebhook")
    |> Telegram.Util.make_request(to_multipart(webhook))
    |> parse_response
    |> marshal_response
  end

  ### Private

  defp to_multipart(%__MODULE__{}=webhook) do
    with {:ok, payload} <- FormData.create(webhook, :multipart) do
      {:ok,
        [
          payload: payload,
          headers: [
            {"Content-Type", "multipart/form-data"},
            {"Accept", "application/json"}
          ]
        ]
      }
    end
  end
  defp to_multipart(_) do
    {:error, %Telegram.Error{message: "Invalid Webhook data"}}
  end
end
