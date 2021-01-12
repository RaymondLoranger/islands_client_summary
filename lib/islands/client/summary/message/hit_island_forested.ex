defmodule Islands.Client.Summary.Message.HitIslandForested do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.Summary.{Island, Point}
  alias Islands.Client.State
  alias Islands.Tally

  @spec message(State.t()) :: ANSI.ansilist()
  def message(%State{
        player_id: player_id,
        tally: %Tally{
          request: {:guess_coord, player_id, row, col},
          response: {:hit, island_type, _win_status}
        }
      }) do
    [
      :dark_green_background,
      :light_white,
      "Your guess #{Point.format(row, col)} ",
      "➔ #{Island.format(island_type)} forested."
    ]
  end

  def message(%State{
        tally: %Tally{
          request: {:guess_coord, _player_id, row, col},
          response: {:hit, island_type, _win_status}
        }
      }) do
    [
      :dark_green_background,
      :light_white,
      "Opponent's guess #{Point.format(row, col)} ",
      "➔ #{Island.format(island_type)} forested."
    ]
  end
end
