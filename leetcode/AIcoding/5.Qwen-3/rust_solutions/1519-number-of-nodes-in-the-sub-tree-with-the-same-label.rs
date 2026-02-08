impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn count_nodes_in_sub_tree(
    root: Option<Box<TreeNode>>,
    labels: String,
    result: &mut Vec<i32>,
) -> HashMap<char, i32> {
    let mut count = HashMap::new();
    if let Some(node) = root {
        let left_count = count_nodes_in_sub_tree(node.left, labels.clone(), result);
        let right_count = count_nodes_in_sub_tree(node.right, labels.clone(), result);

        for (k, v) in left_count.iter() {
            *count.entry(*k).or_insert(0) += *v;
        }

        for (k, v) in right_count.iter() {
            *count.entry(*k).or_insert(0) += *v;
        }

        let label_char = labels.chars().nth(node.val as usize).unwrap();
        *count.entry(label_char).or_insert(0) += 1;

        result[node.val as usize] = *count.get(&label_char).unwrap();

        count
    } else {
        count
    }
}

pub fn count_labels(root: Option<Box<TreeNode>>, labels: String) -> Vec<i32> {
    let mut result = vec![0; labels.len()];
    count_nodes_in_sub_tree(root, labels, &mut result);
    result
}
}