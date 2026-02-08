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

pub fn btree_game_winning_move(root: Option<Box<TreeNode>>) -> bool {
    fn count_nodes(node: &Option<Box<TreeNode>>) -> i32 {
        match node {
            Some(n) => 1 + count_nodes(&n.left) + count_nodes(&n.right),
            None => 0,
        }
    }

    fn find_node(node: &Option<Box<TreeNode>>, target: i32) -> Option<&Box<TreeNode>> {
        match node {
            Some(n) => {
                if n.val == target {
                    return Some(n);
                }
                if let Some(left) = find_node(&n.left, target) {
                    return Some(left);
                }
                if let Some(right) = find_node(&n.right, target) {
                    return Some(right);
                }
                None
            }
            None => None,
        }
    }

    let total = count_nodes(&root);
    if total < 3 {
        return false;
    }

    let mut left_count = 0;
    let mut right_count = 0;

    if let Some(target_node) = find_node(&root, 1) {
        left_count = count_nodes(&target_node.left);
        right_count = count_nodes(&target_node.right);
    }

    let other = total - left_count - right_count - 1;

    left_count > total / 2 || right_count > total / 2 || other > total / 2
}
}