defmodule Islands.Client.Summary.Island do
  alias Islands.Island

  @spec format(Island.type()) :: String.t()
  def format(island_type),
    do: island_type |> Atom.to_string() |> String.upcase()
end
