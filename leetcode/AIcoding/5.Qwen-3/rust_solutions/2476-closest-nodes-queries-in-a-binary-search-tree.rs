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

pub struct Solution {}

impl Solution {
    pub fn closest_nodes(
        root: Option<Rc<RefCell<TreeNode>>>,
        queries: Vec<i32>,
    ) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut values = Vec::new();
        Self::inorder_traversal(&root, &mut values);

        for q in queries {
            let mut min_val = i32::MAX;
            let mut max_val = i32::MIN;
            let mut left = 0;
            let mut right = values.len() as i32 - 1;

            while left <= right {
                let mid = (left + right) / 2;
                if values[mid] < q {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if left > 0 {
                min_val = values[left as usize - 1];
            }

            if left < values.len() {
                max_val = values[left as usize];
            }

            result.push(vec![min_val, max_val]);
        }

        result
    }

    fn inorder_traversal(
        root: &Option<Rc<RefCell<TreeNode>>>,
        values: &mut Vec<i32>,
    ) {
        if let Some(node) = root {
            Self::inorder_traversal(&node.borrow().left, values);
            values.push(node.borrow().val);
            Self::inorder_traversal(&node.borrow().right, values);
        }
    }
}
}