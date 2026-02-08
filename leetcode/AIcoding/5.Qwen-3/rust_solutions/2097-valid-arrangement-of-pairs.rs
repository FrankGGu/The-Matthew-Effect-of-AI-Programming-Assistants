impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn valid_arrangement(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut graph = HashMap::new();
        let mut in_degree = HashMap::new();
        let mut out_degree = HashMap::new();

        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            graph.entry(u).or_insert_with(VecDeque::new).push_back(v);
            *out_degree.entry(u).or_insert(0) += 1;
            *in_degree.entry(v).or_insert(0) += 1;
        }

        let start_node = if let Some(start) = find_start_node(&mut graph, &in_degree, &out_degree) {
            start
        } else {
            pairs[0][0]
        };

        let mut result = Vec::new();
        let mut stack = Vec::new();
        stack.push(start_node);

        while let Some(node) = stack.pop() {
            if let Some(neighbors) = graph.get_mut(&node) {
                if let Some(next) = neighbors.pop_front() {
                    stack.push(node);
                    stack.push(next);
                } else {
                    result.push(node);
                }
            } else {
                result.push(node);
            }
        }

        result.reverse();

        let mut res = Vec::new();
        for i in 0..result.len() - 1 {
            res.push(vec![result[i], result[i + 1]]);
        }

        res
    }
}

fn find_start_node(
    graph: &mut HashMap<i32, VecDeque<i32>>,
    in_degree: &HashMap<i32, i32>,
    out_degree: &HashMap<i32, i32>,
) -> Option<i32> {
    for (&node, &out) in out_degree {
        let in_val = in_degree.get(&node).copied().unwrap_or(0);
        if out > in_val {
            return Some(node);
        }
    }

    for (&node, _) in graph {
        return Some(node);
    }

    None
}
}