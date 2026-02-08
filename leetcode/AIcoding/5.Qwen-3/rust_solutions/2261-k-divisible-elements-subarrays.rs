struct Solution;

impl Solution {
    pub fn k_divisible_elements_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut count = 0;
        for i in 0..n {
            let mut current = 0;
            for j in i..n {
                current = current * 10 + nums[j];
                if current % k == 0 {
                    count += 1;
                }
            }
        }
        count as i32
    }
}