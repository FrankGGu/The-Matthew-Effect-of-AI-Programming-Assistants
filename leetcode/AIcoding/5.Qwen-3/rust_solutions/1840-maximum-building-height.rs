impl Solution {

use std::cmp::max;

struct Solution;

impl Solution {
    pub fn max_height(mut buildings: Vec<Vec<i32>>, r: i32, c: i32) -> i32 {
        let n = buildings.len();
        let m = buildings[0].len();

        let mut heights = vec![vec![0; m]; n];

        for i in 0..n {
            for j in 0..m {
                heights[i][j] = buildings[i][j];
            }
        }

        let mut updated = true;
        while updated {
            updated = false;
            for i in 0..n {
                for j in 0..m {
                    if buildings[i][j] == 0 {
                        let mut max_h = 0;
                        if i > 0 && heights[i - 1][j] > 0 {
                            max_h = max(max_h, heights[i - 1][j] - 1);
                        }
                        if i < n - 1 && heights[i + 1][j] > 0 {
                            max_h = max(max_h, heights[i + 1][j] - 1);
                        }
                        if j > 0 && heights[i][j - 1] > 0 {
                            max_h = max(max_h, heights[i][j - 1] - 1);
                        }
                        if j < m - 1 && heights[i][j + 1] > 0 {
                            max_h = max(max_h, heights[i][j + 1] - 1);
                        }
                        if max_h > 0 {
                            heights[i][j] = max_h;
                            updated = true;
                        }
                    }
                }
            }
        }

        let mut result = 0;
        for i in 0..n {
            for j in 0..m {
                if i == r as usize && j == c as usize {
                    continue;
                }
                result = max(result, heights[i][j]);
            }
        }

        result
    }
}
}