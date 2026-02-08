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

struct Solution;

impl Solution {
    pub fn bst_from_preorder(preorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::build(&preorder, 0, preorder.len() as i32)
    }

    fn build(preorder: &Vec<i32>, low: i32, high: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if low >= high {
            return None;
        }

        let root_val = preorder[low as usize];
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));

        let mut i = low + 1;
        while i < high && preorder[i as usize] < root_val {
            i += 1;
        }

        root.borrow_mut().left = Self::build(preorder, low + 1, i);
        root.borrow_mut().right = Self::build(preorder, i, high);

        Some(root)
    }
}
}