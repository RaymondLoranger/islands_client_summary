defmodule Islands.Client.Summary.Message.MissNoneForested do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.Summary.Point
  alias Islands.Client.State
  alias Islands.Tally

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{
        player_id: player_id,
        tally: %Tally{request: {:guess_coord, player_id, row, col}}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Your guess #{Point.format(row, col)} ➔ miss."
    ]
  end

  def message(%State{
        tally: %Tally{request: {:guess_coord, _player_id, row, col}}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Opponent's guess #{Point.format(row, col)} ➔ miss."
    ]
  end
end
