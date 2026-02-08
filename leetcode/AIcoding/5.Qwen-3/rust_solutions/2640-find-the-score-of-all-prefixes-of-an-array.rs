struct Solution;

impl Solution {
    pub fn find_prefix_scores(nums: Vec<i32>) -> Vec<i32> {
        let mut score = 0;
        let mut result = Vec::with_capacity(nums.len());
        for &num in &nums {
            score += num;
            result.push(score);
        }
        result
    }
}