defmodule Telegram.Types.ChosenInlineResult do
  @type t :: %{}

  @type input_type :: any
  @type output_type :: {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type
  def from_map(_) do
    {:error, %Telegram.Error{message: "Not implemented"}}
  end

  @spec from_map!(input_type) :: no_return
  def from_map!(_), do: raise %Telegram.Error{message: "Not implemented"}
end
