impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn sort_items(n: i32, m: i32, group: Vec<i32>, before_items: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let m = m as usize;
        let mut group_items = HashMap::new();
        for i in 0..n {
            group_items.entry(group[i] as usize).or_insert_with(Vec::new).push(i as i32);
        }

        let mut graph = HashMap::new();
        let mut in_degree = HashMap::new();

        for i in 0..m {
            graph.entry(i).or_insert_with(Vec::new);
            in_degree.entry(i).or_insert(0);
        }

        for i in 0..n {
            let g = group[i] as usize;
            if !graph.contains_key(&g) {
                graph.insert(g, Vec::new());
                in_degree.insert(g, 0);
            }
        }

        for i in 0..n {
            for &prev in &before_items[i] {
                let prev_group = group[prev as usize] as usize;
                let curr_group = group[i] as usize;
                if prev_group != curr_group {
                    if !graph[&curr_group].contains(&prev_group) {
                        graph.get_mut(&curr_group).unwrap().push(prev_group);
                        *in_degree.get_mut(&prev_group).unwrap() += 1;
                    }
                }
            }
        }

        let mut queue = VecDeque::new();
        for (g, &d) in &in_degree {
            if d == 0 {
                queue.push_back(*g);
            }
        }

        let mut result = Vec::new();
        while let Some(g) = queue.pop_front() {
            result.push(g as i32);
            for &neighbor in &graph[&g] {
                *in_degree.get_mut(&neighbor).unwrap() -= 1;
                if *in_degree.get(&neighbor).unwrap() == 0 {
                    queue.push_back(neighbor);
                }
            }
        }

        if result.len() != m {
            return vec![];
        }

        let mut item_order = Vec::new();
        for g in &result {
            let items = group_items.get(g).unwrap();
            let mut temp = items.clone();
            temp.sort();
            item_order.extend(temp);
        }

        item_order
    }
}
}