struct Solution;

impl Solution {
    pub fn is_three_consecutive_odds(arr: Vec<i32>) -> bool {
        for i in 0..arr.len() - 2 {
            if arr[i] % 2 == 1 && arr[i + 1] % 2 == 1 && arr[i + 2] % 2 == 1 {
                return true;
            }
        }
        false
    }
}