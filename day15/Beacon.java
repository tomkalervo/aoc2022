import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import java.util.regex.Pattern;

public class Beacon {
    
    public static void main(String[] args){
        int y = 10;
        int startOfX = 0;
        int[] row = new int[10];
        boolean first = true;
        try(BufferedReader in = new BufferedReader(new FileReader("input1.txt"))) {
            Pattern xPattern = Pattern.compile("[x=].*");
            Pattern yPattern = Pattern.compile("[y=].*");

            String line = in.readLine();
            while(line != null){
                // 1. get position + manhattan distance
                Queue<Integer> xyPairs = new LinkedList<>();
                for(String val : line.split("[, :]")){
                    if(xPattern.matcher(val).matches()){
                        //System.out.println(val.substring(2));
                        xyPairs.add(Integer.parseInt(val.substring(2)));
                    }
                    else if(yPattern.matcher(val).matches()){
                        //System.out.println(val);
                        xyPairs.add(Integer.parseInt(val.substring(2)));
                    }
                }
                int x1 = xyPairs.remove();
                int y1 = xyPairs.remove();
                int x2 = xyPairs.remove();
                int y2 = xyPairs.remove();
                System.out.println(String.format("{x1,y1} = {%d,%d}, {x2,y2} = {%d,%d}", x1,y1,x2,y2));
            // 2. mark all coordinates on inspected row that is within the manhattan distance

                line = in.readLine();
            }


        }catch(FileNotFoundException e){
            System.err.println(e.getLocalizedMessage());
        }catch(IOException e){
            System.err.println(e.getLocalizedMessage());
        }

    }
}
