impl Solution {

use std::collections::{BinaryHeap, VecDeque};

#[derive(Eq, PartialEq, Clone, Copy, Debug)]
struct Item {
    price: i32,
    row: i32,
    col: i32,
}

impl Ord for Item {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.price.cmp(&self.price)
            .then(other.row.cmp(&self.row))
            .then(other.col.cmp(&self.col))
    }
}

impl PartialOrd for Item {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

fn highest_ranked_items(grid: Vec<Vec<i32>>, price_range: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
    let (m, n) = (grid.len() as i32, grid[0].len() as i32);
    let (low, high) = (price_range[0], price_range[1]);
    let mut pq = BinaryHeap::new();
    let mut visited = vec![vec![false; n as usize]; m as usize];

    for i in 0..m {
        for j in 0..n {
            if grid[i as usize][j as usize] >= low && grid[i as usize][j as usize] <= high {
                pq.push(Item {
                    price: grid[i as usize][j as usize],
                    row: i,
                    col: j,
                });
                visited[i as usize][j as usize] = true;
            }
        }
    }

    let mut result = Vec::new();
    let k = k as usize;

    while !pq.is_empty() && result.len() < k {
        let item = pq.pop().unwrap();
        result.push(vec![item.row, item.col]);
    }

    result
}
}