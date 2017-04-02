defmodule Telegram.Types.Contact do
  @moduledoc """
  This struct represents contact data provided by Telegram's bot API
  """

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => String.t,
    optional(String.t) => String.t,
    optional(String.t) => integer
  }

  @type t :: %__MODULE__{
              phone_number: String.t,
              first_name:   String.t,
              last_name:    String.t | nil,
              user_id:      integer | nil}

  defstruct phone_number: "",
            first_name:   "",
            last_name:    nil,
            user_id:      nil

  @doc """
  Creates a Contact struct from a map object.

  This requires the presence of "phone_number" and "first_name",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a contact
  map to a Contact struct.

  ## Examples

    iex> Telegram.Types.Contact.from_map(%{ "phone_number" => "890-123-4567", "first_name" => "John" })
    {:ok, %Telegram.Types.Contact{phone_number: "890-123-4567", first_name: "John"}}

    iex> Telegram.Types.Contact.from_map(%{})
    {:error, %Telegram.Error{message: "Invalid Contact data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{"phone_number" => phone_number, "first_name" => first_name}=map) do
    {:ok, %__MODULE__{
      phone_number: phone_number,
      first_name:   first_name,
      last_name:    Map.get(map, "last_name"),
      user_id:      Map.get(map, "user_id")
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Contact data"}}
  end

  @doc """
  Creates a Contact struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Contact.from_map!(%{ "phone_number" => "890-123-4567", "first_name" => 0 })
      %Telegram.Types.Contact{phone_number: "890-123-4567", first_name: 0}

      iex> Telegram.Types.Contact.from_map!(%{})
      ** (Telegram.Error) Invalid Contact data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, contact} ->
        contact
      {:error, error} ->
        raise error
    end
  end
end
