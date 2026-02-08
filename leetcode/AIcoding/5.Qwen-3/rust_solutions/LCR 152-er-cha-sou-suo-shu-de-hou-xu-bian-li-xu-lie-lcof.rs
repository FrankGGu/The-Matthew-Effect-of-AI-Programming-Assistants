struct Solution;

impl Solution {
    pub fn verify_postorder(nums: Vec<i32>) -> bool {
        let mut stack = vec![];
        let mut root = i32::MAX;

        for &num in nums.iter().rev() {
            if num > root {
                return false;
            }
            while let Some(&top) = stack.last() {
                if num < top {
                    root = top;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(num);
        }

        true
    }
}