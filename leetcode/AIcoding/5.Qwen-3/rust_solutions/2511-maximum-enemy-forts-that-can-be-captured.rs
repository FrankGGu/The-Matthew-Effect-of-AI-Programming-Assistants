impl Solution {

use std::cmp;

impl Solution {
    pub fn capture_forts(forts: Vec<i32>) -> i32 {
        let mut max_captured = 0;
        let mut left = -1;

        for (i, &fort) in forts.iter().enumerate() {
            if fort == 1 {
                if left != -1 && forts[left as usize] == -1 {
                    max_captured = cmp::max(max_captured, i as i32 - left - 1);
                }
                left = i as i32;
            }
        }

        max_captured
    }
}
}