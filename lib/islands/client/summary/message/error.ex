defmodule Islands.Client.Summary.Message.Error do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{tally: %Tally{response: {:error, reason}}}) do
    [
      :free_speech_red_background,
      :light_white,
      "ERROR: #{reason |> Atom.to_string() |> String.replace("_", " ")}."
    ]
  end
end
