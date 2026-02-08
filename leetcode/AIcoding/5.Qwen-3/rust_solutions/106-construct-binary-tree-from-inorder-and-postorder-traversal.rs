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

pub fn build_tree(inorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
    fn helper(
        inorder: &[i32],
        postorder: &[i32],
        index_map: &std::collections::HashMap<i32, usize>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if inorder.is_empty() {
            return None;
        }

        let root_val = *postorder.last()?;
        let root = Rc::new(RefCell::new(TreeNode::new(root_val)));

        let root_index = index_map.get(&root_val)?;
        let left_inorder = &inorder[..*root_index];
        let right_inorder = &inorder[*root_index + 1..];

        let left_size = left_inorder.len();
        let right_size = right_inorder.len();

        let left_postorder = &postorder[..left_size];
        let right_postorder = &postorder[left_size..postorder.len() - 1];

        root.borrow_mut().left = helper(left_inorder, left_postorder, index_map);
        root.borrow_mut().right = helper(right_inorder, right_postorder, index_map);

        Some(root)
    }

    let index_map: std::collections::HashMap<i32, usize> = inorder
        .iter()
        .enumerate()
        .map(|(i, &val)| (val, i))
        .collect();

    helper(&inorder, &postorder, &index_map)
}
}