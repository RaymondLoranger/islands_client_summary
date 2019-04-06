defmodule Islands.Client.Summary.Message.Stopping do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State
  alias Islands.Tally

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{tally: %Tally{request: {:stop, _player_id}}}) do
    [
      :dark_green_background,
      :light_white,
      "Stopping the game..."
    ]
  end
end
