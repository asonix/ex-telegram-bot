defmodule Telegram.Types.Update.Message do

  import Telegram.Util, only: [to_struct: 2]

  @type t :: %__MODULE__{
    update_id:  integer,
    message:    Telegram.Types.Message.t | nil
  }

  defstruct update_id:  0,
            message:    nil

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => Telegram.Types.Message.input_type
  }

  @type output_type :: {:ok, Telegram.Types.Message.t} |
                        {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type 
  def from_map(%{
    "update_id" => update_id,
    "message" => message
  }) do
    {:ok,
      %__MODULE__{
        update_id: update_id,
        message: to_struct(message, Telegram.Types.Message)
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end
end
