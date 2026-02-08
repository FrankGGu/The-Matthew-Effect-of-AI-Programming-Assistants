impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn count_visited_nodes(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut graph = HashMap::new();
        let mut nodes = Vec::new();
        let mut current = head.as_ref();
        while let Some(node) = current {
            nodes.push(node.val);
            graph.entry(node.val).or_insert_with(Vec::new);
            current = node.next.as_ref();
        }

        for i in 0..nodes.len() {
            let val = nodes[i];
            if let Some(next) = graph.get_mut(&val) {
                next.push(nodes[(i + 1) % nodes.len()]);
            }
        }

        let mut result = vec![0; nodes.len()];
        let mut visited = vec![false; nodes.len()];
        let mut in_stack = vec![false; nodes.len()];
        let mut stack = Vec::new();

        for i in 0..nodes.len() {
            if !visited[i] {
                let mut cycle = Vec::new();
                let mut current = i;
                while !visited[current] {
                    visited[current] = true;
                    in_stack[current] = true;
                    stack.push(current);
                    let next = graph[&nodes[current]][0];
                    let next_index = nodes.iter().position(|&x| x == next).unwrap();
                    if in_stack[next_index] {
                        let idx = stack.iter().position(|&x| x == next_index).unwrap();
                        cycle = stack[idx..].to_vec();
                        break;
                    }
                    current = next_index;
                }

                for &node in &cycle {
                    result[node] = cycle.len() as i32;
                }

                for &node in &stack {
                    in_stack[node] = false;
                }
            }
        }

        result
    }
}

#[derive(PartialEq, Eq, Clone, Copy, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub struct Solution;
}