# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Summary do
  @moduledoc """
  Displays the summary of a _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.{Message, Score}
  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table
  alias Islands.Client.State
  alias Islands.{Grid, Tally}

  @spec display(State.t(), ANSI.ansilist()) :: State.t()
  def display(state, message \\ [])

  def display(%State{tally: %Tally{response: response}} = state, []),
    do: Message.new(state, response) |> do_display(state)

  def display(state, message), do: do_display(message, state)

  ## Private functions

  @spec do_display(ANSI.ansilist(), State.t()) :: State.t()
  defp do_display(message, state) do
    ANSI.puts(message)
    Score.format(state.tally.board_score, up: 0, right: 8)
    Score.format(state.tally.guesses_score, up: 3, right: 41)
    Grid.to_maps(state.tally.board) |> Table.format(spec_name: "left")
    Grid.to_maps(state.tally.guesses) |> Table.format(spec_name: "right")
    state

    # Default function => &Islands.Grid.Tile.new/1
    # fun = &Islands.Client.Summary.Tile.new/1
    # Grid.to_maps(state.tally.board, fun) |> Table.format(spec_name: "left")
    # Grid.to_maps(state.tally.guesses, fun) |> Table.format(spec_name: "right")
  end
end
