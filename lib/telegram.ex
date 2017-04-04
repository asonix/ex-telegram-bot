defmodule Telegram do

  @type t :: %__MODULE__{
                token: String.t | nil}

  defstruct token: nil

  def init(token) when is_binary(token) do
    {:ok, %__MODULE__{token: token}}
  end
  def init(_) do
    {:error, %Telegram.Error{message: "Token not provided"}}
  end
end
