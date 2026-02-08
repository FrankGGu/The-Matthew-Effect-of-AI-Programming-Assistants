impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution {
    rects: Vec<Vec<i32>>,
    prefix_sums: Vec<i32>,
}

impl Solution {
    fn new(rects: Vec<Vec<i32>>) -> Self {
        let mut prefix_sums = Vec::new();
        let mut area = 0;
        for rect in &rects {
            let w = rect[2] - rect[0] + 1;
            let h = rect[3] - rect[1] + 1;
            area += w * h;
            prefix_sums.push(area);
        }
        Solution { rects, prefix_sums }
    }

    fn pick(&self) -> Vec<i32> {
        use rand::Rng;
        let mut rng = rand::thread_rng();
        let mut idx = rng.gen_range(0..self.prefix_sums.last().unwrap());
        idx += 1;
        let mut left = 0;
        let mut right = self.prefix_sums.len() - 1;
        while left < right {
            let mid = (left + right) / 2;
            match self.prefix_sums[mid].cmp(&idx) {
                Ordering::Less => left = mid + 1,
                _ => right = mid,
            }
        }
        let rect = &self.rects[left];
        let w = rect[2] - rect[0] + 1;
        let h = rect[3] - rect[1] + 1;
        let x = rng.gen_range(rect[0]..=rect[2]);
        let y = rng.gen_range(rect[1]..=rect[3]);
        vec![x, y]
    }
}
}