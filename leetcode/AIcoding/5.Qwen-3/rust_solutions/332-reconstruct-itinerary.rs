impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_itinerary(tickets: Vec<Vec<String>>) -> Vec<String> {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        for ticket in tickets {
            let from = &ticket[0];
            let to = &ticket[1];
            graph.entry(from.clone()).or_insert_with(Vec::new).push(to.clone());
        }

        for (_, edges) in &mut graph {
            edges.sort();
        }

        let mut result = Vec::new();
        Self::dfs("JFK".to_string(), &mut graph, &mut result);
        result
    }

    fn dfs(node: String, graph: &mut HashMap<String, Vec<String>>, result: &mut Vec<String>) {
        while let Some(next) = graph.get_mut(&node).and_then(|edges| edges.pop()) {
            Self::dfs(next, graph, result);
        }
        result.push(node);
    }
}
}