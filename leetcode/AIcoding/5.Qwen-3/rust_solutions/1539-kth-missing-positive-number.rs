struct Solution;

impl Solution {
    pub fn find_kth_missing_positive(arr: Vec<i32>, k: i32) -> i32 {
        let mut left = 0;
        let mut right = arr.len() as i32 - 1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let missing = arr[mid] - mid - 1;

            if missing < k {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        left as i32 + k
    }
}