impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn longest_common_subpath(n: i32, paths: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut min_len = usize::MAX;
        for path in &paths {
            min_len = std::cmp::min(min_len, path.len());
        }

        for length in (1..=min_len).rev() {
            let mut set = HashSet::new();
            for i in 0..n {
                let path = &paths[i];
                for j in 0..=path.len() - length {
                    let subpath = &path[j..j + length];
                    set.insert(subpath);
                }
            }

            for i in 1..n {
                let path = &paths[i];
                let mut found = false;
                for j in 0..=path.len() - length {
                    let subpath = &path[j..j + length];
                    if set.contains(subpath) {
                        found = true;
                        break;
                    }
                }
                if !found {
                    break;
                }
            }

            if n == 1 {
                return length as i32;
            }

            let mut all_found = true;
            for i in 1..n {
                let path = &paths[i];
                let mut found = false;
                for j in 0..=path.len() - length {
                    let subpath = &path[j..j + length];
                    if set.contains(subpath) {
                        found = true;
                        break;
                    }
                }
                if !found {
                    all_found = false;
                    break;
                }
            }

            if all_found {
                return length as i32;
            }
        }

        0
    }
}
}