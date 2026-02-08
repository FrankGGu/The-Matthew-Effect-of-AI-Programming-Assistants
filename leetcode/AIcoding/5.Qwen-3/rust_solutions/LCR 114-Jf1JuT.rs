impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn alien_order(words: Vec<String>, order: String) -> String {
        let mut graph = HashMap::new();
        let mut in_degree = HashMap::new();

        for word in &words {
            for c in word.chars() {
                if !graph.contains_key(&c) {
                    graph.insert(c, Vec::new());
                    in_degree.insert(c, 0);
                }
            }
        }

        let order_chars: Vec<char> = order.chars().collect();
        for i in 0..order_chars.len() - 1 {
            let u = order_chars[i];
            let v = order_chars[i + 1];
            if !graph.contains_key(&v) {
                graph.insert(v, Vec::new());
                in_degree.insert(v, 0);
            }
            if !graph.contains_key(&u) {
                graph.insert(u, Vec::new());
                in_degree.insert(u, 0);
            }
            if !graph[&u].contains(&v) {
                graph.get_mut(&u).unwrap().push(v);
                *in_degree.get_mut(&v).unwrap() += 1;
            }
        }

        let mut queue = VecDeque::new();
        for (c, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(*c);
            }
        }

        let mut result = Vec::new();
        while let Some(c) = queue.pop_front() {
            result.push(c);
            for &neighbor in &graph[&c] {
                *in_degree.get_mut(&neighbor).unwrap() -= 1;
                if *in_degree.get(&neighbor).unwrap() == 0 {
                    queue.push_back(neighbor);
                }
            }
        }

        if result.len() != in_degree.len() {
            return String::new();
        }

        result.into_iter().collect()
    }
}
}