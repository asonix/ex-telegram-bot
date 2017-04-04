defmodule Telegram.Types.WebhookInfo do

  @type t :: %__MODULE__{
    url:                    String.t,
    has_custom_certificate: boolean,
    pending_update_count:   integer,
    last_error_date:        integer | nil,
    last_error_message:     String.t | nil,
    max_connections:        integer | nil,
    allowed_updates:        [String.t]
  }

  defstruct url: "",
            has_custom_certificate: false,
            pending_update_count:   0,
            last_error_date:        nil,
            last_error_message:     nil,
            max_connections:        nil,
            allowed_updates:        []

  @type input_type :: %{
    required(String.t) => String.t,
    required(String.t) => boolean,
    required(String.t) => integer,
    optional(String.t) => integer,
    optional(String.t) => String.t,
    optional(String.t) => integer,
    optional(String.t) => [String.t]
  }

  @type output_type :: {:ok, t} | {:error, Telegram.Error.t}

  @doc """
  ## Examples

      iex> Telegram.Types.WebhookInfo.from_map(%{"url" => "https://example.com/telegram", "has_custom_certificate" => false, "pending_update_count" => 0})
      {:ok,
        %Telegram.Types.WebhookInfo{
          url: "https://example.com/telegram",
          has_custom_certificate: false,
          pending_update_count: 0
        }
      }

      iex> Telegram.Types.WebhookInfo.from_map(%{})
      {:error, %Telegram.Error{message: "Invalid WebhookInfo data"}}

  """
  @spec from_map(input_type) :: output_type
  def from_map(%{
    "url" => url,
    "has_custom_certificate" => has_custom_certificate,
    "pending_update_count" => pending_update_count
  }=map) do
    {:ok,
      %__MODULE__{
        url:                    url,
        has_custom_certificate: has_custom_certificate,
        pending_update_count:   pending_update_count,
        last_error_date:        Map.get(map, "last_error_date"),
        last_error_message:     Map.get(map, "last_error_message"),
        max_connections:        Map.get(map, "max_connections"),
        allowed_updates:        Map.get(map, "allowed_updates", [])
      }
    }
  end
  def from_map(_) do
    {:error, %Telegram.Error{message: "Invalid WebhookInfo data"}}
  end
end
