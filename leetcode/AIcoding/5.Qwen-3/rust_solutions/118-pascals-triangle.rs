impl Solution {

use std::vec;

struct Solution {}

impl Solution {
    pub fn generate(num_rows: i32) -> Vec<Vec<i32>> {
        let mut result = vec![];
        for i in 0..num_rows {
            let row = match i {
                0 => vec![1],
                1 => vec![1, 1],
                _ => {
                    let prev_row = &result[i as usize - 1];
                    let mut current_row = vec![1];
                    for j in 1..i {
                        current_row.push(prev_row[j as usize - 1] + prev_row[j as usize]);
                    }
                    current_row.push(1);
                    current_row
                }
            };
            result.push(row);
        }
        result
    }
}
}