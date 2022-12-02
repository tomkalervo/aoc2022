# Simply hardcoded the outcome...

defmodule D2 do
  def run2 do
    String.split(In.put2, ~r/(\n)/)
    |> List.foldl(0, fn(x,acc) ->
      acc + outcome(x)
    end) |> IO.puts()

  end

  #Rock
  def outcome("A X"), do: 3 + 0
  def outcome("A Y"), do: 1 + 3
  def outcome("A Z"), do: 2 + 6
  #Paper
  def outcome("B X"), do: 1 + 0
  def outcome("B Y"), do: 2 + 3
  def outcome("B Z"), do: 3 + 6
  #Scissor
  def outcome("C X"), do: 2 + 0
  def outcome("C Y"), do: 3 + 3
  def outcome("C Z"), do: 1 + 6
  def outcome(""), do: 0

  def run1 do
    String.split(In.put2, ~r/(\n)/)
    |> List.foldl(0, fn(x,acc) ->
      acc + res(x)
    end) |> IO.puts()

  end
  def res("A X"), do: 1 + 3
  def res("A Y"), do: 2 + 6
  def res("A Z"), do: 3 + 0
  def res("B X"), do: 1 + 0
  def res("B Y"), do: 2 + 3
  def res("B Z"), do: 3 + 6
  def res("C X"), do: 1 + 6
  def res("C Y"), do: 2 + 0
  def res("C Z"), do: 3 + 3
  def res(""), do: 0

end

