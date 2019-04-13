defmodule Islands.Client.Summary.Message do
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
  alias Islands.Client.State
  alias Islands.Response

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
end
