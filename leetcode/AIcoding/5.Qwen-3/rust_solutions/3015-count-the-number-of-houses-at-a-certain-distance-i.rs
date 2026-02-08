impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distance_k_nodes(root: Option<Rc<RefCell<TreeNode>>>, target: i32, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut parent_map = HashMap::new();
        let mut visited = HashMap::new();

        Self::build_parent_map(root.clone(), None, &mut parent_map);

        Self::dfs(root, target, k, &mut result, &mut visited, &parent_map);

        result
    }

    fn build_parent_map(
        node: Option<Rc<RefCell<TreeNode>>>,
        parent: Option<Rc<RefCell<TreeNode>>>,
        parent_map: &mut HashMap<i32, Rc<RefCell<TreeNode>>>,
    ) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if let Some(p) = parent {
                parent_map.insert(val, p);
            }
            Self::build_parent_map(n.borrow().left.clone(), Some(n.clone()), parent_map);
            Self::build_parent_map(n.borrow().right.clone(), Some(n.clone()), parent_map);
        }
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        target: i32,
        k: i32,
        result: &mut Vec<i32>,
        visited: &mut HashMap<i32, bool>,
        parent_map: &HashMap<i32, Rc<RefCell<TreeNode>>>,
    ) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if *visited.get(&val).unwrap_or(&false) {
                return;
            }
            visited.insert(val, true);

            if k == 0 {
                result.push(val);
                return;
            }

            if let Some(left) = n.borrow().left.clone() {
                Self::dfs(Some(left), target, k - 1, result, visited, parent_map);
            }

            if let Some(right) = n.borrow().right.clone() {
                Self::dfs(Some(right), target, k - 1, result, visited, parent_map);
            }

            if let Some(parent) = parent_map.get(&val) {
                Self::dfs(Some(parent.clone()), target, k - 1, result, visited, parent_map);
            }
        }
    }
}
}