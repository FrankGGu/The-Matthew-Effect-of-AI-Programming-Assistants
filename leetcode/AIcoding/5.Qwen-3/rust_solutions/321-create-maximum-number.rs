impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_number(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut result = vec![];
        let len1 = nums1.len();
        let len2 = nums2.len();

        for i in 0..=k {
            if i > len1 || k - i > len2 {
                continue;
            }
            let sub1 = Self::max_subarray(&nums1, i);
            let sub2 = Self::max_subarray(&nums2, k - i);
            let merged = Self::merge(&sub1, &sub2);
            if merged > result {
                result = merged;
            }
        }
        result
    }

    fn max_subarray(nums: &[i32], k: usize) -> Vec<i32> {
        let mut result = vec![];
        let n = nums.len();
        let mut stack = vec![];
        for (i, &num) in nums.iter().enumerate() {
            while !stack.is_empty() && *stack.last().unwrap() < num && stack.len() + n - i > k {
                stack.pop();
            }
            if stack.len() < k {
                stack.push(num);
            }
        }
        stack
    }

    fn merge(a: &[i32], b: &[i32]) -> Vec<i32> {
        let mut result = vec![];
        let mut i = 0;
        let mut j = 0;
        while i < a.len() || j < b.len() {
            if i < a.len() && j < b.len() {
                if a[i] > b[j] {
                    result.push(a[i]);
                    i += 1;
                } else if a[i] < b[j] {
                    result.push(b[j]);
                    j += 1;
                } else {
                    let mut x = i;
                    let mut y = j;
                    while x < a.len() && y < b.len() && a[x] == b[y] {
                        x += 1;
                        y += 1;
                    }
                    if x < a.len() && y < b.len() {
                        if a[x] > b[y] {
                            result.push(a[i]);
                            i += 1;
                        } else {
                            result.push(b[j]);
                            j += 1;
                        }
                    } else if x < a.len() {
                        result.push(a[i]);
                        i += 1;
                    } else {
                        result.push(b[j]);
                        j += 1;
                    }
                }
            } else if i < a.len() {
                result.push(a[i]);
                i += 1;
            } else {
                result.push(b[j]);
                j += 1;
            }
        }
        result
    }
}

pub struct Solution;
}