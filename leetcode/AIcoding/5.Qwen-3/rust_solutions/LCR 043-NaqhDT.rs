impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct CBTInserter {
    root: Option<Rc<RefCell<TreeNode>>>,
    queue: Vec<Rc<RefCell<TreeNode>>>,
}

impl CBTInserter {
    pub fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut queue = Vec::new();
        if let Some(ref root) = root {
            queue.push(Rc::clone(root));
        }
        let mut node = queue.pop();
        while let Some(n) = node {
            if let Some(left) = &n.borrow().left {
                queue.push(Rc::clone(left));
            }
            if let Some(right) = &n.borrow().right {
                queue.push(Rc::clone(right));
            }
            node = queue.pop();
        }
        CBTInserter { root, queue }
    }

    pub fn insert(&mut self, v: i32) -> Rc<RefCell<TreeNode>> {
        let new_node = Rc::new(RefCell::new(TreeNode {
            val: v,
            left: None,
            right: None,
        }));
        let parent = self.queue[0].clone();
        if parent.borrow().left.is_none() {
            parent.borrow_mut().left = Some(new_node.clone());
        } else {
            parent.borrow_mut().right = Some(new_node.clone());
            self.queue.remove(0);
        }
        self.queue.push(new_node.clone());
        new_node
    }

    pub fn get_root(&self) -> Option<Rc<RefCell<TreeNode>>> {
        self.root.clone()
    }
}
}