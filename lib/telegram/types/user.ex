defmodule Telegram.Types.User do
  @moduledoc """
  This struct represents user data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => String.t
  }

  @type t :: %__MODULE__{
              id:         integer,
              first_name: String.t,
              last_name:  String.t | nil,
              username:   String.t | nil}

  defstruct id:         0,
            first_name: "",
            last_name:  nil,
            username:   nil

  @doc """
  Creates a User struct from a map object.

  This requires the presence of "id" and "first_name",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a user
  map to a User struct.

  ## Examples

      iex> Telegram.Types.User.from_map(%{ "id" => 5, "first_name" => "John" })
      {:ok, %Telegram.Types.User{id: 5, first_name: "John"}}

      iex> Telegram.Types.User.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid User data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{ "id" => id, "first_name" => first_name }=map) do
    {:ok, %__MODULE__{
      id:         id,
      first_name: first_name,
      last_name:  Map.get(map, "last_name"),
      username:   Map.get(map, "username")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid User data"}}
  end

  @doc """
  Creates a User struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.User.from_map!(%{ "id" => 5, "first_name" => "John" })
      %Telegram.Types.User{id: 5, first_name: "John"}

      iex> Telegram.Types.User.from_map!(%{})
      ** (Telegram.Error) Invalid User data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, user} ->
        user
      {:error, error} ->
        raise error
    end
  end
end
