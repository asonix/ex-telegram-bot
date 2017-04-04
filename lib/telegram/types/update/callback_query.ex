defmodule Telegram.Types.Update.CallbackQuery do

  import Telegram.Util, only: [to_struct: 2]

  @type t :: %__MODULE__{
    update_id:      integer,
    callback_query: Telegram.Types.CallbackQuery.t | nil
  }

  defstruct update_id:      0,
            callback_query: nil

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => Telegram.Types.CallbackQuery.input_type
  }

  @type output_type :: {:ok, Telegram.Types.CallbackQuery.t} |
                        {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type
  def from_map(%{
    "update_id" => update_id,
    "callback_query" => callback_query
  }) do
    {:ok,
      %__MODULE__{
        update_id:      update_id,
        callback_query: to_struct(callback_query, Telegram.Types.CallbackQuery)
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end
end
