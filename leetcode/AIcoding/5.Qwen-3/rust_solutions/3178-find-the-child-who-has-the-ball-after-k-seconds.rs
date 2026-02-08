struct Solution {}

impl Solution {
    pub fn find_child_after_k_seconds(n: i32, k: i32) -> i32 {
        let mut current = 0;
        for _ in 0..k {
            current = (current + 1) % n;
        }
        current
    }
}