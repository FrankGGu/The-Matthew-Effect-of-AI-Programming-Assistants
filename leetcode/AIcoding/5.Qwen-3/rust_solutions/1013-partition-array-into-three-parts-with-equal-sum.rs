struct Solution;

impl Solution {
    pub fn can_partition_k_subarrays(nums: Vec<i32>, k: i32) -> bool {
        let total_sum: i32 = nums.iter().sum();
        if total_sum % k != 0 {
            return false;
        }
        let target = total_sum / k;
        let mut current_sum = 0;
        let mut count = 0;
        for num in nums {
            current_sum += num;
            if current_sum == target {
                count += 1;
                current_sum = 0;
            }
        }
        count >= k
    }
}