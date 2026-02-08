impl Solution {

use std::collections::{BinaryHeap, HashMap};

#[derive(Eq, PartialEq, Clone, Copy, Hash, Debug)]
struct Node {
    id: usize,
    weight: i32,
}

impl Node {
    fn new(id: usize, weight: i32) -> Self {
        Node { id, weight }
    }
}

#[derive(Eq, PartialEq, Clone, Copy, Hash, Debug)]
struct Edge {
    to: usize,
    weight: i32,
}

impl Edge {
    fn new(to: usize, weight: i32) -> Self {
        Edge { to, weight }
    }
}

type Graph = HashMap<usize, Vec<Edge>>;

fn shortest_path(tree: &Graph, start: usize, end: usize) -> i32 {
    let mut dist = HashMap::new();
    let mut heap = BinaryHeap::new();

    dist.insert(start, 0);
    heap.push((0, start));

    while let Some((current_dist, current)) = heap.pop() {
        if current == end {
            return current_dist;
        }

        if current_dist > *dist.get(&current).unwrap_or(&i32::MAX) {
            continue;
        }

        for edge in tree.get(&current).into_iter().flatten() {
            let next = edge.to;
            let weight = edge.weight;
            let next_dist = current_dist + weight;

            if next_dist < *dist.get(&next).unwrap_or(&i32::MAX) {
                dist.insert(next, next_dist);
                heap.push((next_dist, next));
            }
        }
    }

    -1
}

pub fn main() {
    let mut tree = Graph::new();
    tree.insert(0, vec![Edge::new(1, 2), Edge::new(2, 5)]);
    tree.insert(1, vec![Edge::new(3, 1)]);
    tree.insert(2, vec![Edge::new(3, 3)]);
    tree.insert(3, vec![]);

    let result = shortest_path(&tree, 0, 3);
    println!("{}", result);
}
}