impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_cost(start: String, target: String, original: Vec<char>, changed: Vec<char>, cost: Vec<i32>) -> i64 {
        let mut graph = HashMap::new();
        for i in 0..original.len() {
            let u = original[i];
            let v = changed[i];
            let c = cost[i] as i64;
            graph.entry(u).or_insert_with(HashMap::new).entry(v).or_insert_with(|| c);
        }

        let mut dist = HashMap::new();
        for &c in original.iter().chain(changed.iter()) {
            dist.entry(c).or_insert_with(|| HashMap::new());
        }

        for &start_char in dist.keys() {
            let mut heap = std::vec::Vec::new();
            heap.push((0, start_char));
            let mut visited = std::collections::HashSet::new();

            while let Some((d, u)) = heap.pop() {
                if visited.contains(&u) {
                    continue;
                }
                visited.insert(u);
                for (&v, &w) in graph.get(&u).into_iter().flatten() {
                    if !visited.contains(&v) && (dist.get_mut(&u).unwrap().get(&v).map_or(true, |&cd| d + w < cd)) {
                        dist.get_mut(&u).unwrap().insert(v, d + w);
                        heap.push((d + w, v));
                    }
                }
            }
        }

        let mut res = 0;
        for (s, t) in start.chars().zip(target.chars()) {
            if s == t {
                continue;
            }
            if let Some(d) = dist.get(&s).and_then(|m| m.get(&t)) {
                res += *d;
            } else {
                return -1;
            }
        }

        res
    }
}
}