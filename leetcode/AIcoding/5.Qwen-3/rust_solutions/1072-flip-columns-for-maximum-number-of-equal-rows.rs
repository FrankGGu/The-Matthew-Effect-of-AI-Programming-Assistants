impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_equal_rows_after_flips(matrix: Vec<Vec<i32>>) -> i32 {
        let mut pattern_count = HashMap::new();
        for row in matrix {
            let mut pattern = Vec::new();
            for (i, &val) in row.iter().enumerate() {
                if i == 0 {
                    pattern.push(val);
                } else {
                    pattern.push(if val == row[0] { 0 } else { 1 });
                }
            }
            *pattern_count.entry(pattern).or_insert(0) += 1;
        }
        *pattern_count.values().max().unwrap()
    }
}
}