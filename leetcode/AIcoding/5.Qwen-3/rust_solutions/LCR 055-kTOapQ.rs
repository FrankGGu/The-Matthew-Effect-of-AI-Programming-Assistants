impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
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

pub struct BSTIterator {
    stack: Vec<TreeNode>,
    current: Option<TreeNode>,
}

impl BSTIterator {
    pub fn new(mut root: Option<TreeNode>) -> Self {
        let mut stack = Vec::new();
        let mut current = root;
        while let Some(mut node) = current {
            stack.push(node);
            current = node.left;
        }
        BSTIterator { stack, current: None }
    }

    pub fn next(&mut self) -> i32 {
        let node = self.stack.pop().unwrap();
        let val = node.val;
        let mut current = node.right;
        while let Some(mut node) = current {
            self.stack.push(node);
            current = node.left;
        }
        val
    }

    pub fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
}