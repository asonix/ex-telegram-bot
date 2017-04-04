defmodule Telegram.Update do

  @type t :: %__MODULE__{
              offset:           integer | nil,
              limit:            integer | nil,
              timeout:          integer | nil,
              allowed_updates:  [String.t] | nil}

  defstruct offset:           nil,
            limit:            nil,
            timeout:          100,
            allowed_updates:  nil

  ### Public

  def init(map) when is_map(map) do
    map
    |> Enum.into([])
    |> init
  end
  def init(keyword) when is_list(keyword) do
    if Keyword.keyword?(keyword) do
      {:ok, from_keyword(keyword)}
    else
      {:error, %Telegram.Error{message: "Invalid init type"}}
    end
  end

  # Got that railway-oriented programming
  def get_updates(%Telegram{}=telegram, %__MODULE__{}=update) do
    telegram
    |> Telegram.Util.url("getUpdates")
    |> Telegram.Util.make_request(to_json(update))
    |> parse_response
    |> marshal_response
  end
  def get_updates(_telegram, %__MODULE__{}) do
    {:error,
      %Telegram.Error{
        message: "Telegram struct is required for getting updates"
      }
    }
  end
  def get_updates(%Telegram{}, _update) do
    {:error,
      %Telegram.Error{
        message: "Telegram.Update struct is required for getting updates"}}
  end
  def get_updates(_telegram, _update) do
    {:error,
      [%Telegram.Error{
        message: "Telegram.Update struct is required for getting updates"},
       %Telegram.Error{
         message: "Telegram struct is required for getting updates"}]}
  end

  def marshal_update(update) when is_map(update) do
    Telegram.Types.Update.from_map(update)
  end
  def marshal_update(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end

  ### Private

  defp from_keyword(keyword) do
    %__MODULE__{
      offset:           Keyword.get(keyword, :offset),
      limit:            Keyword.get(keyword, :limit),
      timeout:          Keyword.get(keyword, :timeout, 100),
      allowed_updates:  Keyword.get(keyword, :allowed_updates)
    }
  end

  defp to_json(%__MODULE__{}=update) do
    with {:ok, json} <- Poison.encode(update) do
      {:ok,
        [
          payload: json,
          headers: [
            {"Content-Type", "application/json"},
            {"Accept", "application/json"}
          ]
        ]
      }
    end
  end
  defp to_json(_) do
    {:error,
      %Telegram.Error{message: "Invalid Telegram.Update struct"}
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

  defp marshal_response({:ok, list}) do
    list
    |> Enum.map(fn item ->
      case marshal_update(item) do
        {:ok, map} ->
          map
        _ ->
          nil
      end
    end)
    |> Enum.filter(fn item ->
      not is_nil(item)
    end)
  end
  defp marshal_response({:error, _}=err), do: err
end
