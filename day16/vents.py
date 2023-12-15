import re
import sys

def _get_vertice_and_edges(line):
  # Valve AA has flow rate=0; tunnels lead to valves DD, II, BB'
  pattern = r'Valve (\w+) has flow rate=(\d+)(?:; tunnels? leads? to valves? (.+))'
  match = re.search(pattern, line)
  if match:
    # Extract the entire group of valve names
    vertice = match.group(1)
    weight = match.group(2)
    edges = match.group(3)
    edges = [valve.strip() for valve in edges.split(',')]

    return {vertice: (weight, edges)}
  else:
    print("Pattern not found in the input string.")
    sys.exit(1)


def read_file_and_build_dict(file_path):
  adj_map = {}
  with open(file_path, 'r') as file:
    for line in file:
      #{vertice : (weight, list_of_edges)}
      adj_map.update(_get_vertice_and_edges(line))

  return adj_map

def search_and_append_matrix(i,n,matrix,adj_map,names):
  s = names[i]
  pq = [s]
  visited = {}
  visited.update({s: 0})
  while pq:
    s = pq.pop(0)
    distance = visited[s] + 1
    (_,edge_list) = adj_map[s]
    for u in edge_list:
      if not u in visited:
        pq.append(u)
        visited.update({u : distance})

  for u in visited:
    matrix[i][names.index(u)] = visited[u]
    matrix[names.index(u)][i] = visited[u]
  return matrix

def get_adj_matrix(adj_map):
  names = []
  flow_rate = []
  for v in adj_map:
    names.append(v)
    (flow,_) = adj_map[v]
    flow_rate.append(int(flow))

  n = len(names)      
  matrix = list(list(0 for _ in range(n)) for _ in range(n))
  for i in range(len(names)):
    matrix = search_and_append_matrix(i,n,matrix,adj_map,names)
  
  matrix = tuple(matrix)
  flow_rate = tuple(flow_rate)
  names = tuple(names)

  return [names,flow_rate,matrix]

def maximise_steam(flow_rate, matrix, start):
  steam = 0
  time = 30
  max_steam = 0
  for x in sorted(list(flow_rate), reverse=True):
    time -= 1
    max_steam += x * time
    time -= 1
  time = 30
  path = [start]
  queue = [index for index, value in enumerate(flow_rate) if value > 0]
  return branch_and_bound(flow_rate, matrix, path, queue, time, steam, max_steam)

def branch_and_bound(flow_rate, matrix, path, queue, time, steam, max_steam):
  # Basecases
  if not queue:
    return [steam, path]
  if time == 0:
    return [steam, path]
  if time < 0:
    print("Negative time!")
    sys.exit(1)

  # Time never stand still
  time -= 1
  highest_steam = 0
  best_path = []
  for s in queue:
    distance = matrix[path[-1]][s]
    if distance < time: 
      missed_steam = sum(flow_rate[v]*(distance) for v in queue)
      missed_steam -= flow_rate[s] * (distance)
      if max_steam-missed_steam > steam:
        # use new, local variables
        tm = (time-distance)
        st = (tm * flow_rate[s])
        max_st = max_steam - missed_steam
        qu = queue.copy()
        qu.remove(s)
        [st,pt] = branch_and_bound(flow_rate, matrix, [s], qu, tm, st, max_st)
        if st > highest_steam:
          highest_steam = st
          best_path = pt

  if best_path:      
    path.extend(best_path)
    steam += highest_steam

  return [steam, path]

def  _printPath(path, matrix, flow_rate):
  total = 0
  v = path.pop(0)
  time = 30
  print("Start at {}".format(v))
  while path:
    u = path.pop(0)
    time -= matrix[v][u]
    print("Moving to {}, distance is {}, time is now {}".format(u, matrix[v][u], time))
    time -= 1
    steam = flow_rate[u]*time
    print("vent is open at time {}, {} has a flow rate of {}, realising a total of {} steam".format(time,u,flow_rate[u],steam))
    total += steam
    v = u
  print("Done. A total of ", total, " steam has been released")

if __name__ == "__main__":
  file_path = 'day16/input2.txt'
  adj_map = read_file_and_build_dict(file_path)
  [names,flow_rate,matrix] = get_adj_matrix(adj_map)
  start = names.index('AA')
  [steam, path] = maximise_steam(flow_rate,matrix,start)
  print("Steam: ", steam)
  print(*path)
  _printPath(path, matrix, flow_rate)


