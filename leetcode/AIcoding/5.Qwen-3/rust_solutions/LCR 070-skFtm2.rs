struct Solution {}

impl Solution {
    pub fn single_non_duplicate(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left < right {
            let mid = left + (right - left) / 2;
            if mid % 2 == 1 {
                let temp = mid - 1;
                if nums[temp] == nums[mid] {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            } else {
                let temp = mid + 1;
                if nums[temp] == nums[mid] {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }

        nums[left]
    }
}