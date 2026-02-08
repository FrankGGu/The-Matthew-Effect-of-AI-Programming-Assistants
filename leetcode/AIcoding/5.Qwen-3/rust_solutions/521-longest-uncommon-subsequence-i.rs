impl Solution {

use std::cmp::max;

impl Solution {
    pub fn find_lu_suggestion(a: String, b: String) -> i32 {
        if a == b {
            return -1;
        }
        max(a.len() as i32, b.len() as i32)
    }
}
}