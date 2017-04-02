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
end
