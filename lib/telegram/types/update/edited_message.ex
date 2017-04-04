defmodule Telegram.Types.Update.EditedMessage do

  import Telegram.Util, only: [to_struct: 2]

  @type t :: %__MODULE__{
    update_id:      integer,
    edited_message: Telegram.Types.Message.t | nil
  }

  defstruct update_id:      0,
            edited_message: nil

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => Telegram.Types.Message.input_type
  }

  @type output_type :: {:ok, Telegram.Types.Message.t} |
                        {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type 
  def from_map(%{
    "update_id" => update_id,
    "edited_message" => edited_message
  }) do
    {:ok,
      %__MODULE__{
        update_id:      update_id,
        edited_message: to_struct(edited_message, Telegram.Types.Message)
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end
end
