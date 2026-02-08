impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn string_sequence(mut sequences: Vec<Vec<String>>) -> Vec<String> {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut in_degree: HashMap<String, i32> = HashMap::new();
        let mut all_nodes: HashSet<String> = HashSet::new();

        for seq in &sequences {
            for i in 0..seq.len() - 1 {
                let u = &seq[i];
                let v = &seq[i + 1];
                all_nodes.insert(u.clone());
                all_nodes.insert(v.clone());
                graph.entry(u.clone()).or_insert_with(Vec::new).push(v.clone());
                *in_degree.entry(v.clone()).or_insert(0) += 1;
            }
        }

        let mut queue: VecDeque<String> = in_degree.iter()
            .filter(|(_, &degree)| degree == 0)
            .map(|(node, _)| node.clone())
            .collect();

        let mut result = Vec::new();

        while let Some(node) = queue.pop_front() {
            result.push(node.clone());
            if let Some(neighbors) = graph.get(&node) {
                for neighbor in neighbors {
                    *in_degree.get_mut(neighbor).unwrap() -= 1;
                    if *in_degree.get(neighbor).unwrap() == 0 {
                        queue.push_back(neighbor.clone());
                    }
                }
            }
        }

        if result.len() != all_nodes.len() {
            return vec![];
        }

        result
    }
}
}