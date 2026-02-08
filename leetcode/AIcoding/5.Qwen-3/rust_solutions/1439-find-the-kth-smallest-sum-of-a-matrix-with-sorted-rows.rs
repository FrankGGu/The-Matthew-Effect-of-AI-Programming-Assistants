impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn kth_smallest(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut heap = BinaryHeap::new();
        heap.push((matrix[0][0], 0, 0));
        let mut visited = vec![vec![false; n]; m];
        visited[0][0] = true;

        let mut count = 0;
        while let Some((val, i, j)) = heap.pop() {
            count += 1;
            if count == k {
                return val;
            }
            if i + 1 < m && !visited[i + 1][j] {
                visited[i + 1][j] = true;
                heap.push((matrix[i + 1][j], i + 1, j));
            }
            if j + 1 < n && !visited[i][j + 1] {
                visited[i][j + 1] = true;
                heap.push((matrix[i][j + 1], i, j + 1));
            }
        }
        -1
    }
}
}