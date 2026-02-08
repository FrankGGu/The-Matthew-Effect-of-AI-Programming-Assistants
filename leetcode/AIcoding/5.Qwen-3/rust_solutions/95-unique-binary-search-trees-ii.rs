impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn generate_trees(n: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
    if n == 0 {
        return vec![];
    }
    generate(1, n)
}

fn generate(start: i32, end: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
    if start > end {
        return vec![None];
    }
    let mut result = Vec::new();
    for i in start..=end {
        let left_trees = generate(start, i - 1);
        let right_trees = generate(i + 1, end);
        for left in &left_trees {
            for right in &right_trees {
                let mut root = Rc::new(RefCell::new(TreeNode::new(i)));
                root.borrow_mut().left = left.clone();
                root.borrow_mut().right = right.clone();
                result.push(Some(root));
            }
        }
    }
    result
}
}