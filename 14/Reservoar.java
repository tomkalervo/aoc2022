import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class Reservoar{
    public static void printMap(char[][] map){
            for(char[] line : map){
                for(char c : line){
                    System.out.print(c);
                }
                System.out.println("");
            }
    }
    public static boolean pourSand(char[][] map, int[] rest){
        try {
            int[] addSand = sand(map, rest);
            if(addSand[0] == rest[0] && rest[1] == addSand[1]){
                map[rest[1]][rest[0]] = 'o';
                return true;
            }
            else{
                return pourSand(map, addSand);
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Sand falls into bottomless pit.");
            return false;
        }
   
    }
    public static int[] sand(char[][] map, int[] start) throws ArrayIndexOutOfBoundsException{
        int[] pos = new int[start.length];
        for(int i = 0; i < pos.length; i++)
            pos[i] = start[i];
            
        if(map[pos[1]+1][pos[0]] == '.'){
            pos[1]++;
            return pos;
        }
        else if(map[pos[1]+1][pos[0]-1] == '.'){
            pos[1]++;
            pos[0]--;
            return pos;
        }
        else if(map[pos[1]+1][pos[0]+1] == '.'){
            pos[1]++;
            pos[0]++;
            return pos;
        }
        
        return pos;
    }
    public static char[][] addFlooring(char[][] map){
        int rows = map.length + 2;
        int cols = map[0].length;
    
        char[][] newMap = new char[rows][cols];

        for(int i = 0; i < map.length; i++){
            for(int j = 0; j < map[0].length; j++){
                newMap[i][j] = map[i][j];
            }
        }
        for(int i = map.length; i < newMap.length; i++)
            for(int j = 0; j < newMap[0].length; j++){
                newMap[i][j] = i == newMap.length - 1 ? '#' : '.';
            }

        return newMap;
    }
    public static char[][] widerFloor(char[][] map){
        int rows = map.length;
        int extraWidth = 4;
        int cols = map[0].length + extraWidth;
        /**
         * [.][.][x][x][x][x][.][.]
         * [.][.][x][x][x][x][.][.]
         * [.][.][x][x][x][x][.][.]
         */
    
        char[][] newMap = new char[rows][cols];
        for(int i = 0; i < rows-1; i++){
            for(int j = 0; j < cols; j++){
                if(inRange(j, extraWidth/2, cols-(extraWidth/2)-1)){
                    newMap[i][j] = map[i][j-(extraWidth/2)];
                }
                else{
                    newMap[i][j] = '.';
                }
            }
        }
        for(int i = 0; i < cols; i++)
            newMap[rows-1][i] = '#';

        return newMap;
    }
    public static boolean inRange(int num, int first, int last){
        if(num >= first && num <= last)
            return true;
        else 
            return false;
    }
    public static void main(String[] args){
        char[][] map = null;
        int startingPos = 0;
        // Handle input
        try(BufferedReader in = new BufferedReader(new FileReader("input2.txt"))) {
            String line = in.readLine();
            int low = 0;
            int high = 0;
            int depth = 0;
            boolean first = true;
            Queue<int[]> rocks = new LinkedList<>();

            // First round, get info
            while(line != null){
                int xPrev = -1, yPrev = -1;
                for(String rock : line.split(" -> ")){                        
                        int xVal = Integer.parseInt(rock.split(",")[0]);
                        int yVal = Integer.parseInt(rock.split(",")[1]);

                        if(first){
                            low = xVal;
                            high = xVal;
                            first = false;
                        }else{
                            if(xVal < low)
                                low = xVal;
                            else if(xVal > high)
                                high = xVal;
                        }
                        if(yVal > depth)
                            depth = yVal;

                        if(!(xPrev == -1 && yPrev == -1)){
                            int[] tmp = {xPrev,yPrev,xVal,yVal};
                            rocks.add(tmp);
                        }
                        xPrev= xVal; 
                        yPrev = yVal;
                    }
                line = in.readLine();
            }
            System.out.println(String.format("Low: %d, High: %d, Depth: %d", low, high, depth));

            // Second round, build layout
            map = new char[depth+1][(high-low)+1];
            for(int i = 0; i < depth+1; i++)
                for(int j = 0; j < (high-low)+1; j++)
                    map[i][j] = '.';

            for(int[] pair : rocks){
                //System.out.println(String.format("Pair: {%d,%d} & {%d,%d}", pair[0], pair[1], pair[2], pair[3]));
                int start, stop;
                if(pair[0] == pair[2]){     // vertical line
                    if(pair[1] < pair[3]){
                        start = pair[1];
                        stop = pair[3];
                    }
                    else{
                        start = pair[3];
                        stop = pair[1];
                    }
                    for(int row = start; row <= stop; row++)
                        map[row][pair[0]-low] = '#';
                }
                else{                       // horisontal line
                    if(pair[0] < pair[2]){
                        start = pair[0];
                        stop = pair[2];
                    }
                    else{
                        start = pair[2];
                        stop = pair[0];
                    }
                    for(int col = start; col <= stop; col++)
                        map[pair[1]][col-low] = '#';
                }

            }
            startingPos = low;
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // Check and print starting map
        if(map == null)
            System.exit(1);
        printMap(map);

        // Task 1
        int[] rest = {500-startingPos, 0};
        int amountOfSand = 0;
        while(pourSand(map, rest)){
            amountOfSand++;
            //printMap(map);
            rest[0] = 500-startingPos;
            rest[1] = 0;
        }
        printMap(map);
        System.out.println(String.format("Added %d amount of sand.", amountOfSand));

        // Task 2
        System.out.println("");
        map = addFlooring(map);
        map = widerFloor(map);
        startingPos -= 2;

        printMap(map);

        rest[0] = 500-startingPos;
        rest[1] = 0;
        while(map[rest[1]][rest[0]] != 'o'){
            if(pourSand(map, rest)){
                amountOfSand++;
            }
            else{
                map = widerFloor(map);
                startingPos -= 2;
            }
            rest[0] = 500-startingPos;
            rest[1] = 0;
        }

        printMap(map);
        System.out.println(String.format("Added %d amount of sand.", amountOfSand));
    }
}