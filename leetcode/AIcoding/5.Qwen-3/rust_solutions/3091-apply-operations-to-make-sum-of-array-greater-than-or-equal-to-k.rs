struct Solution;

impl Solution {
    pub fn min_operations(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut operations = 0;
        while nums.iter().sum::<i32>() < k {
            nums.sort_unstable();
            let first = nums[0];
            let second = nums[1];
            nums[0] = first + second;
            nums.remove(1);
            operations += 1;
        }
        operations
    }
}