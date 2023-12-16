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

# Part 2
def maximise_steam_eliphant_helper(flow_rate, matrix, start):
  steam = 0
  time = 26
  max_steam = 0
  for x in sorted(list(flow_rate), reverse=True):
    time -= 1
    max_steam += x * time
    time -= 1
  time = [26,26]
  path = [[start],[start]]
  queue = [index for index, value in enumerate(flow_rate) if value > 0]
  return branch_and_bound_duo(flow_rate, matrix, path, queue, time, steam, max_steam)

def branch_and_bound_duo(flow_rate, matrix, path, queue, time, steam, max_steam):
  # Basecases
  if not queue:
    print("Queue empty at time: {} {}".format(time[0], time[1]))
    return [steam, path]
  if time[0] == 0 and time[1] == 0:
    print("time: {} {}".format(time[0], time[1]))
    return [steam, path]
  if time[0] < 0 or time[1] < 0:
    print("Negative time!")
    sys.exit(1)
  if time[0] == 0:
    print("time: {} {}".format(time[0], time[1]))
    [st2, pt2] = branch_and_bound_duo(flow_rate, matrix, path[1], queue, time[1], steam, max_steam)
    return [st2, [path[0],pt2]]
  if time[1] == 0:
    print("time: {} {}".format(time[0], time[1]))
    [st1, pt1] = branch_and_bound_duo(flow_rate, matrix, path[0], queue, time[0], steam, max_steam)
    return [st1, [pt1,path[1]]]

  # Time never stand still
  time[0] -= 1
  time[1] -= 1
  highest_steam = 0
  best_path = []
  for i in range(len(queue)):
    for j in range(len(queue)):
      if not i == j:
        s1 = queue[i]
        s2 = queue[j]
        distance1 = matrix[path[0][-1]][s1]
        distance2 = matrix[path[1][-1]][s2]
        qu = queue.copy()
        qu.remove(s1)
        qu.remove(s2)
        if distance1 < time[0] and distance2 < time[1]:
          # print("both")
          distance = min(distance1, distance2)
          missed_steam = sum(flow_rate[v]*(distance) for v in qu)
          if max_steam-missed_steam > steam:
            # use new, local variables
            tm = [(time[0]-distance1),(time[1]-distance2)]
            st = (tm[0] * flow_rate[s1]) + (tm[1] * flow_rate[s2])
            max_st = max_steam - missed_steam
            [st,pt] = branch_and_bound_duo(flow_rate, matrix, [[s1],[s2]], qu, tm, st, max_st)
            if st > highest_steam:
              highest_steam = st
              best_path = pt
        if distance1 < time[0] and distance2 >= time[1]:
          # print("only 1")
          qu.append(s2)
          missed_steam = sum(flow_rate[v]*(distance1) for v in qu)
          if max_steam-missed_steam > steam:
            # use new, local variables
            tm = (time[0]-distance1)
            st = (tm * flow_rate[s1])
            max_st = max_steam - missed_steam
            [st,pt] = branch_and_bound(flow_rate, matrix, [s1], qu, tm, st, max_st)
            if st > highest_steam:
              highest_steam = st
              best_path = [pt,[]]
        if distance1 >= time[0] and distance2 < time[1]:
          # print("only 2")
          qu.append(s1)
          missed_steam = sum(flow_rate[v]*(distance2) for v in qu)
          if max_steam-missed_steam > steam:
            # use new, local variables
            tm = (time[1]-distance2)
            st = (tm * flow_rate[s2])
            max_st = max_steam - missed_steam
            [st,pt] = branch_and_bound(flow_rate, matrix, [s2], qu, tm, st, max_st)
            if st > highest_steam:
              highest_steam = st
              best_path = [[],pt]

  if best_path:
    [p1,p2] = best_path
    path[0].extend(p1)
    path[1].extend(p2)
    steam += highest_steam
    # print("new top steam: ", steam)
    # print("path 1: ", *path[0])
    # print("path 2: ", *path[1])

  return [steam, path]


if __name__ == "__main__":
  file_path = 'day16/input2.txt'
  adj_map = read_file_and_build_dict(file_path)
  [names,flow_rate,matrix] = get_adj_matrix(adj_map)
  start = names.index('AA')
  print("Part 1")
  [steam, path] = maximise_steam(flow_rate,matrix,start)
  print("Steam: ", steam)
  print(*path)
  _printPath(path, matrix, flow_rate)

  print("Part 2")
  [steam, path] = maximise_steam_eliphant_helper(flow_rate,matrix,start)
  print("Steam: ", steam)
  print("path 1: ", *path[0])
  print("path 2: ", *path[1])

  # 2365 to low
