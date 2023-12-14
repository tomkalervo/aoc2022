import re
import sys


def _get_vertice_and_edges(line):
  # Valve AA has flow rate=0; tunnels lead to valves DD, II, BB'
  print(line)
  pattern = r'Valve (\w+) has flow rate=(\d+)(?:; tunnels? leads? to valves? (.+))'
  match = re.search(pattern, line)
  if match:
    # Extract the entire group of valve names
    vertice = match.group(1)
    weight = match.group(2)
    edges = match.group(3)
    edges = [valve.strip() for valve in edges.split(',')]

    # Print the extracted valve names
    # print("Vertice {}, Weight {}:".format(vertice, weight))
    # print("Edges: {}".format(edges))

    return {vertice: (weight, edges)}
  else:
    print("Pattern not found in the input string.")
    sys.exit(1)


def read_file_and_append_to_list(file_path):
  adj_list = {}
  with open(file_path, 'r') as file:
    for line in file:
      #{vertice : (weight, list_of_edges)}
      adj_list.update(_get_vertice_and_edges(line))

  return adj_list


if __name__ == "__main__":
  file_path = 'day16/input1.txt'
  content_list = read_file_and_append_to_list(file_path)

  # Print the content of the list
  print(content_list)
