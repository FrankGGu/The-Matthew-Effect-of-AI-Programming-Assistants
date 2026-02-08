struct Solution;

impl Solution {
    pub fn occurrences_of_element(nums: Vec<i32>, x: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == x {
                result.push(i as i32);
            }
        }
        result
    }
}