impl Solution {

use std::collections::{BinaryHeap, HashSet};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Node {
    id: i32,
    distance: i32,
}

impl PartialOrd for Node {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Node {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.distance.cmp(&self.distance)
    }
}

fn reachable_nodes(edges: Vec<Vec<i32>>, max_moves: i32, n: i32) -> i32 {
    let mut graph = std::collections::HashMap::new();
    for edge in edges {
        let u = edge[0];
        let v = edge[1];
        let cnt = edge[2];
        graph.entry(u).or_insert_with(Vec::new).push((v, cnt));
        graph.entry(v).or_insert_with(Vec::new).push((u, cnt));
    }

    let mut dist = vec![i32::MIN; n as usize];
    let mut heap = BinaryHeap::new();
    for i in 0..n {
        dist[i as usize] = 0;
        heap.push(Node { id: i, distance: 0 });
    }

    while let Some(Node { id, distance }) = heap.pop() {
        if distance < dist[id as usize] {
            continue;
        }

        for (neighbor, cnt) in graph.get(&id).into_iter().flatten() {
            let new_dist = distance + cnt;
            if new_dist > dist[*neighbor as usize] {
                dist[*neighbor as usize] = new_dist;
                heap.push(Node { id: *neighbor, distance: new_dist });
            }
        }
    }

    let mut visited = HashSet::new();
    let mut result = 0;

    for i in 0..n {
        if dist[i as usize] >= max_moves {
            result += 1;
        } else {
            for (neighbor, cnt) in graph.get(&i).into_iter().flatten() {
                let moves_from_i = max_moves - dist[i as usize];
                let moves_from_neighbor = max_moves - dist[*neighbor as usize];
                let nodes = std::cmp::min(cnt, moves_from_i + moves_from_neighbor);
                result += nodes;
                visited.insert((i, *neighbor));
                visited.insert((*neighbor, i));
            }
        }
    }

    result
}
}