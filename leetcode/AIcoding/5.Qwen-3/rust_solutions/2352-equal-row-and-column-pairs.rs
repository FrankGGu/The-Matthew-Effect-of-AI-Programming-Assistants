impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn equal_pairs(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut row_counts = HashMap::new();

        for row in &grid {
            let key = row.clone();
            *row_counts.entry(key).or_insert(0) += 1;
        }

        let mut count = 0;

        for j in 0..n {
            let mut column = Vec::with_capacity(n);
            for i in 0..n {
                column.push(grid[i][j]);
            }
            if let Some(&c) = row_counts.get(&column) {
                count += c;
            }
        }

        count
    }
}
}