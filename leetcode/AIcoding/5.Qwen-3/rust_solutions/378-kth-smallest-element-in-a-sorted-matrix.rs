struct Solution;

impl Solution {
    pub fn kth_smallest(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut left = matrix[0][0];
        let mut right = matrix[matrix.len() - 1][matrix.len() - 1];

        while left < right {
            let mid = left + (right - left) / 2;
            let count = Self::count_less_equal(&matrix, mid);
            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }

    fn count_less_equal(matrix: &Vec<Vec<i32>>, target: i32) -> i32 {
        let mut count = 0;
        let n = matrix.len();
        let mut row = 0;
        let mut col = n - 1;

        while row < n && col >= 0 {
            if matrix[row][col] <= target {
                count += (col + 1) as i32;
                row += 1;
            } else {
                col -= 1;
            }
        }

        count
    }
}