struct Solution;

impl Solution {
    pub fn is_good(nums: Vec<i32>) -> bool {
        let n = nums.len() as i32;
        let mut freq = vec![0; (n + 1) as usize];

        for &num in &nums {
            if num < 1 || num > n {
                return false;
            }
            freq[num as usize] += 1;
        }

        for i in 1..n as usize {
            if freq[i] != 1 {
                return false;
            }
        }

        true
    }
}