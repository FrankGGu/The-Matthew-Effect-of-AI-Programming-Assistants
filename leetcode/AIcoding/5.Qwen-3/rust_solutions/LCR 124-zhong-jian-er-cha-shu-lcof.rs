impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn build_tree(preorder: Vec<i32>, inorder: Vec<i32>) -> Option<Box<TreeNode>> {
    fn helper(
        preorder: &[i32],
        inorder: &[i32],
        in_map: &std::collections::HashMap<i32, usize>,
        pre_idx: &mut usize,
        in_left: usize,
        in_right: usize,
    ) -> Option<Box<TreeNode>> {
        if in_left > in_right {
            return None;
        }
        let root_val = preorder[*pre_idx];
        let root = Box::new(TreeNode {
            val: root_val,
            left: None,
            right: None,
        });
        let root_idx = in_map[&root_val];
        *pre_idx += 1;
        root.left = helper(preorder, inorder, in_map, pre_idx, in_left, root_idx - 1);
        root.right = helper(preorder, inorder, in_map, pre_idx, root_idx + 1, in_right);
        Some(root)
    }

    let mut in_map = std::collections::HashMap::new();
    for (i, &val) in inorder.iter().enumerate() {
        in_map.insert(val, i);
    }
    let mut pre_idx = 0;
    helper(&preorder, &inorder, &in_map, &mut pre_idx, 0, inorder.len() - 1)
}
}