impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn nth_magical_number(n: i32, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        heap.push((-k as i64, 1));
        let mut count = 0;
        let mod_val = 10i64.pow(9) + 7;
        let mut result = 0;

        while let Some((val, index)) = heap.pop() {
            result = -val;
            count += 1;
            if count == n {
                break;
            }
            heap.push((-(val + k as i64), index + 1));
        }

        (result % mod_val) as i32
    }
}
}