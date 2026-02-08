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

pub struct Solution {}

impl Solution {
    pub fn get_target_copy(
        &self,
        original: Option<Box<TreeNode>>,
        cloned: Option<Box<TreeNode>>,
        target: Option<Box<TreeNode>>,
    ) -> Option<Box<TreeNode>> {
        fn dfs(
            original: Option<Box<TreeNode>>,
            cloned: Option<Box<TreeNode>>,
            target: &TreeNode,
        ) -> Option<Box<TreeNode>> {
            if original.is_none() {
                return None;
            }

            let original_node = original.as_ref().unwrap();
            let cloned_node = cloned.as_ref().unwrap();

            if original_node.val == target.val {
                return Some(cloned_node.clone());
            }

            let left = dfs(original_node.left.clone(), cloned_node.left.clone(), target);
            if left.is_some() {
                return left;
            }

            dfs(original_node.right.clone(), cloned_node.right.clone(), target)
        }

        dfs(original, cloned, target.as_ref().unwrap())
    }
}
}