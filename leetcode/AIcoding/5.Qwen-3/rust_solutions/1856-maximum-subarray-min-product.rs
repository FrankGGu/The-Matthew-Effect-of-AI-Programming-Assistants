impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn min_product_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        let mut stack = Vec::new();

        for i in 0..n {
            while let Some(&j) = stack.last() {
                if nums[j] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            left[i] = if stack.is_empty() { -1 } else { stack.last().copied() as i32 };
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while let Some(&j) = stack.last() {
                if nums[j] > nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            right[i] = if stack.is_empty() { n as i32 } else { stack.last().copied() as i32 };
            stack.push(i);
        }

        let mut max_product = 0;
        for i in 0..n {
            let l = left[i] + 1;
            let r = right[i] - 1;
            let count = r - l + 1;
            let sum = (l..=r).map(|j| nums[j as usize]).sum::<i32>();
            max_product = max_product.max(sum * nums[i]);
        }

        max_product
    }
}
}