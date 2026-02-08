impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct CBTInserter {
    tree: Vec<Option<Box<TreeNode>>>,
    size: usize,
}

impl CBTInserter {
    pub fn new(root: Option<Box<TreeNode>>) -> Self {
        let mut tree = Vec::new();
        let mut queue = VecDeque::new();
        if let Some(node) = &root {
            queue.push_back(node);
        }
        while let Some(node) = queue.pop_front() {
            tree.push(Some(node.clone()));
            if let Some(left) = &node.left {
                queue.push_back(left);
            }
            if let Some(right) = &node.right {
                queue.push_back(right);
            }
        }
        CBTInserter { tree, size: tree.len() }
    }

    pub fn insert(&mut self, val: i32) -> i32 {
        let new_node = Box::new(TreeNode {
            val,
            left: None,
            right: None,
        });
        let index = self.size;
        self.tree.push(Some(new_node));
        self.size += 1;
        let parent_index = (index - 1) / 2;
        let parent = &mut self.tree[parent_index];
        if index % 2 == 1 {
            parent.as_mut().unwrap().left = self.tree[index].take();
        } else {
            parent.as_mut().unwrap().right = self.tree[index].take();
        }
        self.tree[parent_index].as_ref().unwrap().val
    }

    pub fn get_root(&self) -> Option<Box<TreeNode>> {
        self.tree[0].clone()
    }
}
}