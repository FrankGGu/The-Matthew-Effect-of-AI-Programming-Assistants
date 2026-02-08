struct Solution;

impl Solution {
    pub fn find132pattern(nums: Vec<i32>) -> bool {
        let mut stack = Vec::new();
        let mut third = i32::MIN;

        for &num in nums.iter().rev() {
            if num < third {
                return true;
            }
            while let Some(&top) = stack.last() {
                if num > top {
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(num);
        }

        false
    }
}