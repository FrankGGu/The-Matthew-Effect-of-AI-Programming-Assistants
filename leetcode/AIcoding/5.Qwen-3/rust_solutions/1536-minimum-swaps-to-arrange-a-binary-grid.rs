impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_swaps(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut rows = vec![0; n];

        for i in 0..n {
            let mut count = 0;
            for j in (0..n).rev() {
                if grid[i][j] == 1 {
                    break;
                }
                count += 1;
            }
            rows[i] = count;
        }

        let mut res = 0;
        for i in 0..n {
            let target = n - 1 - i;
            let mut j = i;
            while j < n && rows[j] < target {
                j += 1;
            }
            if j == n {
                return -1;
            }
            res += j - i;
            for k in j..i + 1 {
                rows[k] = rows[k - 1];
            }
        }

        res
    }
}
}