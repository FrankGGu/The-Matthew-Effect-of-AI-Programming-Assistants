pub struct Solution;

impl Solution {
    pub fn first_bad_version(&self, n: i32) -> i32 {
        let mut left = 1;
        let mut right = n;
        while left < right {
            let mid = left + (right - left) / 2;
            if is_bad_version(mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }
}

fn is_bad_version(version: i32) -> bool {
    // This function is defined by LeetCode and not part of the solution
    // It is used to check if a version is bad
    // For the purpose of this code, it is assumed to be available
    unimplemented!()
}