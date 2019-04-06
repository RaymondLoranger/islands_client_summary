defmodule Islands.Client.Summary.Message do
  use PersistConfig

  alias __MODULE__.{
    AllIslandsPositioned,
    Error,
    HitIslandForested,
    HitNoneForested,
    IslandPositioned,
    IslandsSet,
    MissNoneForested,
    Other,
    Player2Added,
    Stopping
  }

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.{IslandType, State}
  alias Islands.{Player, Response, Score}

  @island_type_codes ["a", "d", "l", "s", "q"]
  @sp ANSI.cursor_right()

  @spec new(State.t(), Response.t()) :: ANSI.ansilist()
  def new(state, response)
  def new(state, {:ok, :player2_added}), do: Player2Added.message(state)
  def new(state, {:ok, :island_positioned}), do: IslandPositioned.message(state)

  def new(state, {:ok, :all_islands_positioned}),
    do: AllIslandsPositioned.message(state)

  def new(state, {:ok, :islands_set}), do: IslandsSet.message(state)
  def new(state, {:hit, :none, :no_win}), do: HitNoneForested.message(state)
  def new(state, {:hit, _type, _status}), do: HitIslandForested.message(state)
  def new(state, {:miss, :none, :no_win}), do: MissNoneForested.message(state)
  def new(state, {:ok, :stopping}), do: Stopping.message(state)
  def new(state, {:error, _reason}), do: Error.message(state)
  def new(state, _other), do: Other.message(state)

  @spec puts(atom, Player.t() | Score.t()) :: :ok
  def puts(:board_player, player) do
    [ANSI.cursor_right(8), :chartreuse_yellow, center(player)] |> ANSI.puts()
  end

  def puts(:guesses_player, player) do
    [
      ANSI.cursor_up(),
      ANSI.cursor_right(41),
      :chartreuse_yellow,
      center(player)
    ]
    |> ANSI.puts()
  end

  def puts(:board_score, score) do
    [
      [ANSI.cursor_right(8), top_message(score)],
      ["\n", ANSI.cursor_right(8), bottom_message(score)]
    ]
    |> ANSI.puts()
  end

  def puts(:guesses_score, score) do
    [
      [ANSI.cursor_up(2), ANSI.cursor_right(41), top_message(score)],
      ["\n", ANSI.cursor_right(41), bottom_message(score)]
    ]
    |> ANSI.puts()
  end

  ## Private functions

  @spec center(Player.t()) :: String.t()
  defp center(player) do
    name = String.slice(player.name, 0, 21 - 2)
    text = "#{name} #{symbol(player.gender)}"
    span = div(21 + String.length(text), 2)
    String.pad_leading(text, span)
  end

  @spec symbol(Player.gender()) :: String.t()
  defp symbol(:f), do: "♀"
  defp symbol(:m), do: "♂"

  @spec top_message(Score.t()) :: ANSI.ansilist()
  defp top_message(score) do
    [
      [:chartreuse_yellow, "hits: "],
      [:spring_green, String.pad_leading("#{score.hits}", 2)],
      [:chartreuse_yellow, "   misses: "],
      [:spring_green, String.pad_leading("#{score.misses}", 2)]
    ]
  end

  @spec bottom_message(Score.t()) :: ANSI.ansilist()
  defp bottom_message(score) do
    [
      [[:reset, :spring_green, :underline], "forested"],
      [[:reset, @sp, :chartreuse_yellow], "=>"],
      forested_codes(score)
    ]
  end

  @spec forested_codes(Score.t()) :: ANSI.ansilist()
  defp forested_codes(score) do
    for code <- @island_type_codes do
      [attr(IslandType.new(code) in score.forested_types), code]
    end
  end

  @spec attr(boolean) :: ANSI.ansilist()
  defp attr(true = _forested?), do: [:reset, @sp, :spring_green, :underline]
  defp attr(false = _forested?), do: [:reset, @sp, :chartreuse_yellow]
end
