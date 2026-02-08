impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn contains_pattern(arr: Vec<i32>, m: i32, k: i32) -> bool {
        let m = m as usize;
        let k = k as usize;
        let n = arr.len();

        for i in 0..n - m + 1 {
            let mut pattern = String::new();
            for j in 0..m {
                pattern.push_str(&arr[i + j].to_string());
                pattern.push(',');
            }

            let mut count = 0;
            let mut j = i;
            while j + m <= n {
                let current = &arr[j..j + m];
                let current_str = current.iter().map(|&x| x.to_string()).collect::<Vec<_>>().join(",");
                if current_str == pattern {
                    count += 1;
                    if count >= k {
                        return true;
                    }
                    j += m;
                } else {
                    break;
                }
            }
        }

        false
    }
}
}