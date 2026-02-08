impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn count_smaller(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut indexed_nums = nums.iter().enumerate().collect::<Vec<_>>();

        Self::merge_sort(&mut indexed_nums, 0, n as isize, &mut result);

        result
    }

    fn merge_sort(nums: &mut Vec<(&usize, &i32)>, left: isize, right: isize, result: &mut Vec<i32>) {
        if left >= right {
            return;
        }

        let mid = left + (right - left) / 2;
        Self::merge_sort(nums, left, mid, result);
        Self::merge_sort(nums, mid + 1, right, result);
        Self::merge(nums, left, mid, right, result);
    }

    fn merge(nums: &mut Vec<(&usize, &i32)>, left: isize, mid: isize, right: isize, result: &mut Vec<i32>) {
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        let mut temp = Vec::new();

        while i <= mid && j <= right {
            match nums[i].1.cmp(nums[j].1) {
                Ordering::Less => {
                    temp.push(nums[i]);
                    i += 1;
                },
                Ordering::Equal => {
                    temp.push(nums[i]);
                    i += 1;
                },
                Ordering::Greater => {
                    result[nums[j].0] += (mid - i + 1) as i32;
                    temp.push(nums[j]);
                    j += 1;
                }
            }
        }

        while i <= mid {
            temp.push(nums[i]);
            i += 1;
        }

        while j <= right {
            temp.push(nums[j]);
            j += 1;
        }

        for m in 0..temp.len() {
            nums[k as usize] = temp[m];
            k += 1;
        }
    }
}
}