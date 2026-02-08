impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_v_shaped_diagonal_segment(matrix: Vec<Vec<i32>>) -> i32 {
        let rows = matrix.len();
        if rows == 0 {
            return 0;
        }
        let cols = matrix[0].len();
        if cols == 0 {
            return 0;
        }

        let mut diag_map: HashMap<(i32, i32), Vec<i32>> = HashMap::new();

        for i in 0..rows {
            for j in 0..cols {
                let key = (i - j, i + j);
                diag_map.entry(key).or_insert_with(Vec::new).push(matrix[i][j]);
            }
        }

        let mut max_len = 0;

        for (_, vec) in diag_map {
            let mut count = 1;
            let mut max_count = 1;
            for i in 1..vec.len() {
                if vec[i] > vec[i - 1] {
                    count += 1;
                    max_count = std::cmp::max(max_count, count);
                } else {
                    count = 1;
                }
            }
            max_len = std::cmp::max(max_len, max_count);
        }

        max_len
    }
}
}