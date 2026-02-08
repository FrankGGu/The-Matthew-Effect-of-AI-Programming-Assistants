struct Solution;

impl Solution {
    pub fn find_indices(nums: Vec<i32>, index_difference: i32, value_difference: i32) -> Vec<i32> {
        let n = nums.len();
        for i in 0..n {
            for j in (i + index_difference as usize)..n {
                if nums[i].abs() - nums[j].abs().abs() >= value_difference {
                    return vec![i as i32, j as i32];
                }
            }
        }
        vec![-1, -1]
    }
}