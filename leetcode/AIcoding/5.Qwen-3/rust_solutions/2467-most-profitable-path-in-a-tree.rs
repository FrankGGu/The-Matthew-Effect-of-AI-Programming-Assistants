impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn most_profitable_path(root: Option<Box<TreeNode>>, capacity: i32) -> i32 {
        let mut path_sum = HashMap::new();
        let mut queue = VecDeque::new();
        queue.push_back((root, 0));

        while let Some((node, sum)) = queue.pop_front() {
            if let Some(mut node) = node {
                let current_sum = sum + node.val;
                if node.left.is_none() && node.right.is_none() {
                    path_sum.insert(current_sum, ());
                } else {
                    if let Some(left) = node.left {
                        queue.push_back((Some(left), current_sum));
                    }
                    if let Some(right) = node.right {
                        queue.push_back((Some(right), current_sum));
                    }
                }
            }
        }

        let mut max_profit = i32::MIN;
        for (sum, _) in path_sum {
            if sum <= capacity {
                max_profit = max_profit.max(sum);
            }
        }

        max_profit
    }
}
}