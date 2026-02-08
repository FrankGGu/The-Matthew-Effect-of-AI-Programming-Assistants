impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub struct Solution {}

impl Solution {
    pub fn binary_tree_paths(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<String> {
        let mut result = Vec::new();
        if let Some(node) = root {
            Self::dfs(&node, String::new(), &mut result);
        }
        result
    }

    fn dfs(node: &Rc<RefCell<TreeNode>>, path: String, result: &mut Vec<String>) {
        let node_ref = node.borrow();
        let mut new_path = path.clone();
        new_path.push_str(&node_ref.val.to_string());

        if node_ref.left.is_none() && node_ref.right.is_none() {
            result.push(new_path);
            return;
        }

        if let Some(left) = &node_ref.left {
            new_path.push('-');
            new_path.push('>');
            Self::dfs(left, new_path, result);
        }

        if let Some(right) = &node_ref.right {
            new_path.push('-');
            new_path.push('>');
            Self::dfs(right, new_path, result);
        }
    }
}
}