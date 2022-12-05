
#This solution is far from pretty...
defmodule D5 do
  def run1 do
    [stacks,orders] = String.split(In.put2, ~r/\n\n/)
    stacks
      = String.split(stacks, ~r/\n/)
      |> Enum.map(&(String.to_charlist(&1)))

    {stacks,[len]} =
      Enum.split(stacks, Enum.count(stacks) - 1)

    [len] = Enum.drop(len, Enum.count(len) - 1)
    len = len - 48

    s =
      for _ <- 1..len do
        []
      end

    stacks = Enum.map(stacks, fn(x) -> Enum.filter(x, fn(y) -> y != ?[ and y != ?] and y != ?\s end) end)
    stacks = get_stacks(stacks, s) |> Enum.map(&(Enum.reverse(&1)))
    orders = String.split(orders, ~r/\n/) |> Enum.map(fn(x)-> String.split(x) end)
    #Stacks are not parsing leading space correctly (did not copy from text)
    stacks = In.stack
    IO.inspect(stacks)
    stacks = operate(stacks, orders)
    IO.inspect(stacks)
    List.foldl(stacks,[],fn([h|_], acc) -> [h|acc] end) |> Enum.reverse()
  end
  # [
  #   ["move", "1", "from", "2", "to", "1"],
  #   ["move", "3", "from", "1", "to", "3"],
  #   ["move", "2", "from", "2", "to", "1"],
  #   ["move", "1", "from", "1", "to", "2"],
  #   []
  # ]
  def operate(stacks, []), do: stacks
  def operate(stacks, [h|t]) do
    IO.inspect(h)
    IO.inspect(stacks)
    operate(move(h, stacks), t)
  end

  def move([], stacks), do: stacks
  def move([_,m,_,f,_,t], stacks) do
    # IO.puts("move #{m} from #{f} to #{t}")
    {crates, stacks} = lift_crates([], stacks, String.to_integer(f), String.to_integer(m))
    put_crates(crates, [], stacks, String.to_integer(t))
  end

  def put_crates(crates, left, [h|right], 1) do
    h = append(crates, h)
    append(left, [h|right])
  end
  def put_crates(crates, left, [h|right], t) do
    put_crates(crates, [h|left], right, t-1)
  end

  def lift_crates(left, [h|right], 1, m) do
    crates = Enum.take(h,m) |> Enum.reverse()
    {crates, append(left, [Enum.drop(h,m)|right])}
  end
  def lift_crates(left, [h|right], f, m) do
    lift_crates([h|left], right, f-1, m)
  end

  def get_stacks([], stacks), do: stacks
  def get_stacks([h|t], stacks) do
    stacks = put_stack(h, stacks)
    get_stacks(t, stacks)
  end
  def put_stack([], rest), do: rest
  def put_stack([h|t], [s|rest]) do
    s = [h|s]
    [s|put_stack(t,rest)]
  end

  def append([],list), do: list
  def append([h|t], list) do
    append(t, [h|list])
  end
end

