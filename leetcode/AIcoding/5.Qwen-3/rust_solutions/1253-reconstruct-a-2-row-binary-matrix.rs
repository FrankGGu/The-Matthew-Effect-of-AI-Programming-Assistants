impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_2_row_binary_matrix(vec: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut row1 = vec![0; vec.len()];
        let mut row2 = vec![0; vec.len()];
        let mut ones = 0;

        for i in 0..vec.len() {
            if vec[i] == 0 {
                continue;
            }
            if ones < k {
                row1[i] = 1;
                ones += 1;
            } else {
                row2[i] = 1;
            }
        }

        let mut count = 0;
        for i in 0..vec.len() {
            if row1[i] + row2[i] != vec[i] {
                return vec![];
            }
            if row1[i] == 1 {
                count += 1;
            }
        }

        if count != k {
            return vec![];
        }

        vec![row1, row2]
    }
}
}