impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn longest_path_with_different_adjacent_characters(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, parent: &Option<Box<TreeNode>>, map: &mut HashMap<i32, Vec<i32>>) -> i32 {
            if let Some(n) = node {
                for child in [n.left.as_ref(), n.right.as_ref()] {
                    if let Some(child) = child {
                        if child.val != n.val {
                            map.entry(n.val).or_insert_with(Vec::new).push(child.val);
                        }
                    }
                }
                dfs(&n.left, node, map);
                dfs(&n.right, node, map);
            }
            0
        }

        fn bfs(start: i32, graph: &HashMap<i32, Vec<i32>>) -> i32 {
            let mut visited = HashMap::new();
            let mut queue = VecDeque::new();
            queue.push_back((start, 0));
            visited.insert(start, true);

            let mut max_depth = 0;

            while let Some((node, depth)) = queue.pop_front() {
                max_depth = std::cmp::max(max_depth, depth);
                if let Some(neighbors) = graph.get(&node) {
                    for &neighbor in neighbors {
                        if !visited.contains_key(&neighbor) {
                            visited.insert(neighbor, true);
                            queue.push_back((neighbor, depth + 1));
                        }
                    }
                }
            }

            max_depth
        }

        let mut graph = HashMap::new();
        dfs(&root, &None, &mut graph);

        let mut max_length = 0;
        for &node in graph.keys() {
            max_length = std::cmp::max(max_length, bfs(node, &graph));
        }

        max_length
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;
}