impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn min_taps(n: i32, ranges: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut arr = vec![0; n + 1];
        for i in 0..n {
            let start = std::cmp::max(0, i as i32 - ranges[i]) as usize;
            let end = std::cmp::min(n, i as i32 + ranges[i]) as usize;
            arr[start] = std::cmp::max(arr[start], end as i32);
        }

        let mut res = 0;
        let mut cur_end = 0;
        let mut next_end = 0;
        for i in 0..n {
            if i > cur_end {
                return -1;
            }
            next_end = std::cmp::max(next_end, arr[i]);
            if i == cur_end {
                res += 1;
                cur_end = next_end;
                if cur_end >= n {
                    break;
                }
            }
        }
        res
    }
}
}