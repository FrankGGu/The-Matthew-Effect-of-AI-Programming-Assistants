impl Solution {
    pub fn apply_operations(nums: Vec<i32>) -> Vec<i32> {
        let mut result = nums.clone();
        let mut non_zero_index = 0;

        for i in 0..result.len() {
            if result[i] != 0 {
                result[non_zero_index] = result[i];
                non_zero_index += 1;
            }
        }

        while non_zero_index < result.len() {
            result[non_zero_index] = 0;
            non_zero_index += 1;
        }

        result
    }
}