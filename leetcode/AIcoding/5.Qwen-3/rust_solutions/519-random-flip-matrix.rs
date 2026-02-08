impl Solution {

use std::collections::HashSet;

struct Solution {
    n_rows: i32,
    n_cols: i32,
    total: i32,
    flipped: HashSet<i32>,
}

impl Solution {
    fn new(n_rows: i32, n_cols: i32) -> Self {
        Solution {
            n_rows,
            n_cols,
            total: n_rows * n_cols,
            flipped: HashSet::new(),
        }
    }

    fn flip(&mut self) -> Vec<i32> {
        let mut rand_num = (rand::random::<u32>() as i32) % self.total;
        while self.flipped.contains(&rand_num) {
            rand_num = (rand::random::<u32>() as i32) % self.total;
        }
        self.flipped.insert(rand_num);
        let row = rand_num / self.n_cols;
        let col = rand_num % self.n_cols;
        vec![row, col]
    }

    fn reset(&mut self) {
        self.flipped.clear();
    }
}
}