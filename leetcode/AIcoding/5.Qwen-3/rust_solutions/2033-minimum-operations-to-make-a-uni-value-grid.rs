struct Solution;

impl Solution {
    pub fn min_ops_to_make_geometric_grid(grid: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;

        let mut freq = HashMap::new();
        let mut min_val = i32::MAX;
        let mut max_val = i32::MIN;

        for row in &grid {
            for &val in row {
                *freq.entry(val).or_insert(0) += 1;
                min_val = min_val.min(val);
                max_val = max_val.max(val);
            }
        }

        let mut ops = 0;
        let mut current = min_val;

        while current <= max_val {
            if let Some(&count) = freq.get(&current) {
                ops += count;
                current += 1;
            } else {
                current += 1;
            }
        }

        ops
    }
}