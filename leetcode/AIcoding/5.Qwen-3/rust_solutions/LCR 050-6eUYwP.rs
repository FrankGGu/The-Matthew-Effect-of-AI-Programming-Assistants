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

pub fn path_sum(root: Option<Box<TreeNode>>, target_sum: i32) -> i32 {
    use std::collections::HashMap;

    fn dfs(node: &Option<Box<TreeNode>>, prefix_sum: i32, target_sum: i32, map: &mut HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let current_sum = prefix_sum + n.val;
            let count = *map.get(&current_sum - target_sum).unwrap_or(&0);
            map.entry(current_sum).and_modify(|c| *c += 1).or_insert(1);
            let left = dfs(&n.left, current_sum, target_sum, map);
            let right = dfs(&n.right, current_sum, target_sum, map);
            map.entry(current_sum).and_modify(|c| *c -= 1);
            count + left + right
        } else {
            0
        }
    }

    let mut map = HashMap::new();
    map.insert(0, 1);
    dfs(&root, 0, target_sum, &mut map)
}