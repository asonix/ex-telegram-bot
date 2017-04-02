defmodule Telegram.Error do
  @type t :: %__MODULE__{
              message: String.t}

  defexception message: "TODO: override this message"

  @moduledoc """
  Generic error raised when a struct cannot be initialized.
  """
end
