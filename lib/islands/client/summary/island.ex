defmodule Islands.Client.Summary.Island do
  alias Islands.Island

  @spec format(Island.type()) :: String.t()
  def format(island_type),
    do: Atom.to_string(island_type) |> String.upcase()
end
