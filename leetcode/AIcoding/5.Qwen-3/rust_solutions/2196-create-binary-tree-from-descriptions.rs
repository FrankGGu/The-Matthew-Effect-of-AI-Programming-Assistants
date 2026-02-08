impl Solution {

use std::collections::{HashMap, HashSet};

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

pub fn build_binary_tree(descriptions: Vec<Vec<i32>>) -> Option<Box<TreeNode>> {
    let mut nodes = HashMap::new();
    let mut children = HashSet::new();

    for desc in descriptions {
        let parent_val = desc[0];
        let child_val = desc[1];
        let is_left = desc[2] == 1;

        let parent = nodes.entry(parent_val).or_insert_with(|| Box::new(TreeNode::new(parent_val)));
        let child = nodes.entry(child_val).or_insert_with(|| Box::new(TreeNode::new(child_val)));

        if is_left {
            parent.left = Some(child.clone());
        } else {
            parent.right = Some(child.clone());
        }

        children.insert(child_val);
    }

    for node in nodes.values() {
        if !children.contains(&node.val) {
            return Some(node.clone());
        }
    }

    None
}
}