import java.util.Arrays;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(new java.io.File("input.txt"));

        String seedsLine = scanner.nextLine();


        String[] temp = seedsLine.substring(seedsLine.indexOf(":")+2).split(" ");

        long[] seeds = Arrays.stream(temp).mapToLong(Long::parseLong).toArray();
        
        map[][] steps = new map[7][];
        for(int i = 0; i < 7; i++) {
            scanner.nextLine();
            scanner.nextLine();
            int mapLength = 0;
            String[] maxLines = new String[100];
            while(scanner.hasNextLong()) {
                maxLines[mapLength] = scanner.nextLine();
                mapLength++;
            }
            steps[i] = new map[mapLength];
            for(int j = 0; j < mapLength; j++) {
                String[] line = maxLines[j].split(" ");
                steps[i][j] = new map(Long.parseLong(line[1]), Long.parseLong(line[0]), Long.parseLong(line[2]));
            }
        }

        long min = Long.MAX_VALUE;

        for(long seed : seeds) {
            long current = seed;
            for(int i = 0; i < 7; i++) {
                current = mapValue(steps[i], current);
            }
            if(current < min) {
                min = current;
            }
        }
        

        System.out.println("Part 1: " + min);
        min = Long.MAX_VALUE;
        for(int i = 0; i < seeds.length; i+=2) {
            for (long j = seeds[i]; j<seeds[i]+seeds[i+1]; j++) {
                long current = j;
                for(int k = 0; k < 7; k++) {
                    current = mapValue(steps[k], current);
                }
                if(current < min) {
                    min = current;
                }
            }
        }
        
        System.out.println("Part 2: " + min);
        scanner.close();
    }

    // Map a value using the provided mappings
    private static long mapValue(map[] mappings, long value) {
        for (map m : mappings) {
            long mappedValue = m.getMapped(value);
            if (mappedValue != value) {
                return mappedValue;
            }
        }
        return value; // Return the same value if no mapping is found
    }
}

class map {
    long source;
    long destination;
    long length;

    public map(long source, long destination, long length) {
        this.source = source;
        this.destination = destination;
        this.length = length;
    }

    public long getMapped(long start) {
        if (start >= source && start < source + length) {
            return destination + start - source;
        }
        return start;
    }
}