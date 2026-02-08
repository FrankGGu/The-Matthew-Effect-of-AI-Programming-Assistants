impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_score(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            for j in 0..n {
                max_heap.push(Reverse(grid[i][j]));
            }
        }

        let mut score = 0;
        let mut steps = 0;

        while let Some(Reverse(val)) = max_heap.pop() {
            if steps % 2 == 0 {
                score += val;
            }
            steps += 1;
        }

        score
    }
}
}