impl Solution {

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

use std::collections::HashMap;

pub fn all_possible_fbt(n: i32) -> Vec<Option<Box<TreeNode>>> {
    if n % 2 == 0 {
        return vec![];
    }

    let mut memo = HashMap::new();
    dfs(n, &mut memo)
}

fn dfs(n: i32, memo: &mut HashMap<i32, Vec<Option<Box<TreeNode>>>>) -> Vec<Option<Box<TreeNode>>> {
    if let Some(result) = memo.get(&n) {
        return result.clone();
    }

    if n == 1 {
        return vec![Some(Box::new(TreeNode::new(0)))];
    }

    let mut result = Vec::new();

    for i in 1..n {
        if (i % 2 == 1) && ((n - i - 1) % 2 == 1) {
            let left_trees = dfs(i, memo);
            let right_trees = dfs(n - i - 1, memo);

            for left in left_trees {
                for right in right_trees {
                    let node = Some(Box::new(TreeNode {
                        val: 0,
                        left,
                        right,
                    }));
                    result.push(node);
                }
            }
        }
    }

    memo.insert(n, result.clone());
    result
}
}