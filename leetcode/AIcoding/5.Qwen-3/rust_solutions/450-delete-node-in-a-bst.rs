impl Solution {

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

pub fn delete_node(root: Option<Box<TreeNode>>, key: i32) -> Option<Box<TreeNode>> {
    if root.is_none() {
        return None;
    }

    let mut root = root.unwrap();

    if root.val == key {
        if root.left.is_none() {
            return root.right;
        } else if root.right.is_none() {
            return root.left;
        } else {
            let min_right = find_min(&root.right);
            root.val = min_right;
            root.right = delete_node(root.right, min_right);
            return Some(root);
        }
    } else if root.val > key {
        root.left = delete_node(root.left, key);
    } else {
        root.right = delete_node(root.right, key);
    }

    Some(root)
}

fn find_min(root: &Option<Box<TreeNode>>) -> i32 {
    let mut current = root.as_ref().unwrap();
    while let Some(ref left) = current.left {
        current = left;
    }
    current.val
}
}