defmodule In do
  @p1 """
  A Y
  B X
  C Z
  """
  @p2 """
  B Z
  C Z
  B X
  A Y
  B X
  B X
  A X
  B Z
  C Z
  B Y
  A Z
  C X
  B X
  C X
  B Z
  B Z
  C Y
  B Z
  B Z
  C Z
  B Z
  B Y
  B X
  B Y
  C Z
  C Y
  C Z
  A X
  C Z
  B X
  C Z
  B Y
  B X
  A Y
  A X
  A Y
  B Y
  B X
  B X
  A Z
  B Z
  B Y
  C Z
  B X
  C Y
  B Z
  B Y
  C Y
  A X
  A Y
  C Y
  C Z
  B Z
  B X
  C Z
  A X
  B X
  A Y
  B Z
  C Y
  A Y
  C Z
  C Z
  A X
  B X
  C Z
  A Z
  A Z
  B X
  B X
  B X
  A Y
  B X
  B X
  C Y
  B X
  C Z
  C Y
  B Z
  A X
  B X
  B X
  A X
  C Y
  C Y
  A X
  A X
  B Z
  B X
  C Z
  B X
  B Z
  A Z
  B Z
  A X
  A X
  B Z
  A X
  B X
  B X
  B X
  A Y
  A Y
  A Y
  B X
  C Y
  B Z
  A Y
  B X
  A Z
  C X
  A Z
  B Y
  B Z
  C Z
  B Z
  A Y
  B X
  B Z
  B Z
  B Z
  C Y
  B X
  A Y
  B Z
  B Y
  B Z
  B X
  A X
  A X
  B Y
  B X
  C Y
  A Y
  A Z
  B Z
  B Z
  B Y
  B X
  B Z
  B X
  B Z
  B Z
  B X
  B Z
  B Z
  B Z
  B X
  A Y
  B X
  B Z
  A X
  B Z
  B Z
  B X
  C Y
  A Z
  B Z
  C Z
  B X
  A Z
  B X
  A Z
  C Y
  C Y
  A Y
  A Y
  B Z
  A Y
  A Y
  C Z
  A X
  B X
  B X
  C Y
  A Z
  B Y
  C Y
  B Z
  B Y
  B Z
  A X
  B Z
  C Z
  B X
  B Y
  A X
  C Z
  B Y
  B Z
  B Z
  A Z
  B X
  A Y
  C Y
  C Y
  B Z
  B Z
  B X
  B Z
  B Z
  B Y
  B Z
  B Z
  B Z
  B X
  B X
  B Z
  B Y
  B Z
  C Y
  A Z
  A Y
  B X
  A X
  B Z
  B Z
  A Z
  B Z
  B Z
  B X
  A Y
  C Z
  C Y
  B Z
  B Z
  C Z
  A X
  B Z
  B Z
  B X
  A Y
  A Z
  B Z
  C Y
  C Z
  A Y
  B Z
  B X
  C Z
  A X
  C Z
  B Z
  C Z
  B X
  C Y
  B X
  B Z
  B X
  A Y
  A Z
  B Z
  B X
  B Z
  C Z
  C Z
  C Y
  B X
  B Y
  B Z
  C Z
  C Z
  B Z
  B X
  B Z
  C Y
  A Y
  C Y
  B X
  C Y
  B Y
  C X
  B X
  A Y
  C Z
  B X
  B Z
  B Y
  B X
  B X
  A Z
  B Z
  C Z
  B X
  B X
  A X
  B X
  B X
  C X
  C Y
  A X
  B X
  B Z
  B X
  A Y
  B X
  B Y
  B X
  B X
  B Y
  B X
  A Z
  B X
  B Z
  B X
  C Z
  A Z
  C X
  B Z
  A Y
  B X
  B X
  A Z
  A Y
  B Z
  B Z
  A Y
  C Z
  B X
  B X
  C Z
  B Z
  B Z
  B Z
  A Y
  A Y
  A X
  B X
  C X
  B X
  B Z
  B X
  A X
  B X
  B Z
  B X
  A Y
  B X
  C Y
  B X
  B Z
  B Z
  C Z
  C Z
  C Y
  B Z
  B X
  B Z
  A Y
  C Y
  B X
  C Y
  C Z
  A X
  B Z
  A X
  B X
  C Y
  A X
  A Y
  B X
  A Y
  A Z
  C X
  B X
  B Y
  B Z
  B X
  A Y
  B Z
  B X
  A X
  B X
  B X
  B Y
  B Z
  B Z
  B X
  B X
  A X
  B Z
  B Z
  B Z
  A Y
  C Z
  A X
  A Y
  B Z
  B X
  C Y
  A X
  B X
  B Z
  B Y
  A Y
  B Z
  B Z
  B X
  A Y
  A Y
  A Y
  C Y
  B X
  B X
  B Z
  B Z
  A Z
  A Y
  B Z
  B X
  B X
  B X
  A X
  B X
  C Y
  B Z
  A Y
  B X
  A Y
  A X
  C Y
  B Z
  C Z
  B Z
  B X
  B Z
  A Y
  B Z
  C Z
  B Z
  B Z
  A X
  B Z
  B Z
  B X
  B Z
  B Z
  B Z
  C X
  B X
  B X
  A Y
  A Y
  B X
  B X
  C Z
  B X
  B X
  C Y
  C Y
  C Z
  B X
  B Z
  B Z
  B Z
  A Y
  A Y
  A X
  C Z
  A Z
  A X
  B Z
  C Z
  A X
  B X
  B Y
  C Z
  B Y
  B Z
  C Y
  C Y
  C Y
  B Z
  B Z
  B X
  B Z
  B Y
  B X
  B Z
  A X
  B X
  A Y
  A X
  B Z
  A Y
  C Z
  C X
  B X
  B X
  C Y
  B Z
  A Y
  B Z
  B X
  C X
  B Z
  A X
  A Y
  A Y
  C Y
  C Z
  C Z
  B X
  A X
  B X
  B X
  B Z
  C Y
  B X
  C Z
  C Y
  B X
  B Z
  B X
  B X
  C Z
  A Y
  B Z
  B X
  A X
  B Z
  B Z
  B X
  B X
  C Z
  C Z
  B Y
  C Z
  B Z
  C Y
  B X
  B X
  C Y
  B X
  B X
  A Z
  B X
  B X
  A Y
  B X
  B X
  B X
  B Z
  B Z
  C Z
  A Y
  B X
  B Z
  B X
  B Z
  B Z
  B X
  B Y
  C Z
  A Z
  A Y
  C Y
  B X
  A X
  B Y
  A X
  B Y
  A Y
  C X
  B X
  A Y
  B Z
  B Z
  B X
  B Z
  B Z
  B X
  B X
  A Y
  B Z
  A Y
  B Y
  B Y
  B Y
  B X
  B Z
  B Z
  A Y
  A X
  C Y
  B X
  B X
  A Y
  B X
  A Y
  B Z
  B Z
  B Y
  B Z
  C Z
  C Z
  C Y
  B Z
  C Y
  A X
  B X
  C Y
  C Z
  B X
  C Y
  A Y
  B Z
  B Z
  A X
  C Y
  B X
  A Y
  C Z
  B Z
  B X
  A Y
  C Z
  A X
  A Y
  C X
  C Y
  A Y
  B Z
  B X
  A Z
  B Z
  B Z
  B X
  C Z
  B X
  B Z
  B X
  B X
  B Z
  B X
  A X
  A Y
  B Y
  A Y
  A Y
  B Z
  C Z
  B X
  B Z
  A Y
  A Y
  A Z
  B X
  A Y
  A Y
  B X
  A X
  B Y
  B Z
  B Y
  A Z
  C Y
  B Z
  A X
  A Z
  C Z
  B X
  B Z
  B X
  C Y
  A X
  B Z
  A Y
  B X
  B Z
  B X
  C Y
  B Z
  B X
  A Y
  B X
  C Y
  C X
  A X
  B Z
  B X
  A X
  A Z
  B X
  B Y
  A Z
  B Z
  C Y
  A Y
  C X
  B Z
  A Y
  C Y
  C Z
  B Y
  C Y
  A Z
  B Z
  B Z
  A Y
  B X
  C X
  A Y
  A Y
  A Z
  B X
  B X
  B Y
  A X
  B X
  B Z
  B Z
  B X
  B Y
  C Z
  C Y
  A Y
  A Y
  C X
  C Z
  C Y
  C Y
  A Y
  A Y
  B Z
  C Y
  C Y
  A Y
  A Y
  C Z
  B Z
  A X
  B Y
  B Z
  B Z
  B Z
  B Z
  B X
  A Y
  A Y
  B Z
  A Y
  C X
  A X
  C Z
  B Z
  B Z
  A X
  C Y
  B Z
  B X
  B X
  B X
  B Z
  C Y
  B Z
  B X
  B X
  B Z
  C Y
  B X
  A Z
  B X
  B Z
  A X
  C X
  A X
  B Z
  B Z
  B Z
  B Z
  A Y
  B Z
  B Y
  B Z
  B Z
  B X
  B Z
  B Z
  A Y
  A X
  B X
  A Z
  B Z
  A Z
  B X
  B X
  B Z
  A Y
  B Y
  A X
  B X
  B X
  A Y
  B X
  B X
  B Z
  B Y
  B Z
  C Z
  B X
  C Y
  B Z
  B Z
  C Y
  B Z
  B Z
  B Z
  B Z
  B Z
  C Y
  A Y
  A X
  B Z
  C Y
  B Y
  C Z
  B Z
  B Z
  C Z
  B Z
  B Z
  B X
  A Y
  B Z
  B Z
  C Y
  A Y
  B Z
  A Y
  B Z
  C Z
  C Y
  A Y
  A Z
  B X
  A X
  B Z
  B Y
  A X
  A X
  A Y
  B X
  C Y
  B X
  B Z
  A Y
  B X
  B X
  A Y
  A Z
  C Z
  C Y
  A Y
  B X
  B Z
  B X
  C Z
  A Y
  B X
  A Y
  B Z
  B X
  C Y
  A Y
  B Z
  C Y
  B Y
  B X
  C Y
  A Y
  B Z
  C Y
  B X
  A X
  B Z
  B Z
  C Y
  A Y
  B Z
  C Y
  B X
  A X
  A Z
  C X
  B Z
  B Z
  C Y
  B Y
  C Z
  C Y
  A X
  A Y
  A X
  A Y
  C Z
  C Y
  C Z
  C Z
  C Y
  A X
  C Z
  B X
  C X
  B X
  A Z
  B X
  C Z
  A Y
  A X
  A Z
  C Z
  B X
  C Y
  A Y
  C Y
  C Z
  C Y
  C Y
  C X
  B Z
  B X
  B Y
  A X
  B Z
  B Y
  C Y
  C Y
  C Z
  A Z
  A X
  A Y
  C Z
  B Z
  B X
  B Z
  B Z
  B X
  B Z
  C Y
  A X
  B X
  A Z
  B X
  C Y
  B Z
  B X
  B Z
  C Z
  C Z
  A X
  B Z
  B X
  A Y
  B Z
  A Y
  B Y
  C Z
  C Y
  A X
  A Y
  C Y
  C Z
  B X
  C Y
  B Z
  B Z
  B Z
  C Z
  B X
  C Y
  B Z
  C Z
  B X
  A Y
  A X
  B Z
  B Z
  C Y
  B X
  B Z
  C Y
  A Y
  C Y
  A Y
  B X
  C Z
  A X
  A Y
  C Y
  C Z
  B Z
  B Z
  B Z
  A Y
  A Y
  C Z
  A Z
  B X
  A X
  B Z
  C Z
  B X
  C Y
  B Z
  B X
  B Z
  B Z
  B X
  C Z
  B X
  B Z
  B X
  A X
  B X
  A X
  B Z
  B Z
  A Y
  B X
  B Z
  B Z
  C Z
  C Y
  B X
  B X
  B Y
  C Z
  C Y
  A X
  B Z
  C Y
  A Y
  B X
  B X
  A X
  A Y
  C X
  B Z
  B Z
  A Y
  A X
  C Y
  B Z
  B Z
  C X
  C Y
  A Y
  B Z
  C Y
  B Z
  B X
  B Z
  C Y
  B X
  B Z
  B X
  B X
  B X
  B Z
  B Z
  C Y
  B X
  B Z
  A Z
  A Y
  A Z
  A Y
  B X
  C Z
  A Y
  B X
  B X
  C Z
  B Z
  A X
  B X
  C Y
  A Y
  A X
  B Z
  A X
  A Y
  B Z
  B X
  B Z
  C Y
  A X
  A X
  B X
  B Y
  C X
  A X
  B X
  B X
  A Y
  C Y
  B Z
  B Z
  C Z
  B X
  B Z
  B X
  B Y
  B Z
  B Z
  B X
  B Z
  A X
  B X
  A Y
  A Z
  B Z
  B X
  A Y
  A X
  B Z
  B X
  C Z
  A Y
  A Y
  C Z
  B X
  A X
  C Y
  B X
  B Z
  B X
  B Z
  B X
  C Y
  B Z
  C Y
  C Z
  A Z
  C Z
  A X
  C Z
  B Y
  B X
  B Z
  C Z
  A Y
  A Z
  A X
  B Z
  A X
  B Z
  B X
  A Z
  C Z
  C Y
  B Z
  C X
  A X
  A X
  B X
  A Y
  A X
  B Z
  B Z
  B Z
  B Z
  A X
  A X
  A Y
  B Z
  B Y
  B Z
  A Y
  B Y
  A X
  A Z
  B Z
  A Y
  B X
  A X
  A X
  B Z
  A Z
  B Y
  B Z
  C Z
  C Y
  B X
  B Y
  A X
  A Z
  B Z
  A Z
  B Z
  A X
  B Z
  A Z
  B Y
  A Z
  C Y
  B Z
  C Z
  B Z
  B X
  B Z
  C X
  A X
  B X
  C Z
  B X
  B Y
  A X
  B X
  B X
  A Z
  B X
  B Z
  C Z
  B X
  B X
  B X
  A Y
  A Z
  C Y
  A Y
  B X
  A Z
  A Z
  B Y
  B Y
  C Z
  C Z
  B Z
  C Z
  B Z
  A Y
  A X
  C Y
  B X
  B Z
  B Z
  B Z
  B X
  B Z
  B Z
  A X
  A Y
  B X
  B X
  B X
  C X
  C Y
  C X
  B X
  B Z
  B Y
  C X
  A Y
  A Y
  B Z
  C Y
  C Z
  C Z
  C Z
  A Y
  B Y
  B Z
  B X
  B Z
  B Y
  A X
  C Y
  C Z
  A Y
  B Z
  A X
  A X
  A X
  B Z
  B X
  C Y
  B Y
  C Z
  B Z
  B Z
  C Y
  B Z
  C Z
  B X
  B Y
  A Y
  C Z
  A Y
  B Z
  B Z
  B X
  B X
  B Z
  B Z
  B X
  B X
  C Z
  B Y
  B Z
  B X
  C Y
  C Z
  A Y
  C Z
  B Z
  C Y
  B X
  C Z
  A X
  B Z
  B X
  C X
  C Z
  B Z
  C Z
  A X
  B Z
  C X
  B Z
  C Z
  A Y
  B Z
  B Z
  C Z
  B Y
  B Z
  B X
  B X
  A X
  A Y
  A Y
  C Y
  C Y
  C Y
  B Z
  B Z
  A Y
  B X
  A Z
  C Y
  C Z
  B X
  A Y
  A Y
  C Z
  C Z
  C Y
  A Z
  B Z
  B Z
  B Z
  A Y
  A Y
  C Z
  B Z
  B X
  C Z
  B Z
  C Y
  A Z
  B X
  B Z
  A Z
  B X
  A X
  B X
  A X
  B X
  B Z
  B Z
  B Z
  C Y
  C Z
  A Y
  B X
  A X
  C Z
  C Y
  C Z
  B Z
  B X
  A Y
  A X
  C Z
  B X
  C Z
  C Y
  A X
  B X
  C Z
  B X
  B Z
  C Y
  B X
  A X
  A Y
  A X
  B Z
  B Z
  C Z
  B X
  A Y
  B X
  B X
  A Z
  B Y
  B Z
  B X
  B Z
  B X
  B Y
  B X
  B X
  A Y
  A Y
  A X
  C Y
  A Y
  B X
  C Y
  B Z
  B Z
  A Y
  B X
  C Y
  C Z
  C Y
  B Z
  C Z
  C Y
  A Y
  A Y
  B Z
  B X
  A X
  A Y
  B X
  B Z
  B X
  C Z
  C Z
  A Y
  B X
  B Z
  B Y
  C X
  C Y
  B Z
  A X
  B Z
  A Y
  A X
  A Y
  B X
  B Z
  B Z
  B X
  B Z
  C Z
  B Z
  A Y
  B Z
  C Z
  B X
  B X
  B X
  B X
  B X
  B X
  B Y
  B Z
  B X
  B Z
  A Z
  B Z
  C Y
  A X
  B Z
  B Z
  C Z
  B X
  A Z
  C Y
  B Z
  B X
  A X
  A Y
  C Y
  B Y
  A X
  B Y
  B X
  B Z
  C Y
  B Z
  C Y
  A Z
  B Z
  C Y
  C Z
  A Y
  C X
  C Y
  B Z
  B X
  B Z
  B X
  B X
  A Y
  B Y
  B X
  B X
  C Y
  B X
  C X
  B Y
  A Y
  C Y
  B X
  B X
  A X
  B X
  A X
  A X
  B X
  B X
  A Z
  C Z
  C Y
  B X
  B X
  C Z
  B X
  C Y
  C Z
  A Y
  B Z
  C Y
  B X
  B Y
  B X
  B X
  C X
  A X
  B X
  B Z
  B Z
  C Y
  C Y
  B Y
  A Y
  B Z
  B X
  B X
  A Z
  B Z
  B X
  B X
  A Y
  B X
  B X
  B X
  A X
  B X
  B X
  B X
  B Z
  B X
  A Z
  B Y
  B X
  B Z
  B Z
  B Z
  A X
  B Z
  B Z
  B X
  B Z
  C Z
  C Y
  A Z
  C X
  C Y
  A Y
  B X
  B Z
  C Z
  B X
  C Z
  B Z
  A Z
  A Y
  B Y
  B Z
  B X
  A X
  B Z
  C Z
  C Y
  B Z
  A X
  A Y
  A Z
  B Z
  C Y
  A Y
  B X
  C Z
  A Y
  B X
  B Z
  B X
  C Y
  B X
  B X
  B X
  A Z
  B Z
  C Z
  B Z
  C Y
  B Z
  C Z
  B Z
  B X
  C Y
  C Z
  A X
  C Z
  C Y
  C Y
  B X
  A Y
  A Z
  B X
  B Z
  B Z
  B Z
  A X
  A Z
  B Z
  A Z
  A Y
  C Z
  B Y
  B Z
  B X
  B X
  C Z
  B Z
  B Z
  B Z
  B Z
  B X
  B X
  A X
  A X
  A Z
  B Z
  B X
  B Z
  B Z
  C X
  A Y
  B Y
  B X
  B X
  B Z
  B X
  B X
  B X
  C Y
  B Z
  B X
  C Y
  B Z
  A Y
  B Y
  B Z
  A Y
  A X
  B X
  B X
  B Z
  A X
  B Z
  A Y
  B Z
  B X
  A X
  A X
  A X
  A Y
  B Z
  A Y
  A X
  B X
  B Z
  A Y
  B Z
  B X
  B X
  A Z
  B Z
  B Z
  B Z
  B Z
  A X
  B Z
  B Z
  B X
  B Z
  C Y
  B Z
  B X
  B Z
  B X
  C Y
  B X
  B Y
  B Z
  B X
  A X
  C Y
  B Z
  B Z
  B X
  A Y
  B X
  B Z
  C X
  C Y
  A Y
  B X
  B X
  A Y
  B Z
  C Y
  B Z
  A Y
  C Y
  B Z
  A X
  A X
  A Y
  C Y
  C Z
  B Z
  C Z
  B X
  A X
  B X
  A Y
  A Y
  C Z
  C Y
  A Z
  B Z
  A Y
  B X
  B X
  B Z
  C Z
  B X
  B X
  B Y
  C Y
  C Z
  A Y
  A Z
  A X
  A Y
  A Y
  A Z
  B Z
  B Z
  C Z
  B Z
  B X
  C Y
  A Y
  B X
  C Z
  A X
  B Z
  B Y
  A Y
  B X
  B X
  A X
  C Z
  C Z
  C Y
  C Y
  A X
  B X
  B X
  B Y
  A Z
  C Z
  A Y
  C Z
  C Y
  B X
  C Y
  B Z
  A Z
  B Y
  B X
  C Y
  B Y
  B Z
  A Z
  A X
  B X
  C Z
  C Z
  B Z
  B Z
  C Z
  B X
  B X
  C Y
  A Y
  C Y
  C Z
  B Z
  B X
  A Y
  B Y
  B Z
  C X
  B X
  B Z
  B Z
  B X
  B Z
  B Z
  C Y
  A Y
  B Z
  B X
  A Y
  A Y
  B Z
  B Y
  C Y
  B Z
  B Y
  B Z
  A Y
  B X
  C Z
  A X
  B X
  C Y
  B Z
  B Y
  B Y
  B Z
  A X
  A X
  B Z
  B X
  A X
  B Z
  B Z
  A Y
  B X
  A X
  B X
  B X
  A Y
  C Z
  C Y
  B Z
  B X
  B X
  B X
  A X
  B X
  B Z
  B Z
  B Z
  B X
  B Z
  B Z
  A Z
  C Y
  B X
  B X
  B X
  A X
  C Z
  A Y
  A Y
  B Z
  B X
  C Z
  B Y
  C Z
  B X
  A Y
  C X
  B Z
  B X
  B X
  C Y
  B X
  B X
  B Z
  A X
  B X
  A Z
  B X
  B X
  B Z
  B X
  B X
  B Z
  A Y
  B X
  B Z
  B X
  B X
  C Y
  B X
  B Z
  B Z
  B X
  B Z
  C Z
  B Y
  A Y
  B Z
  B X
  B X
  A X
  B Z
  B X
  B X
  B Z
  C Z
  B Z
  B X
  C Y
  B Z
  B Y
  B Z
  B Z
  A Z
  B X
  B X
  B X
  B X
  C Y
  A Y
  B X
  B Z
  B X
  B X
  C Z
  C X
  B Z
  B Z
  B X
  B Z
  A Y
  A Z
  C Z
  A X
  A X
  A Y
  A Y
  A Y
  C Z
  B Z
  A Y
  C Z
  B X
  A Z
  C Y
  A X
  A X
  A Y
  B Z
  A X
  B X
  B X
  C Z
  B Z
  C Z
  B Z
  A X
  C Y
  C Z
  A X
  A Z
  B X
  C Y
  A X
  B X
  B Z
  B X
  A Y
  A Z
  C Z
  B Z
  A X
  B X
  C Y
  B X
  B X
  C Y
  B X
  A Z
  A X
  C X
  B Z
  B Y
  C Z
  C Z
  A Y
  A Y
  A Y
  B X
  A Z
  B X
  A X
  C Y
  B X
  A X
  B X
  B X
  B Z
  B Z
  B Y
  A Y
  C Z
  C Z
  B X
  B Z
  C Z
  B X
  C Z
  B Z
  A Y
  A X
  B X
  C Z
  C Y
  A Y
  B Z
  C Y
  B X
  C X
  A X
  B Z
  C Z
  B Z
  B X
  A Y
  B Z
  A Y
  A Y
  A Y
  C Y
  C Y
  C Z
  A Y
  C Y
  C Y
  B Z
  B X
  C Y
  C Y
  B X
  B Z
  B X
  C Z
  C Y
  C Y
  B X
  B X
  A Y
  B Z
  B Z
  B X
  B X
  C Z
  A X
  B Y
  B X
  A Z
  B Z
  B X
  B Z
  C Y
  B Z
  C Y
  B Z
  A Z
  C Y
  A Z
  C Z
  B X
  B X
  C Y
  B X
  C Y
  A Z
  B X
  B Z
  B Z
  B X
  B Z
  B Y
  A Y
  B Z
  B X
  B Z
  A Y
  A Y
  C Z
  A Y
  C X
  B Z
  A Y
  A Y
  B X
  B Z
  A Y
  C Z
  B Z
  B Z
  C Y
  A X
  B Z
  C Z
  B X
  B X
  B Z
  A Y
  B Y
  C Z
  A Y
  B X
  C Z
  B X
  B Z
  B Z
  B Z
  B X
  B Z
  B X
  A Z
  B X
  B X
  B X
  B Z
  A Z
  A Y
  B Z
  B X
  B X
  C X
  A Y
  A X
  C Y
  A Z
  A X
  C Y
  A Y
  C Y
  A Z
  B X
  B Z
  B Z
  C Y
  A Y
  B X
  B X
  A Y
  C Z
  B Z
  B Z
  A X
  A Y
  B Z
  A Z
  A Y
  C Z
  B X
  B Z
  B Z
  C Y
  A Y
  C Z
  B Z
  A Y
  C Y
  C Y
  B Z
  B Z
  B Z
  A Y
  B Y
  A Y
  B Z
  C Z
  A Y
  B X
  C Y
  A Z
  A X
  B X
  A Z
  B Z
  A Z
  C Z
  B Z
  A Y
  A X
  A X
  C Y
  A Y
  B Z
  A Y
  B Z
  B X
  A Y
  A X
  A Y
  A X
  C Z
  A Y
  B X
  C Z
  B X
  B Z
  B Z
  C Y
  B Z
  B X
  A X
  B Y
  A Y
  B X
  C Z
  A Y
  B Z
  B X
  A Y
  C Z
  C Y
  B Z
  B Z
  B Z
  A X
  B X
  A Y
  B Z
  C Y
  A X
  A Z
  B Y
  B X
  C Y
  B Z
  C Y
  A Z
  B X
  A Y
  A Y
  C Y
  A Z
  B X
  A Z
  B X
  B X
  A X
  B X
  B Z
  B X
  B Y
  B Z
  B Y
  B X
  A Y
  A X
  C Z
  B Y
  C Y
  B X
  C Y
  B X
  B Z
  B X
  B X
  B Z
  B Z
  B Z
  C Z
  B Z
  B Z
  A X
  A Y
  B X
  B X
  B X
  C Z
  B X
  B Z
  C Y
  A X
  A Z
  B X
  C Z
  A X
  A X
  B Z
  A Y
  B Z
  A X
  C X
  C Z
  B X
  B X
  C Y
  A X
  B X
  A X
  C Y
  C Y
  A X
  A X
  B X
  B Y
  B Z
  A X
  B X
  B X
  B X
  B Y
  A Z
  B Z
  C Z
  B X
  B X
  B Z
  A Y
  C Y
  B X
  B X
  A X
  C Y
  C X
  C Z
  B X
  B Y
  A Z
  C Z
  A X
  C Y
  B Z
  B X
  A X
  B X
  B X
  B Z
  C Y
  A Y
  A X
  C Z
  B Z
  A Y
  B X
  B X
  B X
  A Y
  B X
  C Y
  B Y
  A X
  A X
  B Y
  B X
  B X
  B Z
  B Z
  A X
  C Z
  C Z
  A X
  C Y
  B X
  C Z
  B X
  B Z
  B X
  B Z
  A Y
  C Y
  B X
  B X
  B X
  B X
  B Y
  C Y
  B Y
  B Y
  A Y
  B Z
  C Y
  A X
  C Z
  B X
  B Z
  C Y
  A Y
  B X
  C Z
  B Z
  A Z
  A Z
  A Z
  A Y
  C Z
  A Z
  B X
  C Z
  B Z
  B X
  C X
  A Z
  B Y
  A Y
  B Y
  C Y
  B X
  A X
  A X
  A Y
  A Y
  A X
  B Y
  B Z
  B X
  A X
  C Y
  B X
  B Y
  A Y
  C Y
  A Y
  B Z
  B X
  B Z
  B Z
  B X
  B X
  B Z
  B Z
  C Z
  C Y
  A Z
  B X
  B X
  A Y
  C Y
  B X
  B Z
  B X
  C Z
  A Z
  B X
  C Z
  B X
  B X
  B X
  B Z
  C Z
  C Z
  B X
  C Y
  B Z
  C Z
  B Z
  C Z
  B Y
  B X
  C Z
  A X
  B X
  B X
  C Y
  B Z
  """
  def put1, do: @p1
  def put2, do: @p2

end
