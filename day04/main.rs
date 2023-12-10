use std::fs;

fn main() {
    // Read the contents of the file into a string
    let input = fs::read_to_string("input.txt").expect("Failed to read file");

    // Split the string into an array of strings
    let lines: Vec<&str> = input.split('\n').collect();

    let mut sum: u64 = 0;

    for line in lines {
        let mut wins = 0;
        let mut winning_nums: Vec<u8> = Vec::new();
               
        // establish the winning numbers
        let mut line = &line[10..];
        let mut i = 0;
        while i < 29 {
            let mut num: u8 = 0;
            let mut j = 0;
            while j < 2 {
                num *= 10;
                let c = line.chars().nth(i+j).unwrap();
                if (c as u8) < 58 && (c as u8) > 47 {
                    num += c as u8 - 48;
                }
                j += 1;
            }
            winning_nums.push(num);
            i += 3;
        }



        // establish the ticket numbers and check for wins
        line = &line[32..];
        i = 0;
        while i<74 {
            let mut num: u8 = 0;
            let mut j = 0;
            while j < 2 {
                num *= 10;
                let c = line.chars().nth(i+j).unwrap();
                if (c as u8) < 58 && (c as u8) > 47 {
                    num += c as u8 - 48;
                }
                j += 1;
            }
            if winning_nums.contains(&num) {
                wins += 1;
            }
            i += 3;
        }
        if wins > 0 {            
            sum += 1 << wins - 1;
        }

        // print!("{:?}", winning_nums);
        // print!("    ");
        // println!("{}", line);
    }
    println!("{}", sum);
}
