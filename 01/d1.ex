defmodule D1 do
  def run do
    IO.puts(In.put1)
    IO.puts(In.put2)
  end
end

defmodule In do
  @p1 """
  data 1
  """
  @p2 """
  data 2
  """
  def put1, do: @p1
  def put2, do: @p2

end
