pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct BSTIterator {
    stack: Vec<Box<TreeNode>>,
}

impl BSTIterator {
    pub fn new(mut root: Option<Box<TreeNode>>) -> Self {
        let mut stack = Vec::new();
        while let Some(node) = root {
            stack.push(node);
            root = node.left;
        }
        BSTIterator { stack }
    }

    pub fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }

    pub fn next(&mut self) -> i32 {
        let node = self.stack.pop().unwrap();
        let val = node.val;
        let mut right = node.right;
        while let Some(r) = right {
            self.stack.push(r);
            right = r.left;
        }
        val
    }
}