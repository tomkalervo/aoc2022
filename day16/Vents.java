import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Vents {
        class Vent{
            final String name;
            final int steam;
            int timeLeft = 0;
            Vent path = null;
            boolean open = false;
            boolean visited = false;
            List<String> connections;
            HashMap<String, Integer> distances;

            public Vent(String name, int steam){
                this.name = name;
                this.steam = steam;
                this.connections = new LinkedList<>();
                this.distances = new HashMap<>();
            }

            public int getDistance(String name){
                if(this.distances.containsKey(name)){
                    return this.distances.get(name);
                }
                else{
                    return -1;
                }
            }

            public void printDistances(){
                this.distances.forEach((name, d) -> {
                    System.out.println(String.format("[%s,%s] = %d", this.name, name, d));
                });
            }
            public void setDistance(String name, int d){
                this.distances.put(name, d);
            }

            public void removeFromDistance(String name){
                this.distances.remove(name);
            }

            public boolean isVisited() {
                return visited;
            }

            public void setVisited(boolean visited) {
                this.visited = visited;
            }

            public boolean isOpen() {
                return open;
            }

            public void setOpen(boolean open) {
                this.open = open;
            }

            public int gettimeLeft() {
                return timeLeft;
            }

            public void settimeLeft(int timeLeft) {
                this.timeLeft = timeLeft;
            }

            public Vent getPath() {
                return path;
            }

            public void setPath(Vent path) {
                this.path = path;
            }

            public void addConnection(String c){
                this.connections.add(c);
            }
            public void removeConnection(String c){
                this.connections.remove(c);
            }

            public List<String> getConnections(){
                return new LinkedList<>(connections);
            }

            public int getSteam(){
                return this.steam;
            }

            public String getName(){
                return this.name;
            }

            public String toString(){
                StringBuilder tmp = new StringBuilder();
                tmp.append(String.format("Vent name: %s\nVent steam: %d\nVent connections: ", this.name, this.steam));
                for(String c : this.connections)
                    tmp.append(" [" + c + "]");

                tmp.append(String.format("\nVent open: %b, Time left: %d, Gives steam of %d", this.open, this.timeLeft, this.steam*this.timeLeft));
                return tmp.toString();
            }
        }

        public static void updateDistances(HashMap<String, Vent> map, Vent s){
            Queue<Vent> pQueue = new LinkedList<>();
            int d = 0;
            pQueue.add(s);
            s.setVisited(true);
            do{
                Queue<Vent> nextQueue = new LinkedList<>();
                d++;
                for(Vent v : pQueue){
                    for(String n : v.getConnections()){
                        if(!map.get(n).isVisited()){
                            nextQueue.add(map.get(n));
                            map.get(n).setVisited(true);

                            if(s.getDistance(n) == -1 || (s.getDistance(n) > d)){
                                s.setDistance(n, d);
                                s.addConnection(n);
                                s.removeConnection(n);
                                // System.out.println(String.format("Distance from %s to %s is %d", s.getName(), n, d));
                            }

                        }
                    }
                }
                pQueue = nextQueue;
            }while(!pQueue.isEmpty());

            map.forEach((name, vent) -> {
                vent.setVisited(false);
            });
        }

        public static void slimGraph(HashMap<String, Vent> map){
            HashMap<String, Vent> keep = new HashMap<>();
            List<String> remove = new LinkedList<>();
            map.forEach((name, vent) -> {
                if(vent.getSteam() == 0 && !name.equalsIgnoreCase("AA"))
                    remove.add(name);
                else
                    keep.put(name, vent);
            });

            keep.forEach((name, vent) -> {
                for(String n : remove){
                    vent.removeFromDistance(n);
                }
            });
            map = keep;
        }
        public static int path(HashMap<String, Vent> map, LinkedList<Vent> path, int time, int steam){
            Queue<Vent> pQueue = new LinkedList<>();
            for(String next : map.get(path.getLast()).get)
            if(pQueue.isEmpty() || time == 0)
                return steam;
            else{

            }
        }

        public static Queue<Vent> maxFlowPath(HashMap<String, Vent> map, String start){
            Queue<Vent> path = new LinkedList<>();
            Queue<Vent> pQueue = new LinkedList<>();
            int time = 30;
            Vent s = map.get(start);
            s.settimeLeft(time);
            pQueue.add(s);
            path.add(s);
            s.setVisited(true);

            while(time > 0){
                Vent g = pQueue.remove();
                // Open valve

                // move
            }


            return path;
        }

        // Bad logic
        public static Queue<Vent> maxFlowPathOld(HashMap<String, Vent> map, String start){

            // map.forEach((name, vent) -> {
            //     vent.printDistances();
            // });
            Queue<Vent> path = new LinkedList<>();
            Queue<Vent> pQueue = new LinkedList<>();
            int time = 30;
            Vent s = map.get(start);
            s.settimeLeft(time);
            pQueue.add(s);
            s.setVisited(true);

            do{
                Vent next = null;
                do{
                    s = pQueue.remove();
                    time = s.gettimeLeft() - 1;
                    if(time < 1)
                        break;
                    // System.out.println("\t***");
                    // System.out.println("\tAt " + s.getName() + ", time left " + time);
                    // System.out.println("\t***");

                    if(!s.isOpen()){
                        //Compare w/ next
                        if(next != null){
                            if(s.getSteam() != 0){
                                int distance    = s.getDistance(next.getName());
                                int prevFlow    = (s.getSteam()*(time-1)) + (next.getSteam() * next.gettimeLeft());
                                int newFlow     = (s.getSteam()*(time));
                                newFlow = (time-1 - distance) > 0 ? newFlow + (next.getSteam() * (time-1 - distance)) : newFlow;
                                
                                // System.out.println("Comparing " + s.getName() + " with " + next.getName() + " at time " + time);
                                // System.out.println(String.format("newFlow: %d, prevFlow: %d", newFlow, prevFlow));
                                // System.out.println(String.format("next vent steam: %d, time at next vent: %d, distance to s: %d", next.getSteam(), next.gettimeLeft(), distance));
                                if(newFlow > prevFlow){
                                    next = s;
                                    next.settimeLeft(time);
                                }
                            }
                        }
                        else{
                            next = s;
                            next.settimeLeft(time);
                        }
                    }
                    for(String name : s.getConnections()){
                        Vent v = map.get(name);
                        if(!v.isVisited()){
                            v.settimeLeft(time);
                            pQueue.add(v);
                            v.setVisited(true);
                        }
                    }
                }while(!pQueue.isEmpty());
                if(next == null)
                    break;
                next.setOpen(true);
                map.forEach((name, vent) -> {
                    vent.setVisited(false);
                });
                pQueue.add(next);
                path.add(next);
                System.out.println(String.format("Open vent %s, release a total of %d steam. Time left: %d", 
                    next.getName(), (next.getSteam()*next.gettimeLeft()), next.gettimeLeft()));
            }while(time > 0);

            return path;
        }

        private static int countSteam(Queue<Vent> path, Vent ventA) {
            int steam = 0;
            int time = 30;
            do{
                Vent ventB = path.remove();
                time -= ventA.getDistance(ventB.getName());
                time--;
                steam += (ventB.getSteam() * time);
                ventA = ventB;
            }while(!path.isEmpty());

            return steam;
        }

    public static void main(String[] args){
        HashMap<String, Vent> map = new HashMap<>();
        Vents vents = new Vents();
        try(BufferedReader in = new BufferedReader(new FileReader("input1.txt"))) {
        
            // Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
            // 0     1  2   3    4        5       6   7  8      9 ...     
            String line = in.readLine();
            int name = 1;
            int steam = 4;
            int valves = 9;
            while(line != null){
                String[] info = line.split("[ ]");
                // for(String n : info)
                //     System.out.print("[" + n + "] ");
                // System.out.println("");
                // rate=0;
                // 0    1
                Vent tmp = vents.new Vent(info[name], Integer.parseInt(info[steam].split("[=;]")[1]));
                for(int i = valves; i < info.length; i++)
                    tmp.addConnection(info[i].substring(0,2));
                map.put(info[name], tmp);

                line = in.readLine();
            }

        }catch(FileNotFoundException e){
            System.err.println(e.getLocalizedMessage());
        }catch(IOException e){
            System.err.println(e.getLocalizedMessage());
        }

        map.forEach((name, vent) -> {
            updateDistances(map, vent);
        });
        slimGraph(map);
        String start = "AA";
        Queue<Vent> path = maxFlowPath(map, start);
        System.out.println("Completed calculating max flow path");
        int totalSteam = countSteam(path, map.get(start));
        System.out.println("Total steam: " + totalSteam);

        // map.forEach((name, vent) -> {
        //     System.out.println(vent.toString());
        // });

    }


}
