defmodule Telegram.Types.Update.InlineQuery do

  import Telegram.Util, only: [to_struct: 2]

  @type t :: %__MODULE__{
    update_id:    integer,
    inline_query: Telegram.Types.InlineQuery.t | nil
  }

  defstruct update_id:    0,
            inline_query: nil

  @type input_type :: %{
    required(String.t) => integer,
    required(String.t) => Telegram.Types.InlineQuery.input_type
  }

  @type output_type :: {:ok, Telegram.Types.InlineQuery.t} |
                        {:error, Telegram.Error.t}

  @spec from_map(input_type) :: output_type 
  def from_map(%{
    "update_id" => update_id,
    "inline_query" => inline_query
  }) do
    {:ok,
      %__MODULE__{
        update_id:    update_id,
        inline_query: to_struct(inline_query, Telegram.Types.InlineQuery)
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid Update data"}}
  end
end
