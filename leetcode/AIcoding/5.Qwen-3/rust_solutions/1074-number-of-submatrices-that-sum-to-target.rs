impl Solution {
    pub fn num_submatrix_sum_target(matrix: Vec<Vec<i32>>, target: i32) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut result = 0;

        for left in 0..cols {
            let mut row_sums = vec![0; rows];
            for right in left..cols {
                for i in 0..rows {
                    row_sums[i] += matrix[i][right];
                }

                let mut prefix_sum = 0;
                let mut sum_count = std::collections::HashMap::new();
                sum_count.insert(0, 1);
                for &sum in &row_sums {
                    prefix_sum += sum;
                    if let Some(&count) = sum_count.get(&(prefix_sum - target)) {
                        result += count;
                    }
                    *sum_count.entry(prefix_sum).or_insert(0) += 1;
                }
            }
        }

        result
    }
}