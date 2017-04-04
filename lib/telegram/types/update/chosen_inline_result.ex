defmodule Telegram.Types.Update.ChosenInlineResult do

  import Telegram.Util, only: [to_struct: 2]

  @type t :: %__MODULE__{
    update_id:            integer,
    chosen_inline_result: Telegram.Types.ChosenInlineResult.t | nil
  }

  defstruct update_id:            0,
            chosen_inline_result: nil

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => Telegram.Types.ChosenInlineResult.input_type
  }

  @type output_type :: {:ok, Telegram.Types.ChosenInlineResult.t} |
                        {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type 
  def from_map(%{
    "update_id" => update_id,
    "chosen_inline_result" => chosen_inline_result
  }) do
    {:ok,
      %__MODULE__{
        update_id:            update_id,
        chosen_inline_result: to_struct(chosen_inline_result, Telegram.Types.ChosenInlineResult)
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end
end
