defmodule D11 do
  def run do
    input =
      String.split(In.put2(), ~r/\n\n/, trim: true)
      |> Enum.map(&String.split(&1, ~r/\n/, trim: true))

    # input into datastructure
    monkeys = parse(input, [])
    IO.inspect(monkeys)

    # For part 2
    rem_sum = List.foldl(monkeys, 1, fn([_, _, {:test, tst}, _, _, _, _], sum) ->
      sum * tst
    end)

    # start rounds
    monkeys =
      rounds(monkeys, 10_000, rem_sum)
      |> Enum.sort(fn [_, _, _, _, _, _, {:ins, ins1}], [_, _, _, _, _, _, {:ins, ins2}] ->
        ins1 >= ins2
      end)
      |> Enum.map(fn [_, _, _, _, _, _, {:ins, ins}] ->
        ins
      end)

    Enum.at(monkeys, 0) * Enum.at(monkeys, 1)
  end

  def rounds(monkeys, 0, _), do: monkeys

  def rounds(monkeys, n, rs) do
    monkeys = turn(0, Enum.count(monkeys), monkeys, rs)
    rounds(monkeys, n - 1, rs)
  end

  def turn(n, n, monkeys, _), do: monkeys

  def turn(x, n, monkeys, rs) do
    # IO.puts("New turn for monkey #{x}")
    {monkey, monkeys} = get_monkey(monkeys, x)
    [m, items: itm, test: tst, op: op, iftrue: ift, iffalse: iff, ins: ins] = monkey
    # inspection
    ins = ins + Enum.count(itm)

    itm =
      Enum.map(itm, fn i ->
        rem(inspection(op, i), rs)
      end)

    monkeys = toss(monkeys, itm, tst, ift, iff)
    # update monkey
    monkeys = [[m, items: [], test: tst, op: op, iftrue: ift, iffalse: iff, ins: ins] | monkeys]
    # IO.inspect(monkeys, charlists: :as_lists)
    turn(x + 1, n, monkeys, rs)
  end

  def toss(m, [], _, _, _), do: m

  def toss(monkeys, [i | itm], tst, ift, iff) do
    if rem(i, tst) == 0 do
      toss(give_monkey(monkeys, ift, i), itm, tst, ift, iff)
    else
      toss(give_monkey(monkeys, iff, i), itm, tst, ift, iff)
    end
  end

  def give_monkey(monkeys, x, itm) do
    {m, monkeys} = get_monkey(monkeys, x)
    [monkey, {:items, items}, test, op, ift, iff, ins] = m
    m = [monkey, {:items, items ++ [itm]}, test, op, ift, iff, ins]
    [m | monkeys]
  end

  def inspection(["old", "*", "old"], i) do
    # Part 1
    # Integer.floor_div(i * i, 3)
    # Part 2
    i*i
  end

  def inspection(["old", "+", x], i) do
    # Part 1
    # Integer.floor_div(String.to_integer(x) + i, 3)
    # Part 2
    String.to_integer(x) + i
  end

  def inspection(["old", "*", x], i) do
    # Part 1
    # Integer.floor_div(String.to_integer(x) * i, 3)
    # Part 2
    String.to_integer(x) * i
  end

  def get_monkey([[{:m, x}, _it, _test, _op, _ift, _iff, _ins] = m | monkeys], acc, x) do
    {m, monkeys ++ acc}
  end

  def get_monkey([h | t], acc, x) do
    get_monkey(t, [h | acc], x)
  end

  def get_monkey(m, x), do: get_monkey(m, [], x)

  def parse([], monkeys), do: monkeys

  def parse([[monkey, items, operation, test, iftrue, iffalse] | t], monkeys) do
    #   Monkey 0:
    monkey = String.split(monkey, ~r/[\s:]/, trim: true) |> Enum.at(1) |> String.to_integer()

    #   Starting items: 79, 98
    items =
      String.split(items, ~r/[:]/, trim: true)
      |> Enum.at(1)
      |> String.split(~r/[\s,]/, trim: true)
      |> Enum.map(&String.to_integer(&1))

    #    Operation: new = old * 19
    operation = String.split(operation, ~r/[=]/, trim: true) |> Enum.at(1) |> String.split()

    # Test: divisible by 23
    test = String.split(test, ~r/\s/, trim: true) |> Enum.at(3) |> String.to_integer()
    # If true: throw to monkey 2
    iftrue = String.split(iftrue, ~r/\s/, trim: true) |> Enum.at(5) |> String.to_integer()
    # If false: throw to monkey 3
    iffalse = String.split(iffalse, ~r/\s/, trim: true) |> Enum.at(5) |> String.to_integer()

    parse(t, [
      [
        {:m, monkey},
        {:items, items},
        {:test, test},
        {:op, operation},
        {:iftrue, iftrue},
        {:iffalse, iffalse},
        {:ins, 0}
      ]
      | monkeys
    ])
  end
end

defmodule In do
  @p1 """
  Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
  If true: throw to monkey 2
  If false: throw to monkey 3

  Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
  If true: throw to monkey 2
  If false: throw to monkey 0

  Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
  If true: throw to monkey 1
  If false: throw to monkey 3

  Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
  If true: throw to monkey 0
  If false: throw to monkey 1
  """
  @p2 """
  Monkey 0:
  Starting items: 53, 89, 62, 57, 74, 51, 83, 97
  Operation: new = old * 3
  Test: divisible by 13
  If true: throw to monkey 1
  If false: throw to monkey 5

  Monkey 1:
  Starting items: 85, 94, 97, 92, 56
  Operation: new = old + 2
  Test: divisible by 19
  If true: throw to monkey 5
  If false: throw to monkey 2

  Monkey 2:
  Starting items: 86, 82, 82
  Operation: new = old + 1
  Test: divisible by 11
  If true: throw to monkey 3
  If false: throw to monkey 4

  Monkey 3:
  Starting items: 94, 68
  Operation: new = old + 5
  Test: divisible by 17
  If true: throw to monkey 7
  If false: throw to monkey 6

  Monkey 4:
  Starting items: 83, 62, 74, 58, 96, 68, 85
  Operation: new = old + 4
  Test: divisible by 3
  If true: throw to monkey 3
  If false: throw to monkey 6

  Monkey 5:
  Starting items: 50, 68, 95, 82
  Operation: new = old + 8
  Test: divisible by 7
  If true: throw to monkey 2
  If false: throw to monkey 4

  Monkey 6:
  Starting items: 75
  Operation: new = old * 7
  Test: divisible by 5
  If true: throw to monkey 7
  If false: throw to monkey 0

  Monkey 7:
  Starting items: 92, 52, 85, 89, 68, 82
  Operation: new = old * old
  Test: divisible by 2
  If true: throw to monkey 0
  If false: throw to monkey 1
  """
  def put1, do: @p1
  def put2, do: @p2
end
