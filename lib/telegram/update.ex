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

  @type input_type :: %{
                      optional(atom) => integer,
                      optional(atom) => integer,
                      optional(atom) => integer,
                      optional(atom) => [String.t]} |
                      []

  @type output_type :: {:ok, t} | {:error, Telegram.Error.t}

  @doc """
  ## Examples

      iex> Telegram.Update.init()
      {:ok, %Telegram.Update{timeout: 100}}

      iex> Telegram.Update.init(timeout: 0)
      {:ok, %Telegram.Update{timeout: 0}}

      iex> Telegram.Update.init(%{timeout: 0})
      {:ok, %Telegram.Update{timeout: 0}}

  """
  @spec init() :: output_type
  def init(), do: init(%{})
  @spec init(input_type) :: output_type
  def init(map) when is_map(map) do
    map
    |> Map.to_list
    |> init
  end
  def init(keyword) when is_list(keyword) do
    if Keyword.keyword?(keyword) do
      {:ok, from_keyword(keyword)}
    else
      {:error, %Telegram.Error{message: "Invalid init type"}}
    end
  end

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

  @doc """
  ## Examples

      iex> Telegram.Update.marshal_update(%{"update_id" => 5, "message" => %{ "message_id" => 6, "date" => 0, "text" => "hey" } })
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
