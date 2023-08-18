import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.regex.Pattern;

public class Beacon {
    public static int getDistance(int x1, int y1, int x2, int y2){
        return Math.abs(x1-x2) + Math.abs(y1-y2);
    }
    public static List<int[]> getPairs(String input){
        List<int[]> pairs = new LinkedList<>();
        try(BufferedReader in = new BufferedReader(new FileReader(input))) {
            Pattern xPattern = Pattern.compile("[x=].*");
            Pattern yPattern = Pattern.compile("[y=].*");
            String line = in.readLine();
            while(line != null){
                // 1. get position + manhattan distance
                int[] newPair = new int[4];
                int i = 0;
                for(String val : line.split("[, :]")){
                    if(xPattern.matcher(val).matches()){
                        newPair[i++] = Integer.parseInt(val.substring(2));
                    }
                    else if(yPattern.matcher(val).matches()){
                        newPair[i++] = Integer.parseInt(val.substring(2));
                    }
                }
                pairs.add(newPair);
                line = in.readLine();
            }
        }catch(FileNotFoundException e){
            System.err.println(e.getLocalizedMessage());
        }catch(IOException e){
            System.err.println(e.getLocalizedMessage());
        }
        return pairs;
    }
    public static List<int[]> getPositions(int y, boolean info, List<int[]> pairs){
        if(info)
            System.out.println("Checking row: " + y);
        List<int[]> xValues = new LinkedList<>();
        List<Integer> xBeacons = new LinkedList<>();        
        
        boolean first = true;
        for(int i = 0; i < pairs.size(); i++){
            // 1. get position + manhattan distance
            int x1 = pairs.get(i)[0];
            int y1 = pairs.get(i)[1];
            int x2 = pairs.get(i)[2];
            int y2 = pairs.get(i)[3];
            int distance = getDistance(x1,y1,x2,y2);

            // 2. mark all coordinates on inspected row that is within the manhattan distance
            distance -= Math.abs(y - y1); 
            //System.out.println(String.format("Manhattan distance is %d from {%d,%d}", distance, x1,y));

            if(distance >= 0){
                int xStart = x1-distance;
                int xEnd = x1+distance;
                int[] interval = {xStart, xEnd};
                xValues.add(interval);
            }

            if(y == y2){
                if(!xBeacons.contains(x2))
                    xBeacons.add(x2);
            }

        }

        xValues.sort(new Comparator<int[]>() {

            @Override
            public int compare(int[] o1, int[] o2) {
                return Integer.compare(o1[0],o2[0]);
            }
            
        });

        List<int[]> tmp = new LinkedList<>();
        for(int[] x : xValues){
            if(tmp.size() == 0)
                tmp.add(x);
            else{
                int[] xPrev = tmp.get(tmp.size()-1);
                if(xPrev[1] < x[0])
                    tmp.add(x);
                else{
                    xPrev[1] = x[1] > xPrev[1] ? x[1] : xPrev[1];
                    tmp.set(tmp.size()-1, xPrev);
                }
            }
        }
        xValues = tmp;
        int positions = 1; // count x = 0 as 1 position
        for(int[] x : xValues){
            if(info)
                System.out.print(String.format("{%d, %d} ", x[0], x[1]));
            positions += (x[1]-x[0]);
        }
        positions -= xBeacons.size();
        if(info)
            System.out.println("\nPositions: " + positions + ", Beacons: " + xBeacons.size());

        return xValues;
    }
    public static void main(String[] args){
        String in = "input2.txt";
        // Task 1
        int y = 2000000;
        System.out.println("Getting Pairs");
        List<int[]> pairs = getPairs(in);
        System.out.println("Got Pairs");
        List<int[]> xValues = getPositions(y, true, pairs);

        // Task 2
        int yMax = 2*y;
        y = 0;
        do{
            xValues = getPositions(y, false, pairs);
            if(xValues.size() > 1)
                break;

        }while(++y < yMax);

        System.out.println("two intervals found at y: " + y);

        // Only one possible free position is supposed to exist
        // Gambling on that it exists between two intervals and not on an edge
        int freeX = xValues.get(0)[1] + 1;
        assert(freeX == xValues.get(1)[0] - 1);

        System.out.println(String.format("Free spot is in {%d,%d}", freeX, y));

        long freq = ((long)freeX * 4000000) + y;
        System.out.println("Frequency is \t" + freq);

    }
}
