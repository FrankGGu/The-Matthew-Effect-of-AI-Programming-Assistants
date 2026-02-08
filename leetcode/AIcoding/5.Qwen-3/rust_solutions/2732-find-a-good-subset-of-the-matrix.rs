impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_good_subset(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut result = vec![];
        let mut used_cols = HashSet::new();

        for r in 0..rows {
            let mut new_row = vec![];
            for c in 0..cols {
                if !used_cols.contains(&c) {
                    new_row.push(matrix[r][c]);
                    used_cols.insert(c);
                }
            }
            if !new_row.is_empty() {
                result.push(new_row);
            }
        }

        result
    }
}
}