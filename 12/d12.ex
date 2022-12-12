defmodule D12 do
  def run do
    IO.puts(In.put1())
    String.split(In.put1)
  end
end

defmodule In do
  @p1 """
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  """
  @p2 """
  data 2
  """
  def put1, do: @p1
  def put2, do: @p2
end
