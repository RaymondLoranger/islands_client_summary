defmodule Islands.Client.Summary.Message.Other do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{tally: %Tally{response: response, request: request}}) do
    [
      :dark_green_background,
      :light_white,
      "Unknown response...",
      :reset,
      "\n#{inspect(request)} ➔ ",
      "\n#{inspect(response)}"
    ]
  end
end
