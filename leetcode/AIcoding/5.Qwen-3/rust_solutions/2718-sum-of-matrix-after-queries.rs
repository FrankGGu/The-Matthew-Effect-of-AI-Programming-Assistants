struct Solution;

impl Solution {
    pub fn matrix_sum(mut matrix: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();

        for q in queries {
            let x = q[0] as usize;
            let y = q[1] as usize;
            let val = q[2];

            for i in 0..n {
                for j in 0..m {
                    if i == x || j == y {
                        matrix[i][j] += val;
                    }
                }
            }
        }

        let mut sum = 0;
        for row in matrix {
            for num in row {
                sum += num;
            }
        }

        sum
    }
}