impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimize_hamming_distance(assignment: Vec<Vec<i32>>, swap_map: Vec<Vec<i32>>) -> i32 {
        let n = assignment.len();
        let m = assignment[0].len();

        let mut parent = (0..n).collect::<Vec<_>>();

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        fn union(parent: &mut Vec<usize>, x: usize, y: usize) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x != root_y {
                parent[root_x] = root_y;
            }
        }

        for swap in swap_map {
            let u = swap[0] as usize;
            let v = swap[1] as usize;
            union(&mut parent, u, v);
        }

        let mut groups = HashMap::new();

        for i in 0..n {
            let root = find(&mut parent, i);
            groups.entry(root).or_insert_with(Vec::new).push(i);
        }

        let mut result = 0;

        for group in groups.values() {
            let mut count = HashMap::new();
            for &i in group {
                for j in 0..m {
                    let val = assignment[i][j];
                    *count.entry(val).or_insert(0) += 1;
                }
            }

            for j in 0..m {
                let mut freq = HashMap::new();
                for &i in group {
                    let val = assignment[i][j];
                    *freq.entry(val).or_insert(0) += 1;
                }

                let max_freq = freq.values().max().copied().unwrap_or(0);
                result += max_freq;
            }
        }

        result
    }
}
}