defmodule Islands.Client.Summary.App do
  use Application
  use PersistConfig

  alias IO.ANSI.Table

  @headers get_env(:headers)
  @left_options get_env(:left_options)
  @right_options get_env(:right_options)

  @dialyzer {:nowarn_function, start: 2}
  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    {:ok, _pid} = Table.start(@headers, @left_options)
    {:ok, _pid} = Table.start(@headers, @right_options)
    {:ok, self()}
  end
end
