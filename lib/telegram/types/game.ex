defmodule Telegram.Types.Game do
  @moduledoc """
  This struct represents game data provided by Telegram's bot API
  """

  import Telegram.Util, only: [{:to_struct, 2}, {:to_structs, 2}]

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => String.t,
    optional(String.t) => [Telegram.Types.PhotoSize.input_type],
    optional(String.t) => String.t,
    optional(String.t) => [Telegram.Types.MessageEntity.input_type],
    optional(String.t) => Telegram.Types.Animation.input_type
  }

  @type t :: %__MODULE__{
              title:          String.t,
              description:    String.t,
              photo:          [Telegram.Types.PhotoSize.t],
              text:           String.t | nil,
              text_entities:  [Telegram.Types.MessageEntity.t],
              animation:      Telegram.Types.Animation.t | nil}

  defstruct title:          "",
            description:    "",
            photo:          [],
            text:           nil,
            text_entities:  [],
            animation:      nil

  @doc """
  Creates a Game struct from a map object.

  This requires the presence of "title" and "text",
  since Telegram provides those fields through it's API,
  there shouldn't be any issues directly converting a game
  map to a Game struct.

  ## Examples

      iex> Telegram.Types.Game.from_map(%{ "title" => "Some Title", "description" => "hey", "photo" => []})
      {:ok, %Telegram.Types.Game{title: "Some Title", description: "hey", photo: []}}

      iex> Telegram.Types.Game.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid Game data"}}

  """
  @spec from_map(input_type) :: {:ok, t} | {:error, Telegram.Error.t}
  def from_map(%{ "title" => title, "description" => description }=map) do
    {:ok, %__MODULE__{
      title:          title,
      description:    description,
      photo:          to_structs(map["photo"], Telegram.Types.PhotoSize),
      text:           map["text"],
      text_entities:  to_structs(map["text_entities"], Telegram.Types.MessageEntity),
      animation:      to_struct(map["animation"], Telegram.Types.Animation)
    }}
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Game data"}}
  end

  @doc """
  Creates a Game struct from a map object (dangerous version).

  ## Examples

      iex> Telegram.Types.Game.from_map!(%{ "title" => "Some Title", "description" => "hey", "photo" => []})
      %Telegram.Types.Game{title: "Some Title", description: "hey", photo: []}

      iex> Telegram.Types.Game.from_map!(%{})
      ** (Telegram.Error) Invalid Game data

  """
  @spec from_map!(input_type) :: t
  def from_map!(map) do
    case from_map(map) do
      {:ok, game} ->
        game
      {:error, error} ->
        raise error
    end
  end
end
