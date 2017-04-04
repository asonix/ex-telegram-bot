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
      {:ok, from_keyword(keyword)}
    else
      {:error, %Telegram.Error{message: "Invalid Webhook data"}}
    end
  end

  def set_webhook(%Telegram{}=telegram, %__MODULE__{}=webhook) do
    telegram
    |> Telegram.Util.url("setWebhook")
    |> Telegram.Util.make_request(to_multipart(webhook))
    |> handle_response
  end
  def set_webhook(_telegram, %__MODULE__{}) do
    {:error,
      %Telegram.Error{
        message: "Telegram.Webhook struct is required for setting webhooks"}}
  end
  def set_webhook(%Telegram{}, _update) do
    {:error,
      %Telegram.Error{
        message: "Telegram struct is required for setting webhooks"}}
  end
  def set_webhook(_telegram, _update) do
    {:error,
      [%Telegram.Error{
        message: "Telegram.Webhook struct is required for setting webhooks"},
       %Telegram.Error{
         message: "Telegram struct is required for setting webhooks"}]}
  end

  def delete_webhook(%Telegram{}=telegram) do
    telegram
    |> Telegram.Util.url("deleteWebhook")
    |> Telegram.Util.make_request(headers: [{"Accept", "application/json"}])
    |> handle_response
  end
  def delete_webhook(_telegram) do
    {:error,
      %Telegram.Error{
        message: "Telegram struct is required for deleting webhooks"}}
  end

  def get_webhook_info(%Telegram{}=telegram) do
    telegram
    |> Telegram.Util.url("getWebhookInfo")
    |> Telegram.Util.make_request(headers: [{"Accept", "application/json"}])
    |> parse_response
    |> marshal_webhookinfo
  end

  def marshal_webhookinfo({:ok, map}) when is_map(map) do
    Telegram.Types.WebhookInfo.from_map(map)
  end
  def marshal_webhookinfo({:error, _}=err), do: err

  ### Private

  defp handle_response({:ok, HTTPoison.Response{
    status_code: code
  }}) when code >= 200 and code < 300 do
    {:ok, code}
  end
  defp handle_response({:ok, HTTPoison.Response{status_code: code}}) do
    {:error, %Telegram.Error{message: "Invalid Code: #{code}"}}
  end
  defp handle_response({:error, _}=err), do: err
  
  defp from_keyword([url: url]=keyword) do
    cert_path =
      case Keyword.get(keyword, "certificate_path") do
        nil ->
          nil

        path ->
          %FormData.File{path: path}
      end

    %__MODULE__{
      url:              url,
      certificate_path: cert_path,
      max_connections:  Keyword.get(keyword, "max_connections"),
      allowed_updates:  Keyword.get(keyword, "allowed_updates")
    }
  end

  defp parse_response({:ok,
    %HTTPoison.Response{
      status_code: code,
      body: body
    }
  }) when code >= 200 and code < 300 do
    Poison.decode(body)
  end
  defp parse_response({:ok, %HTTPoison.Response{status_code: code}}) do
    {:error, %Telegram.Error{message: "Invalid Code: #{code}"}}
  end
  defp parse_response({:error, _}=err), do: err

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
