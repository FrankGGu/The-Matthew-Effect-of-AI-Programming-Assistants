impl Solution {

use std::collections::VecDeque;

struct Node {
    children: Vec<usize>,
}

struct Tree {
    nodes: Vec<Node>,
}

impl Tree {
    fn new(n: i32) -> Self {
        Tree {
            nodes: vec![Node { children: vec![] }; n as usize],
        }
    }

    fn get_children(&self, node: i32) -> Vec<i32> {
        self.nodes[node as usize].children.iter().map(|&c| c as i32).collect()
    }

    fn add_child(&mut self, parent: i32, child: i32) {
        self.nodes[parent as usize].children.push(child as usize);
    }
}

struct Solution {}

impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut tree = Tree::new(n);
        for edge in edges {
            tree.add_child(edge[0], edge[1]);
        }

        let mut visited = vec![false; n as usize];
        let mut sizes = vec![0; n as usize];

        fn dfs(node: i32, tree: &Tree, visited: &mut Vec<bool>, sizes: &mut Vec<i32>) -> i32 {
            visited[node as usize] = true;
            let mut size = 1;
            for &child in &tree.nodes[node as usize].children {
                if !visited[child] {
                    size += dfs(child as i32, tree, visited, sizes);
                }
            }
            sizes[node as usize] = size;
            size
        }

        let total = dfs(0, &tree, &mut visited, &mut sizes);
        let mut result = 0;
        for &size in &sizes {
            result += size * (total - size);
        }
        result / 2
    }
}
}