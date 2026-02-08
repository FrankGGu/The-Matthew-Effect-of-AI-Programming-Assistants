impl Solution {
    pub fn remove_duplicates(nums: &mut Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut index = 1;
        let mut count = 1;

        for i in 1..nums.len() {
            if nums[i] == nums[i - 1] {
                count += 1;
            } else {
                count = 1;
            }

            if count <= 2 {
                nums[index] = nums[i];
                index += 1;
            }
        }

        index as i32
    }
}