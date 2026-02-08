impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn most_frequent_subtree_sum(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut sum_counts = HashMap::new();
    let _ = dfs(&root, &mut sum_counts);
    let mut max_count = 0;
    let mut result = Vec::new();

    for (&sum, &count) in sum_counts.iter() {
        if count > max_count {
            max_count = count;
            result.clear();
            result.push(sum);
        } else if count == max_count {
            result.push(sum);
        }
    }

    result.sort();
    result
}

fn dfs(node: &Option<Box<TreeNode>>, sum_counts: &mut HashMap<i32, i32>) -> i32 {
    if let Some(n) = node {
        let left_sum = dfs(&n.left, sum_counts);
        let right_sum = dfs(&n.right, sum_counts);
        let current_sum = n.val + left_sum + right_sum;
        *sum_counts.entry(current_sum).or_insert(0) += 1;
        current_sum
    } else {
        0
    }
}
}