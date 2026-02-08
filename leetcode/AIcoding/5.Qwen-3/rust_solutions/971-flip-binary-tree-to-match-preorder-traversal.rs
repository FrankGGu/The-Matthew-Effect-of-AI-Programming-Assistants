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

pub fn flip_match_voyage(root: Option<Box<TreeNode>>, voyage: Vec<i32>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut index = 0;

    fn dfs(
        node: &Option<Box<TreeNode>>,
        voyage: &[i32],
        index: &mut usize,
        result: &mut Vec<i32>,
    ) -> bool {
        if let Some(n) = node {
            if n.val != voyage[*index] {
                return false;
            }
            *index += 1;

            if let (Some(left), Some(right)) = (&n.left, &n.right) {
                if left.val == voyage[*index] {
                    if !dfs(&n.left, voyage, index, result) {
                        return false;
                    }
                } else if right.val == voyage[*index] {
                    result.push(n.val);
                    if !dfs(&n.right, voyage, index, result) {
                        return false;
                    }
                } else {
                    return false;
                }
            } else if let Some(left) = &n.left {
                if !dfs(&n.left, voyage, index, result) {
                    return false;
                }
            } else if let Some(right) = &n.right {
                if !dfs(&n.right, voyage, index, result) {
                    return false;
                }
            }
        }
        true
    }

    if dfs(&root, &voyage, &mut index, &mut result) {
        result
    } else {
        vec![-1]
    }
}
}