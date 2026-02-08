impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_equal_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut heap1 = BinaryHeap::new();
        let mut heap2 = BinaryHeap::new();

        for num in nums1 {
            if num != 0 {
                heap1.push(num);
            }
        }

        for num in nums2 {
            if num != 0 {
                heap2.push(num);
            }
        }

        let mut sum1 = nums1.iter().filter(|&&x| x != 0).sum::<i32>();
        let mut sum2 = nums2.iter().filter(|&&x| x != 0).sum::<i32>();

        while !heap1.is_empty() && !heap2.is_empty() {
            let val1 = *heap1.peek().unwrap();
            let val2 = *heap2.peek().unwrap();

            if val1 == val2 {
                return val1;
            } else if val1 < val2 {
                sum1 += val1;
                heap1.pop();
            } else {
                sum2 += val2;
                heap2.pop();
            }
        }

        if heap1.is_empty() && heap2.is_empty() {
            return 0;
        } else if heap1.is_empty() {
            return sum2;
        } else {
            return sum1;
        }
    }
}
}