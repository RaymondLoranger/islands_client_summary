defmodule Islands.Client.Summary.Score do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.IslandType
  alias Islands.Score

  @island_type_codes ["a", "d", "l", "s", "q"]
  @sp ANSI.cursor_right()
  @symbols [f: "♀", m: "♂"]

  @spec format(Score.t(), Keyword.t()) :: :ok
  def format(%Score{} = score, options) do
    {up, right} = {options[:up], options[:right]}

    [
      [cursor_up(up), ANSI.cursor_right(right), player(score)],
      ["\n", ANSI.cursor_right(right), top_score(score)],
      ["\n", ANSI.cursor_right(right), bottom_score(score)]
    ]
    |> ANSI.puts()
  end

  ## Private functions

  @spec cursor_up(non_neg_integer) :: String.t()
  defp cursor_up(up) when up > 0, do: ANSI.cursor_up(up)
  defp cursor_up(_up), do: ""

  @spec player(Score.t()) :: ANSI.ansilist()
  defp player(%Score{name: name, gender: gender}) do
    name = String.slice(name, 0, 21 - 2)
    span = div(21 + String.length(name) + 2, 2) - 2

    [
      [:chartreuse_yellow, String.pad_leading(name, span)],
      [:reset, @sp, :spring_green, "#{@symbols[gender]}"]
    ]
  end

  @spec top_score(Score.t()) :: ANSI.ansilist()
  defp top_score(%Score{hits: hits, misses: misses}) do
    [
      [:chartreuse_yellow, "hits: "],
      [:spring_green, String.pad_leading("#{hits}", 2)],
      [:chartreuse_yellow, "   misses: "],
      [:spring_green, String.pad_leading("#{misses}", 2)]
    ]
  end

  @spec bottom_score(Score.t()) :: ANSI.ansilist()
  defp bottom_score(score) do
    [
      [:reset, :spring_green, :underline, "forested"],
      [:reset, @sp, :chartreuse_yellow, "➔", forested_codes(score)]
    ]
  end

  @spec forested_codes(Score.t()) :: ANSI.ansilist()
  defp forested_codes(%Score{forested_types: forested_types}) do
    for code <- @island_type_codes do
      [attr(IslandType.new(code) in forested_types), code]
    end
  end

  @spec attr(boolean) :: ANSI.ansilist()
  defp attr(true = _forested?), do: [:reset, @sp, :spring_green, :underline]
  defp attr(false = _forested?), do: [:reset, @sp, :chartreuse_yellow]
end