defmodule In do
  @p1 """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """
  @stack ['PVZWDT','DJFVWSL','HBTVSLMZ','JSR','WLMFGBZC','BGRZHVWQ','NDBCPJV','QBTP','CRZGH']
  @p2 """
[H]     [W] [B]
[D] [B]     [L] [G] [N]
[P] [J] [T]     [M] [R] [D]
[V] [F] [V]     [F] [Z] [B]     [C]
[Z] [V] [S]     [G] [H] [C] [Q] [R]
[W] [W] [L] [J] [B] [V] [P] [B] [Z]
[D] [S] [M] [S] [Z] [W] [J] [T] [G]
[T] [L] [Z] [R] [C] [Q] [V] [P] [H]
1   2   3   4   5   6   7   8   9

move 3 from 2 to 9
move 1 from 1 to 6
move 6 from 6 to 7
move 13 from 7 to 6
move 2 from 4 to 5
move 1 from 4 to 3
move 5 from 9 to 8
move 1 from 8 to 5
move 3 from 1 to 6
move 2 from 1 to 8
move 1 from 2 to 1
move 1 from 9 to 3
move 2 from 9 to 8
move 2 from 5 to 9
move 4 from 5 to 4
move 10 from 8 to 4
move 5 from 6 to 2
move 5 from 5 to 9
move 7 from 3 to 7
move 1 from 9 to 8
move 1 from 1 to 9
move 1 from 7 to 3
move 3 from 8 to 9
move 8 from 6 to 7
move 3 from 9 to 4
move 3 from 2 to 6
move 6 from 6 to 3
move 10 from 7 to 9
move 1 from 7 to 5
move 1 from 5 to 7
move 2 from 3 to 6
move 8 from 4 to 2
move 7 from 4 to 3
move 5 from 2 to 3
move 2 from 4 to 6
move 6 from 2 to 8
move 14 from 9 to 1
move 6 from 3 to 2
move 7 from 3 to 7
move 4 from 2 to 3
move 1 from 6 to 5
move 3 from 6 to 5
move 2 from 2 to 4
move 3 from 1 to 2
move 2 from 4 to 1
move 3 from 5 to 6
move 1 from 9 to 6
move 1 from 2 to 6
move 7 from 7 to 4
move 5 from 8 to 1
move 11 from 3 to 5
move 2 from 2 to 5
move 8 from 5 to 1
move 4 from 7 to 2
move 2 from 6 to 8
move 3 from 2 to 4
move 1 from 8 to 3
move 1 from 3 to 2
move 11 from 1 to 8
move 4 from 6 to 5
move 1 from 4 to 1
move 2 from 6 to 4
move 14 from 1 to 9
move 1 from 1 to 6
move 1 from 1 to 9
move 10 from 4 to 3
move 3 from 3 to 2
move 8 from 8 to 9
move 1 from 4 to 5
move 8 from 5 to 8
move 10 from 9 to 5
move 5 from 3 to 2
move 1 from 3 to 7
move 1 from 2 to 5
move 6 from 2 to 3
move 7 from 3 to 5
move 1 from 6 to 9
move 2 from 5 to 9
move 4 from 2 to 9
move 1 from 2 to 1
move 1 from 1 to 5
move 1 from 7 to 4
move 17 from 9 to 1
move 4 from 1 to 5
move 9 from 5 to 8
move 21 from 8 to 6
move 1 from 4 to 6
move 3 from 5 to 1
move 10 from 1 to 5
move 12 from 5 to 3
move 3 from 3 to 6
move 5 from 5 to 7
move 5 from 5 to 9
move 5 from 7 to 5
move 2 from 5 to 7
move 1 from 8 to 5
move 1 from 7 to 3
move 3 from 1 to 7
move 11 from 6 to 5
move 1 from 7 to 3
move 5 from 9 to 7
move 8 from 3 to 6
move 4 from 9 to 6
move 3 from 1 to 6
move 1 from 9 to 5
move 6 from 5 to 1
move 1 from 1 to 6
move 3 from 1 to 3
move 2 from 1 to 2
move 19 from 6 to 1
move 2 from 5 to 9
move 5 from 3 to 1
move 1 from 5 to 6
move 5 from 6 to 7
move 3 from 7 to 9
move 6 from 5 to 9
move 1 from 5 to 6
move 4 from 6 to 9
move 2 from 2 to 1
move 1 from 3 to 2
move 1 from 2 to 7
move 7 from 7 to 6
move 21 from 1 to 3
move 2 from 7 to 8
move 7 from 3 to 2
move 2 from 7 to 9
move 8 from 3 to 8
move 4 from 3 to 1
move 6 from 1 to 9
move 7 from 2 to 9
move 1 from 3 to 6
move 1 from 8 to 7
move 1 from 1 to 6
move 12 from 6 to 9
move 1 from 3 to 6
move 1 from 7 to 5
move 1 from 1 to 9
move 1 from 5 to 9
move 39 from 9 to 4
move 3 from 9 to 6
move 1 from 9 to 6
move 7 from 8 to 4
move 1 from 9 to 8
move 44 from 4 to 1
move 1 from 6 to 3
move 28 from 1 to 8
move 15 from 8 to 1
move 1 from 3 to 2
move 11 from 1 to 5
move 1 from 4 to 7
move 1 from 4 to 5
move 16 from 1 to 6
move 1 from 2 to 6
move 12 from 8 to 2
move 1 from 7 to 4
move 3 from 2 to 4
move 7 from 2 to 4
move 4 from 1 to 6
move 10 from 5 to 6
move 1 from 1 to 5
move 3 from 5 to 9
move 3 from 8 to 7
move 1 from 2 to 3
move 1 from 2 to 4
move 3 from 7 to 4
move 30 from 6 to 8
move 1 from 3 to 7
move 20 from 8 to 4
move 1 from 7 to 3
move 1 from 9 to 8
move 25 from 4 to 6
move 1 from 3 to 5
move 8 from 8 to 5
move 3 from 8 to 4
move 2 from 9 to 5
move 2 from 5 to 2
move 21 from 6 to 4
move 2 from 2 to 6
move 28 from 4 to 5
move 1 from 8 to 6
move 5 from 4 to 8
move 3 from 6 to 7
move 15 from 5 to 2
move 3 from 7 to 6
move 1 from 4 to 3
move 17 from 5 to 1
move 1 from 3 to 4
move 1 from 4 to 8
move 4 from 2 to 4
move 4 from 4 to 1
move 5 from 6 to 8
move 11 from 8 to 3
move 4 from 6 to 7
move 5 from 3 to 2
move 4 from 3 to 1
move 25 from 1 to 7
move 3 from 6 to 7
move 8 from 2 to 3
move 11 from 7 to 2
move 2 from 2 to 7
move 16 from 2 to 6
move 1 from 2 to 8
move 1 from 7 to 6
move 1 from 5 to 2
move 16 from 6 to 2
move 3 from 5 to 7
move 6 from 2 to 8
move 1 from 5 to 4
move 1 from 4 to 3
move 4 from 8 to 9
move 4 from 3 to 9
move 2 from 6 to 2
move 6 from 2 to 4
move 1 from 9 to 7
move 1 from 2 to 8
move 7 from 3 to 6
move 4 from 2 to 6
move 2 from 9 to 5
move 1 from 2 to 4
move 6 from 6 to 9
move 2 from 5 to 1
move 1 from 1 to 4
move 1 from 9 to 4
move 2 from 7 to 6
move 1 from 2 to 5
move 1 from 5 to 9
move 4 from 8 to 1
move 7 from 9 to 8
move 3 from 1 to 7
move 1 from 8 to 3
move 4 from 9 to 6
move 6 from 8 to 1
move 6 from 1 to 2
move 1 from 1 to 9
move 1 from 1 to 7
move 21 from 7 to 5
move 11 from 5 to 3
move 1 from 9 to 5
move 1 from 2 to 8
move 5 from 7 to 5
move 10 from 3 to 9
move 1 from 8 to 5
move 8 from 4 to 2
move 1 from 3 to 4
move 2 from 7 to 3
move 5 from 5 to 3
move 5 from 9 to 8
move 10 from 6 to 2
move 1 from 6 to 4
move 1 from 9 to 4
move 4 from 9 to 3
move 19 from 2 to 5
move 2 from 4 to 5
move 11 from 5 to 1
move 15 from 5 to 2
move 4 from 8 to 1
move 12 from 1 to 5
move 1 from 8 to 1
move 1 from 4 to 8
move 3 from 1 to 3
move 8 from 5 to 4
move 7 from 3 to 9
move 4 from 3 to 5
move 4 from 4 to 1
move 3 from 9 to 3
move 2 from 4 to 1
move 4 from 3 to 8
move 4 from 2 to 3
move 1 from 9 to 5
move 4 from 8 to 6
move 2 from 4 to 3
move 1 from 4 to 5
move 5 from 3 to 4
move 3 from 3 to 6
move 5 from 1 to 6
move 2 from 4 to 6
move 1 from 9 to 2
move 7 from 6 to 3
move 1 from 8 to 9
move 2 from 1 to 4
move 2 from 4 to 7
move 4 from 6 to 4
move 5 from 3 to 7
move 1 from 7 to 2
move 3 from 6 to 7
move 1 from 4 to 5
move 4 from 2 to 6
move 3 from 6 to 9
move 1 from 6 to 5
move 1 from 9 to 2
move 5 from 9 to 3
move 11 from 5 to 1
move 3 from 7 to 8
move 2 from 8 to 9
move 4 from 5 to 1
move 10 from 2 to 7
move 5 from 3 to 7
move 1 from 9 to 3
move 6 from 1 to 7
move 22 from 7 to 9
move 3 from 2 to 4
move 4 from 5 to 3
move 1 from 8 to 4
move 5 from 4 to 7
move 19 from 9 to 8
move 2 from 1 to 5
move 2 from 4 to 5
move 2 from 4 to 9
move 4 from 9 to 2
move 4 from 7 to 3
move 5 from 7 to 5
move 7 from 3 to 7
move 2 from 8 to 4
move 3 from 4 to 7
move 12 from 8 to 1
move 4 from 3 to 7
move 1 from 3 to 6
move 1 from 6 to 1
move 1 from 5 to 9
move 3 from 9 to 3
move 2 from 2 to 4
move 3 from 8 to 3
move 2 from 4 to 7
move 7 from 5 to 1
move 2 from 8 to 3
move 8 from 7 to 9
move 2 from 9 to 7
move 3 from 9 to 5
move 11 from 1 to 2
move 5 from 3 to 8
move 16 from 1 to 5
move 1 from 9 to 8
move 3 from 3 to 2
move 6 from 2 to 6
move 6 from 7 to 4
move 2 from 5 to 2
move 6 from 4 to 9
move 11 from 5 to 7
move 2 from 6 to 5
move 9 from 5 to 1
move 2 from 8 to 5
move 13 from 7 to 4
move 6 from 1 to 5
move 10 from 2 to 9
move 1 from 4 to 5
move 4 from 6 to 9
move 3 from 2 to 4
move 2 from 8 to 2
move 15 from 4 to 5
move 1 from 2 to 8
move 1 from 2 to 3
move 2 from 8 to 7
move 3 from 7 to 1
move 1 from 7 to 8
move 3 from 5 to 9
move 1 from 7 to 1
move 21 from 5 to 2
move 3 from 9 to 1
move 5 from 1 to 4
move 1 from 3 to 4
move 1 from 8 to 5
move 1 from 8 to 9
move 1 from 5 to 3
move 5 from 2 to 5
move 5 from 5 to 3
move 7 from 9 to 2
move 3 from 3 to 6
move 2 from 1 to 4
move 1 from 3 to 4
move 2 from 3 to 2
move 25 from 2 to 1
move 11 from 9 to 2
move 9 from 2 to 8
move 4 from 9 to 5
move 6 from 4 to 3
move 3 from 3 to 5
move 9 from 8 to 2
move 3 from 4 to 3
move 1 from 9 to 4
move 4 from 3 to 8
move 2 from 8 to 1
move 3 from 5 to 9
move 2 from 8 to 1
move 4 from 2 to 9
move 6 from 9 to 4
move 1 from 9 to 2
move 1 from 6 to 4
move 3 from 4 to 3
move 2 from 3 to 9
move 3 from 1 to 9
move 2 from 2 to 7
move 2 from 7 to 2
move 2 from 3 to 2
move 5 from 9 to 7
move 2 from 7 to 2
move 28 from 1 to 7
move 1 from 1 to 9
move 10 from 2 to 5
move 1 from 9 to 5
move 14 from 7 to 1
move 6 from 1 to 6
move 12 from 7 to 9
move 6 from 1 to 5
move 1 from 3 to 8
move 4 from 7 to 1
move 4 from 4 to 8
move 4 from 6 to 1
move 1 from 2 to 8
move 1 from 2 to 1
move 1 from 6 to 1
move 5 from 9 to 8
move 16 from 5 to 7
move 2 from 7 to 1
move 6 from 8 to 1
move 2 from 9 to 4
move 2 from 1 to 3
move 1 from 6 to 8
move 2 from 5 to 3
move 3 from 5 to 7
move 4 from 8 to 7
move 4 from 9 to 8
move 6 from 8 to 6
move 10 from 7 to 8
move 1 from 9 to 1
move 11 from 7 to 6
move 2 from 3 to 9
move 1 from 3 to 4
move 4 from 1 to 2
move 3 from 2 to 3
move 1 from 9 to 1
move 3 from 4 to 2
move 9 from 6 to 4
move 2 from 3 to 5
move 8 from 4 to 9
move 4 from 1 to 8
move 3 from 8 to 2
move 2 from 2 to 6
move 1 from 7 to 2
move 11 from 6 to 5
move 7 from 8 to 6
move 7 from 5 to 8
move 5 from 8 to 5
move 1 from 2 to 5
move 3 from 5 to 7
move 8 from 5 to 6
move 2 from 4 to 5
move 1 from 7 to 9
move 2 from 3 to 8
move 3 from 8 to 5
move 13 from 6 to 2
move 2 from 8 to 5
move 5 from 1 to 9
move 3 from 6 to 4
move 5 from 5 to 8
move 1 from 5 to 4
move 4 from 1 to 4
move 1 from 7 to 2
move 12 from 9 to 7
move 2 from 9 to 1
move 3 from 8 to 3
move 1 from 5 to 4
move 3 from 8 to 9
move 2 from 4 to 7
move 4 from 9 to 5
move 5 from 4 to 9
move 3 from 9 to 2
move 1 from 9 to 4
move 1 from 9 to 3
move 12 from 7 to 4
move 1 from 4 to 8
move 1 from 8 to 1
move 1 from 5 to 4
move 2 from 3 to 5
move 11 from 2 to 3
move 4 from 5 to 7
move 7 from 7 to 2
move 1 from 1 to 9
move 1 from 8 to 3
move 1 from 9 to 1
move 2 from 1 to 5
move 2 from 5 to 4
move 1 from 8 to 1
move 2 from 5 to 8
move 5 from 1 to 9
move 11 from 3 to 9
move 1 from 3 to 6
move 1 from 6 to 3
move 3 from 3 to 6
move 3 from 2 to 6
move 13 from 9 to 7
move 2 from 6 to 1
move 8 from 4 to 9
move 7 from 4 to 2
move 2 from 8 to 6
move 1 from 1 to 9
move 5 from 2 to 1
move 2 from 1 to 3
move 10 from 2 to 8
move 3 from 9 to 3
move 1 from 7 to 4
move 6 from 7 to 5
"""
  def put1, do: @p1
  def put2, do: @p2
  def stack, do: @stack


end
