import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Pattern;

public class Beacon {
    
    public static void main(String[] args){
        int y = 10;
        int x1 = 0, x2 = 0;
        boolean first = true;
        try(BufferedReader in = new BufferedReader(new FileReader("input1.txt"))) {
            Pattern xPattern = Pattern.compile("x=.");
            Pattern yPattern = Pattern.compile("y=.");

            String line = in.readLine();
            while(line != null){
            // 1. get position + manhattan distance
                for(String val : line.split("[, ]")){
                    if(xPattern.matcher(val).matches())
                        System.out.println(val);

                }
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
