impl Solution {

use std::collections::{HashMap, VecDeque};

struct UnitConverter {
    graph: HashMap<String, HashMap<String, f64>>,
}

impl UnitConverter {
    fn new(equations: Vec<Vec<String>>, values: Vec<f64>) -> Self {
        let mut graph = HashMap::new();
        for (i, eq) in equations.iter().enumerate() {
            let a = &eq[0];
            let b = &eq[1];
            let value = values[i];
            graph.entry(a.clone()).or_insert_with(HashMap::new).insert(b.clone(), value);
            graph.entry(b.clone()).or_insert_with(HashMap::new).insert(a.clone(), 1.0 / value);
        }
        UnitConverter { graph }
    }

    fn calculate(&self, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut result = Vec::with_capacity(queries.len());
        for query in queries {
            let from = &query[0];
            let to = &query[1];
            if !self.graph.contains_key(from) || !self.graph.contains_key(to) {
                result.push(-1.0);
                continue;
            }
            if from == to {
                result.push(1.0);
                continue;
            }
            let mut visited = HashMap::new();
            let mut queue = VecDeque::new();
            queue.push_back((from.clone(), 1.0));
            visited.insert(from.clone(), true);
            let mut found = false;
            while let Some((node, value)) = queue.pop_front() {
                if node == *to {
                    result.push(value);
                    found = true;
                    break;
                }
                if let Some(neighbors) = self.graph.get(&node) {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains_key(neighbor) {
                            visited.insert(neighbor.clone(), true);
                            queue.push_back((neighbor.clone(), value * weight));
                        }
                    }
                }
            }
            if !found {
                result.push(-1.0);
            }
        }
        result
    }
}

pub fn main() {
    let equations = vec![
        vec!["a".to_string(), "b".to_string()],
        vec!["b".to_string(), "c".to_string()],
    ];
    let values = vec![2.0, 3.0];
    let queries = vec![
        vec!["a".to_string(), "c".to_string()],
        vec!["b".to_string(), "a".to_string()],
        vec!["a".to_string(), "e".to_string()],
        vec!["a".to_string(), "a".to_string()],
        vec!["x".to_string(), "x".to_string()],
    ];

    let converter = UnitConverter::new(equations, values);
    let result = converter.calculate(queries);

    for val in result {
        println!("{}", val);
    }
}
}