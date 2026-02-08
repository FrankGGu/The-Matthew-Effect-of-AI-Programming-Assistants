impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_square_area(mut fences: Vec<i32>, mut k: i32) -> i32 {
        fences.sort();
        let n = fences.len();
        let mut set = HashSet::new();
        for i in 0..n {
            for j in i + 1..n {
                set.insert(fences[j] - fences[i]);
            }
        }
        let mut sorted = set.into_iter().collect::<Vec<_>>();
        sorted.sort();
        let m = sorted.len();
        for i in (0..m).rev() {
            if k == 0 {
                return sorted[i] * sorted[i];
            }
            for j in 0..i {
                if sorted[i] - sorted[j] <= k {
                    return sorted[i] * sorted[i];
                }
            }
        }
        0
    }
}
}