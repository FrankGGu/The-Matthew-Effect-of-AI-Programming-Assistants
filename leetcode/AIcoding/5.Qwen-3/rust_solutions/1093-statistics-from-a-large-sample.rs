impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn sample_stats(data: Vec<f64>) -> Vec<f64> {
        let mut count = HashMap::new();
        let mut max_freq = 0;
        let mut mode = 0.0;
        let mut sum = 0.0;
        let mut min = f64::INFINITY;
        let mut max = f64::NEG_INFINITY;
        let mut n = 0;

        for &val in &data {
            *count.entry(val).or_insert(0) += 1;
            let freq = *count.get(&val).unwrap();

            if freq > max_freq {
                max_freq = freq;
                mode = val;
            } else if freq == max_freq {
                if val < mode {
                    mode = val;
                }
            }

            sum += val;
            min = min.min(val);
            max = max.max(val);
            n += 1;
        }

        let mean = sum / n as f64;
        let median = if n % 2 == 1 {
            let mid = n / 2;
            let mut sorted = data.clone();
            sorted.sort_by(|a, b| a.partial_cmp(b).unwrap());
            sorted[mid]
        } else {
            let mid = n / 2;
            let mut sorted = data.clone();
            sorted.sort_by(|a, b| a.partial_cmp(b).unwrap());
            (sorted[mid - 1] + sorted[mid]) / 2.0
        };

        vec![mean, median, mode]
    }
}
}