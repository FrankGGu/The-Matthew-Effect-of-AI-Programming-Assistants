impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_array(mut subset_sums: Vec<i32>) -> Vec<i32> {
        subset_sums.sort_unstable();
        let n = subset_sums.len();
        let mut result = vec![];
        let mut s = HashSet::new();
        for &sum in &subset_sums {
            s.insert(sum);
        }
        let mut sum_set = s;
        let mut total = subset_sums[0];
        let mut current_sum = 0;
        let mut i = 0;
        while i < n {
            if current_sum == subset_sums[i] {
                i += 1;
                continue;
            }
            let val = subset_sums[i] - current_sum;
            result.push(val);
            current_sum += val;
            for j in (i + 1)..n {
                if subset_sums[j] - val < subset_sums[i] {
                    break;
                }
                if subset_sums[j] - val > subset_sums[i] {
                    break;
                }
                if subset_sums[j] - val == subset_sums[i] {
                    i += 1;
                }
            }
        }
        result
    }
}
}