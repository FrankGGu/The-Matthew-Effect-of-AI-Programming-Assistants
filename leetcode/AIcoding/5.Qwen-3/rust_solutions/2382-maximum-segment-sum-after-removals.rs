impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn maximum_segment_sum(nums: Vec<i32>, remove_queries: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        let mut sum = nums.clone();

        for i in 0..n {
            parent[i] = i;
        }

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        fn union(parent: &mut Vec<usize>, size: &mut Vec<usize>, sum: &mut Vec<i32>, x: usize, y: usize) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x == root_y {
                return;
            }
            if size[root_x] < size[root_y] {
                std::mem::swap(&mut root_x, &mut root_y);
            }
            parent[root_y] = root_x;
            size[root_x] += size[root_y];
            sum[root_x] += sum[root_y];
        }

        let mut map = HashMap::new();
        for i in 0..n {
            map.insert(nums[i], i);
        }

        let mut res = Vec::with_capacity(remove_queries.len());
        let mut removed = HashSet::new();

        for q in remove_queries {
            let idx = *map.get(&q).unwrap();
            removed.insert(idx);
            let left = idx.saturating_sub(1);
            let right = idx + 1;

            if left < n && !removed.contains(&left) {
                union(&mut parent, &mut size, &mut sum, idx, left);
            }
            if right < n && !removed.contains(&right) {
                union(&mut parent, &mut size, &mut sum, idx, right);
            }

            let root = find(&mut parent, idx);
            res.push(sum[root]);
        }

        res
    }
}
}