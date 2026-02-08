impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_domino_rotations(row1: Vec<i32>, row2: Vec<i32>) -> i32 {
        let mut candidates = HashSet::new();
        candidates.insert(row1[0]);
        candidates.insert(row2[0]);

        for i in 0..row1.len() {
            let mut possible = false;
            if row1[i] == row2[0] || row1[i] == row2[1] {
                possible = true;
            }
            if row2[i] == row2[0] || row2[i] == row2[1] {
                possible = true;
            }
            if !possible {
                return -1;
            }
        }

        let mut min_rotations = i32::MAX;
        for &candidate in &candidates {
            let mut rotate_row1 = 0;
            let mut rotate_row2 = 0;
            for i in 0..row1.len() {
                if row1[i] != candidate {
                    rotate_row1 += 1;
                }
                if row2[i] != candidate {
                    rotate_row2 += 1;
                }
            }
            min_rotations = min_rotations.min(rotate_row1).min(rotate_row2);
        }

        min_rotations
    }
}
}