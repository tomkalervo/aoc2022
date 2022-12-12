defmodule D10 do
  def run do
    instructions = String.split(In.put2(), ~r/\n/, trim: true)
    cycles = cpu(instructions, 1, [])

    IO.puts("Length #{Enum.count(cycles)}")
    # Find the signal strength during the 20th, 60th, 100th, 140th, 180th, and 220th cycles.
    strengths = [20, 60, 100, 140, 180, 220]

    # Enum.each(strengths, &(IO.puts"#{Enum.at(cycles, &1 - 1)}"))

    # Part 1
    List.foldl(strengths, 0, fn str, sum ->
      # zero-indexed
      sum + Enum.at(cycles, str - 1) * str
    end)
    |> IO.puts()

    # Part 2
    lines = [0, 40, 80, 120, 160, 200]
    Enum.each(lines, fn(row) ->
      crt =
        for pixel <- 0..39 do
          if(abs(Enum.at(cycles, pixel+row) - pixel) > 1) do
            '.'
          else
            '#'
          end
        end
        IO.puts(to_string(crt))
    end)

    # lines = [40, 80, 120, 160, 200, 240]
    # for i <- 1..240 do
    #   if rem(i, 40) == 0 do
    #     IO.puts(to_string(Enum.drop(crt, i-40) |> Enum.take(40)))
    #   end
    # end

  end

  def cpu([], regX, cycles) do
    Enum.reverse([regX | cycles])
  end

  # one cycle
  def cpu(["noop" | t], regX, cycles) do
    cpu(t, regX, [regX | cycles])
  end

  # two cycles to complete
  def cpu([ins | t], regX, cycles) do
    # print_cycles(regX, cycles)
    # IO.inspect(ins)
    n = String.split(ins) |> Enum.at(1) |> String.to_integer()
    # first cycle
    cycles = [regX | cycles]
    # second cycle
    cycles = [regX | cycles]
    regX = regX + n
    cpu(t, regX, cycles)
  end

  def print_cycles(1, []), do: IO.puts("First cycle started with regX value 1")

  def print_cycles(regX, [c | _] = cycles) do
    IO.puts(
      "start of cycle #{Enum.count(cycles) + 1} with regX value #{regX}, last cycle regX #{c}"
    )
  end
end

defmodule In do
  @p1 """
  addx 15
  addx -11
  addx 6
  addx -3
  addx 5
  addx -1
  addx -8
  addx 13
  addx 4
  noop
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx -35
  addx 1
  addx 24
  addx -19
  addx 1
  addx 16
  addx -11
  noop
  noop
  addx 21
  addx -15
  noop
  noop
  addx -3
  addx 9
  addx 1
  addx -3
  addx 8
  addx 1
  addx 5
  noop
  noop
  noop
  noop
  noop
  addx -36
  noop
  addx 1
  addx 7
  noop
  noop
  noop
  addx 2
  addx 6
  noop
  noop
  noop
  noop
  noop
  addx 1
  noop
  noop
  addx 7
  addx 1
  noop
  addx -13
  addx 13
  addx 7
  noop
  addx 1
  addx -33
  noop
  noop
  noop
  addx 2
  noop
  noop
  noop
  addx 8
  noop
  addx -1
  addx 2
  addx 1
  noop
  addx 17
  addx -9
  addx 1
  addx 1
  addx -3
  addx 11
  noop
  noop
  addx 1
  noop
  addx 1
  noop
  noop
  addx -13
  addx -19
  addx 1
  addx 3
  addx 26
  addx -30
  addx 12
  addx -1
  addx 3
  addx 1
  noop
  noop
  noop
  addx -9
  addx 18
  addx 1
  addx 2
  noop
  noop
  addx 9
  noop
  noop
  noop
  addx -1
  addx 2
  addx -37
  addx 1
  addx 3
  noop
  addx 15
  addx -21
  addx 22
  addx -6
  addx 1
  noop
  addx 2
  addx 1
  noop
  addx -10
  noop
  noop
  addx 20
  addx 1
  addx 2
  addx 2
  addx -6
  addx -11
  noop
  noop
  noop
  """

  @p2 """
  addx 1
  addx 4
  addx 1
  noop
  noop
  addx 4
  addx 1
  addx 4
  noop
  noop
  addx 5
  noop
  noop
  noop
  addx -3
  addx 9
  addx -1
  addx 5
  addx -28
  addx 29
  addx 2
  addx -28
  addx -7
  addx 10
  noop
  noop
  noop
  noop
  noop
  addx -2
  addx 2
  addx 25
  addx -18
  addx 3
  addx -2
  addx 2
  noop
  addx 3
  addx 2
  addx 5
  addx 2
  addx 2
  addx 3
  noop
  addx -15
  addx 8
  addx -28
  noop
  noop
  noop
  addx 7
  addx -2
  noop
  addx 5
  noop
  noop
  noop
  addx 3
  noop
  addx 3
  addx 2
  addx 5
  addx 2
  addx 3
  addx -2
  addx 3
  addx -31
  addx 37
  addx -28
  addx -9
  noop
  noop
  noop
  addx 37
  addx -29
  addx 4
  noop
  addx -2
  noop
  noop
  noop
  addx 7
  noop
  noop
  noop
  addx 5
  noop
  noop
  noop
  addx 4
  addx 2
  addx 4
  addx 2
  addx 3
  addx -2
  noop
  noop
  addx -34
  addx 6
  noop
  noop
  noop
  addx -4
  addx 9
  noop
  addx 5
  noop
  noop
  addx -2
  noop
  addx 7
  noop
  addx 2
  addx 15
  addx -14
  addx 5
  addx 2
  addx 2
  addx -32
  addx 33
  addx -31
  addx -2
  noop
  noop
  addx 1
  addx 3
  addx 2
  noop
  addx 2
  noop
  addx 7
  noop
  addx 5
  addx -6
  addx 4
  addx 5
  addx 2
  addx -14
  addx 15
  addx 2
  noop
  addx 3
  addx 4
  noop
  addx 1
  noop
  noop
  """
  def put1, do: @p1
  def put2, do: @p2
end
