defmodule D12 do
  def run do
    input = String.split(In.put2()) |> Enum.map(&String.to_charlist(&1))
    y_max = Enum.count(input) - 1
    x_max = Enum.at(input, y_max) |> Enum.count()
    x_max = x_max - 1
    input = map_n(input, 0)
    goal = find_pos(input, 'E')
    start = find_pos(input, 'S')

    graph = build_graph(input, [], {0, 0}, {x_max, y_max})
    # strategy is to use bfs
    pq = [start]
    parent = bfs(graph, pq, [start], %{}, goal)
    p1 = path_length(parent, 0, goal, start)
    IO.puts("Part1 gives #{p1}")
    # part 2.
    # swap, go from 'E' to an 'a'
    as = find_all_pos(input, 'a')
    graph = Enum.map(graph, fn({u,v}) -> {v,u} end)
    pq = [goal]
    IO.puts(("Starting reversed bfs"))
    {[start], parent} = bfs(graph, pq, [goal], %{}, as)

    p2 = path_length(parent, 0, start, goal)
    IO.puts("new value #{p2}, old value #{p1}")
  end

  def path_length(_, n, start, start), do: n

  def path_length(map, n, v, start) do
    path_length(map, n + 1, Map.fetch!(map, v), start)
  end

  def bfs(_, [], _, _, _) do
    :error
  end

  # general case part 1
  def bfs(graph, [s | pq], visit, parent, goal) when is_number(goal) do
    neighbours = get_vertices(s, graph)
    {visit, parent, list} =
      List.foldl(neighbours, {visit, parent, []}, fn {_, v}, {vs, pr, list} ->
        case Enum.find_value(vs, fn u -> u == v end) do
          true ->
            # do nothing
            {vs, pr, list}

          nil ->
            {[v | vs], Map.put(pr, v, s), [v | list]}
        end
      end)

    if Map.has_key?(parent, goal) do
      parent
    else
      bfs(graph, pq ++ list, visit, parent, goal)
    end
  end

  # general case part 2
  def bfs(graph, [s | pq], visit, parent, goal) do
    # IO.inspect({[s | pq], visit, parent, goal})

    neighbours = get_vertices(s, graph)
    {visit, parent, list} =
      List.foldl(neighbours, {visit, parent, []}, fn {_, v}, {vs, pr, list} ->
        case Enum.find_value(vs, fn u -> u == v end) do
          true ->
            # do nothing
            {vs, pr, list}

          nil ->
            {[v | vs], Map.put(pr, v, s), [v | list]}
        end
      end)

    case List.foldl(goal, [], fn(a, acc) ->
        if Map.has_key?(parent, a) do
          [a|acc]
        else
          acc
        end
      end) do
        [] ->
          bfs(graph, pq ++ list, visit, parent, goal)
        a ->
          {a, parent}
    end

  end

  # Corner cases first
  def build_graph(data, graph, {x, y}, {x, y}) do
    neighbours = [get_node(data, {x - 1, y})]
    neighbours = [get_node(data, {x, y - 1}) | neighbours]
    # neighbours = [get_node(data, {x+1,y})|neighbours]
    # neighbours = [get_node(data, {x,y+1})|neighbours]
    e = get_vertices(get_node(data, {x, y}), neighbours)
    e ++ graph
    # build_graph(data, e ++ graph, {x+1,y}, {x_max, y_max})
  end

  def build_graph(data, graph, {0, 0}, {x_max, y_max}) do
    # neighbours = get_node(data, {x-1,y})
    # neighbours = [get_node(data, {x,y-1})|neighbours]
    neighbours = [get_node(data, {1, 0})]
    neighbours = [get_node(data, {0, 1}) | neighbours]
    e = get_vertices(get_node(data, {0, 0}), neighbours)
    build_graph(data, e ++ graph, {1, 0}, {x_max, y_max})
  end

  def build_graph(data, graph, {x, 0}, {x, y_max}) do
    neighbours = [get_node(data, {x - 1, 0})]
    # neighbours = [get_node(data, {x,y-1})|neighbours]
    # neighbours = [get_node(data, {x+1,y})|neighbours]
    neighbours = [get_node(data, {x, 1}) | neighbours]
    e = get_vertices(get_node(data, {x, 0}), neighbours)
    build_graph(data, e ++ graph, {0, 1}, {x, y_max})
  end

  def build_graph(data, graph, {0, y}, {x_max, y}) do
    # neighbours = get_node(data, {x-1,y})
    neighbours = [get_node(data, {0, y - 1})]
    neighbours = [get_node(data, {1, y}) | neighbours]
    # neighbours = [get_node(data, {x,y+1})|neighbours]
    e = get_vertices(get_node(data, {0, y}), neighbours)
    build_graph(data, e ++ graph, {1, y}, {x_max, y})
  end

  # First row
  def build_graph(data, graph, {x, 0}, {x_max, y_max}) do
    neighbours = [get_node(data, {x - 1, 0})]
    # neighbours = [get_node(data, {x,y-1})|neighbours]
    neighbours = [get_node(data, {x + 1, 0}) | neighbours]
    neighbours = [get_node(data, {x, 1}) | neighbours]
    e = get_vertices(get_node(data, {x, 0}), neighbours)
    build_graph(data, e ++ graph, {x + 1, 0}, {x_max, y_max})
  end

  # First column
  def build_graph(data, graph, {0, y}, {x_max, y_max}) do
    # neighbours = get_node(data, {x-1,y})
    neighbours = [get_node(data, {0, y - 1})]
    neighbours = [get_node(data, {1, y}) | neighbours]
    neighbours = [get_node(data, {0, y + 1}) | neighbours]
    e = get_vertices(get_node(data, {0, y}), neighbours)
    build_graph(data, e ++ graph, {1, y}, {x_max, y_max})
  end

  # Last column
  def build_graph(data, graph, {x, y}, {x, y_max}) do
    neighbours = [get_node(data, {x - 1, y})]
    neighbours = [get_node(data, {x, y - 1}) | neighbours]
    # neighbours = [get_node(data, {x+1,y})|neighbours]
    neighbours = [get_node(data, {x, y + 1}) | neighbours]
    e = get_vertices(get_node(data, {x, y}), neighbours)
    build_graph(data, e ++ graph, {0, y + 1}, {x, y_max})
  end

  # Last row
  def build_graph(data, graph, {x, y}, {x_max, y}) do
    neighbours = [get_node(data, {x - 1, y})]
    neighbours = [get_node(data, {x, y - 1}) | neighbours]
    neighbours = [get_node(data, {x + 1, y}) | neighbours]
    # neighbours = [get_node(data, {x,y+1})|neighbours]
    e = get_vertices(get_node(data, {x, y}), neighbours)
    build_graph(data, e ++ graph, {x + 1, y}, {x_max, y})
  end

  # The general case
  def build_graph(data, graph, {x, y}, {x_max, y_max}) do
    neighbours = [get_node(data, {x - 1, y})]
    neighbours = [get_node(data, {x, y - 1}) | neighbours]
    neighbours = [get_node(data, {x + 1, y}) | neighbours]
    neighbours = [get_node(data, {x, y + 1}) | neighbours]

    e = get_vertices(get_node(data, {x, y}), neighbours)

    build_graph(data, e ++ graph, {x + 1, y}, {x_max, y_max})
  end

  def get_node(data, {x, y}) do
    {u, n} = Enum.at(data, y) |> Enum.at(x)

    case u do
      'S' ->
        {'a', n}

      'E' ->
        {'z', n}

      _ ->
        {u, n}
    end
  end

  def get_vertices(s, graph) when is_number(s) do
    Enum.filter(graph, fn {u, _} ->
      u == s
    end)
  end

  def get_vertices({[v1], n1}, list) do
    List.foldl(list, [], fn {[v2], n2}, acc ->
      if v2 - v1 > 1 do
        acc
      else
        [{n1, n2} | acc]
      end
    end)
  end

  def find_pos([h | t], x) do
    case has_pos(h, x) do
      false ->
        find_pos(t, x)

      n ->
        n
    end
  end
  def find_all_pos([],_), do: []
  def find_all_pos([h | t], x) do
    h =
      Enum.flat_map(h, fn({v,n})->
        case v do
          ^x -> [n]
          _ -> []
        end
      end)
    h ++ find_all_pos(t, x)
  end

  def has_pos([], _), do: false
  def has_pos([{x, n} | _], x), do: n
  def has_pos([_ | t], x), do: has_pos(t, x)

  def map_n([], _), do: []

  def map_n([h | t], n) do
    {h, n} = List.foldl(h, {[], n}, fn v, {acc, n} -> {[{[v], n} | acc], n + 1} end)
    [Enum.reverse(h) | map_n(t, n)]
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
  abcccccccccccccccccccccccccccccccccccccaaaaaaacccccccaaaaaaaaaaaccccccccccccccccccccaaacaaaaaaaacccccccccccccccccccccccccccccccccccaaaaa
  abccccccccccccccccccaaccaacccccccccccccaaaaaaaccccccccaaaaaaaaaaacccccccaaaaccccccccaaaaaaaaaaaaacccccccccccccccccccccccccccccccccaaaaaa
  abccccccccccccccccccaaaaaaccccccccccaaaccaaaaaacccccccaaaaaaaaaaccccccccaaaaccccccaaaaaaaaaaaaaaacccccccccccccccccccaaacccccccccccaaaaaa
  abcccccccccccccccccccaaaaacccccccccccaaccaacaaaccccccaaaaaaaaaaaccccccccaaaacccccaaaaaaaaacaaaaaaacccccccccccccccccaaaacccccccccccaaacaa
  abccccccccccccccccccaaaaaaccccccccaacaaaaaacccccccccaaaaaaaaaaaaacaaaccccaaccccccaaaaaaaaacaacccccccccccccccccaaaccaaaacccccccccccccccaa
  abcccccccccccccccccaaaaaaaacccccccaaaaaaaaccccccaaaaaaaacaaaacaaaaaaacccccccccaaccccaaaaaacaaacccccccccccccccaaaakkkaaccccccccccccccccaa
  abcccccccccccccccccaaaaaaaaccccccccaaaaaccccaacccaaaaaaaaaaaacaaaaaaccccccccccaacccaaaaaaaaaaaacccccccccccccccakkkkkklcccccccccccccccccc
  abaaacccccccccccaaccccaaccccccccccccaaaaaccaaacccaaaaaaaaaaaaaaaaaaaaccccccaaaaaaaacaacccaaaaaaccccccccccccccckkkkkkkllcccccccaaaccccccc
  abaaaacccccccaacaaccccaacccccccccccaaacaaaaaaaccccaaaaaaaaaaaaaaaaaaaacccccaaaaaaaaaaaccccaaaaacccccccccccccckkkksssllllccccccaaaaaacccc
  abaaaacccccccaaaaacccccccccccaaaccccaacaaaaaaccccaaaaaacaaaaaaaaaaaaaacccccccaaaaccccccccaaaaacccccccccccccckkkksssssllllcccccaaaaaacccc
  abaaacccccccccaaaaaaccccccccaaaaccccccccaaaaaaaacaaaaaaaaaaaaacaaacaaacccccccaaaaacccccccaaaaacccccccccccccjkkkrssssssllllccccccaaaccccc
  abccccccccccaaaaaaaaccccccccaaaacccccccaaaaaaaaacaacaaaaaaaaaacaaaccccccccccaaacaaccccccccccccccccccccccccjjkkrrsuuussslllllcccccaaccccc
  abccaaacccccaaaaacccccccccccaaaaccccccaaaaaaaaaacccccaaaaaaaaaacaaccccccccccaacccacccccccccccccccccccccjjjjjjrrrsuuuussslllllmcccddacccc
  abcccaaaccaccacaaaccccccccccccccccccccaaaaaaaccccccccccaaaaaaaaccccccaacccccccccccaaaaacccccccccccccccjjjjjjrrrruuuuuusssllmmmmmddddcccc
  abccaaaaaaaacccaaaccccccccccccccccaaacccccaaaccccccccccccaaacccccccccaacccccccccccaaaaacccccccccccccjjjjjrrrrrruuuxuuussqqqqmmmmmdddcccc
  abcaaaaaaaacccaaaaaacaaaaaccccccaaaaaaccccaaacccaaccccccccaaccccccaaaaaaaaccaaacccaaaaaaccccccccccccjjjjrrrrrruuuxxxuuuqqqqqqqmmmdddcccc
  abaaaaaaaaaccccaaaaacaaaaaccccccaaaaaaaaccccccaaaaaaccccccccccccccaaaaaaaaccaaacaaaaaaaacccccccccccjjjjrrrtttuuuuxxxyvvvvvqqqqmmmdddcccc
  abaaaaaaaaaccaaaaaaacaaaaaaccccccaaaaaaaacccccaaaaaaccccccccccccccccaaaaccaaaaaaaaaaaaaacccccccccaaiijqqqrttttuuuxxyyvvvvvvvqqmmmdddcccc
  abcaaaaaaaaccaaaaaaaaaaaaaacccccaaaaaaaacccccccaaaacccccaaaaccccccccaaaaacaaaaaaaaccaaccccccccccaaaiiiqqqttttxxxxxxyyyyyyvvvqqmmmdddcccc
  abcccaaaaaaacaaaaaaaaaaaaaacccccaaaaaaaaaaaccccaaaaccccaaaaacccccccaaaaaacaaaaaaacccccccccccccccaaaiiiqqqtttxxxxxxxyyyyyyvvqqqmmmdddcccc
  SbcccaacccaccccaaacacccaaacccccccccaaaaaaaaacccaccaccccaaaaaaccccccaaccaacccaaaaaccccccccccccccccaaiiiiqqtttxxxxEzzzyyyyvvvqqqmmmddccccc
  abccaaaccccccccaaccccccccccccccccccaaaaaaaaccccccccccccaaaaaaccccccccccccccaaacaaaccaacccccccccccccciiiqqqttttxxxyyyyyvvvvqqqmmmdddccccc
  abccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccaaaaaacccccccccccccccaacccccaaaaaaaccccccccccciiiqqqttttxxyyyyyvvvrrrnnneeecccccc
  abcaaaaccccccccccccccccccccccccccaaaaaaaaccccccccccccccccaacccccccccccccccccccccccccaaaaacccccccccccciiiqqqqttxxyyyyyyyvvrrnnnneeecccccc
  abcaaaaacccccccccccccccccccccccccaaaacaaacccaccaaacccccccccccccccccccccccccaaaccccaaaaaaaccccccccccccciiiqqqttwwyywwyyywwrrnnneeeccccccc
  abaaaaaacccaccaccccccccccccccccccaaaaccaacccaaaaaaccccccccccccccccaaaccccaaaaaacccaaaaaaaacccccccccccciiiqqqtswwwwwwwwwwwrrnnneeeccccccc
  abaaaaaacccaaaaccccccccaaaacccccccaaacccccccaaaaaacccccccccccccccaaaaaaccaaaaaacccaaaaaaaacaaccccccaaciiiqppsswwwwsswwwwwrrrnneeeccccccc
  abcaaaaacccaaaaacccccccaaaacccccccccccccccccaaaaaaaccccccccccccccaaaaaaccaaaaaacccccaaaaaaaaaccccccaaaahhpppssswwsssswwwwrrrnneeeacccccc
  abcaaaccccaaaaaacccccccaaaaccccccccccccccccaaaaaaaaccccccccccccccaaaaacccaaaaaccccccaacaaaaaaaaccaaaaaahhpppsssssssssrrrrrrnnneeeacccccc
  abccccccccaaaaaaccccccccaacccccccccccccccccaaaaaaaaccccaacccccccccaaaaaccaaaaacccccccccaaaaaaaaccaaaaachhpppssssssoosrrrrrrnnneeeaaacccc
  abccccccccccaaccccccccccccccccaaaaaccccccaacccaaacccaaaaacccccccccaacaacccccccccccccccccaaaaaaacccaaaaahhhppppssppooooorroonnffeaaaacccc
  abaaccccccccccccccccccccccccccaaaaaccccccaacccaaaccccaaaaacccccccccccccccccccccccccccaacaaaaacccccaacaahhhppppppppoooooooooonfffaaaacccc
  abaccccccccccccccccccccccccccaaaaaacccaaaaaaaacccccccaaaaaccccccccccccccccccccccccaaaaaaaaaaaccccccccccchhhpppppppgggoooooooffffaacccccc
  abaccccccccccccccccccccccccccaaaaaacccaaaaaaaaccccccaaaaaccccccacccaacccccccccccccaaaaaccccaaccccccccccchhhhhhggggggggfffffffffaaacccccc
  abaacccccccccccccccccccccccccaaaaaacccccaaaacccccccccaaaacccaacaacaaacccccccccccccaaaaaaacccccccccccccccchhhhgggggggggffffffffccaacccccc
  abcccccccaacccccccccccccccccccaaaccccccaaaaaccccccccaaaaccaaaacaaaaacccccccccccccaaaaaaaaccccccccccccccccchhhggggaaaagffffffcccccccccccc
  abcccccccaacccccccccccccaacccccccccccccaaaaaaccaaccccaaaaaaaaacaaaaaacccccccaaaacaaaaaaaacccccccccccaacccccccaaaacaaaacccccccccccccccccc
  abccccaaaaaaaacccccccaacaaaccccccccccccaaccaacaaaacccaaaaaaaacaaaaaaaaccccccaaaaccacaaaccaaaccccaaaaaacccccccaacccaaaacccccccccccccaaaaa
  abccccaaaaaaaacccccccaaaaaccccccccccccccccccccaaaaccccaaaaaaacaaaaaaaaccccccaaaaccccaaaccaaaaaccaaaaaaaacccccccccccaaaccccccccccccccaaaa
  abccccccaaaaccccccccccaaaaaaccccccccccccccccccaaaacccaaaaaaaaaaccaaccccccccccaacccccccccaaaaacccaaaaaaaacccccccccccaaaccccccccccccccaaaa
  abcccccaaaaaacccccccaaaaaaaacccccccccccccccccccccccaaaaaaaaaaaaaaaacccccccccccccccccccccaaaaaacccaaaaaaaccccccccccccccccccccccccccaaaaaa
  """
  def put1, do: @p1
  def put2, do: @p2
end
