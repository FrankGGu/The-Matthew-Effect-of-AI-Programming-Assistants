impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn most_frequent_prime(matrix: Vec<Vec<i32>>) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut result = 0;

        for r in 0..rows {
            for c in 0..cols {
                for dr in [-1, 0, 1] {
                    for dc in [-1, 0, 1] {
                        if dr == 0 && dc == 0 {
                            continue;
                        }
                        let mut num = 0;
                        let mut x = r;
                        let mut y = c;
                        while x >= 0 && x < rows as isize && y >= 0 && y < cols as isize {
                            num = num * 10 + matrix[x as usize][y as usize];
                            *freq.entry(num).or_insert(0) += 1;
                            if *freq.get(&num).unwrap() > max_freq {
                                max_freq = *freq.get(&num).unwrap();
                                result = num;
                            } else if *freq.get(&num).unwrap() == max_freq && num < result {
                                result = num;
                            }
                            x += dr;
                            y += dc;
                        }
                    }
                }
            }
        }

        result
    }
}
}