# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Summary do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Displays the summary of a _Game of Islands_.
  \n##### #{@course_ref}
  """

  alias __MODULE__.{Message, Score}
  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table
  alias Islands.Client.State
  alias Islands.{Grid, Tally}

  @margins [margins: [left: 35, top: -12]]

  @spec display(State.t(), ANSI.ansilist()) :: State.t()
  def display(state, message \\ [])

  def display(%State{tally: %Tally{response: response}} = state, []),
    do: state |> Message.new(response) |> do_display(state)

  def display(state, message), do: do_display(message, state)

  ## Private functions

  @spec do_display(ANSI.ansilist(), State.t()) :: State.t()
  defp do_display(message, state) do
    ANSI.puts(message)
    Score.format(state.tally.board_score, up: 0, right: 8)
    Score.format(state.tally.guesses_score, up: 3, right: 41)
    state.tally.board |> Grid.to_maps() |> Table.format()
    state.tally.guesses |> Grid.to_maps() |> Table.format(@margins)
    state

    # Default function => &Islands.Grid.Tile.new/1
    # fun = &Islands.Client.Summary.Tile.new/1
    # state.tally.board |> Grid.to_maps(fun) |> Table.format()
    # state.tally.guesses |> Grid.to_maps(fun) |> Table.format(@margins)
  end
end
