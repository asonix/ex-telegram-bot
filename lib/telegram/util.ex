defmodule Telegram.Util do
  @moduledoc """
  Helper functions used throughout the Telegram types
  """

  @spec to_struct(map, atom) :: map
  def to_struct(nil, _) do
    nil
  end
  def to_struct(map, module) do
    case module.from_map(map) do
      {:ok, item} ->
        item
      {:error, _} ->
        nil
    end
  end

  @spec to_structs(map, atom) :: [map]
  def to_structs(nil, _) do
    []
  end
  def to_structs(list, module) do
    list
    |> Enum.map(fn item ->
      case module.from_map(item) do
        {:ok, item} ->
          item
        {:error, _} ->
          nil
      end
    end)
    |> Enum.filter(fn item ->
      not is_nil(item)
    end)
  end

  def url(%Telegram{token: token}, url) when not is_nil(token) do
    {:ok, "https://api.telegram.org/bot#{token}/#{url}"}
  end
  def url(_, _) do
    {:error, %Telegram.Error{message: "Invalid token"}}
  end

  def make_request({:ok, url}, {:ok, [payload: payload, headers: headers]}) do
    HTTPoison.post(url, payload, headers)
  end
  def make_request({:error, err1}, {:error, err2}), do: {:error, [err1, err2]}
  def make_request({:error, _}=err, _), do: err
  def make_request(_, {:error, _}=err), do: err
end
