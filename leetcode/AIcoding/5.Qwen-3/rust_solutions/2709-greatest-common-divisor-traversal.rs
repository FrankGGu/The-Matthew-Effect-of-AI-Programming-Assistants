impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn greatest_common_divisor_traversal(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> bool {
        let n = nums.len();
        let mut parent = (0..n).collect::<Vec<usize>>();

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
                parent[root_y] = root_x;
            }
        }

        let mut prime_to_indices = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            let mut num = num as i64;
            let mut p = 2;
            while p * p <= num {
                if num % p == 0 {
                    prime_to_indices.entry(p).or_insert(Vec::new()).push(i);
                    while num % p == 0 {
                        num /= p;
                    }
                }
                p += 1;
            }
            if num > 1 {
                prime_to_indices.entry(num as i32).or_insert(Vec::new()).push(i);
            }
        }

        for (_, indices) in prime_to_indices {
            for i in 1..indices.len() {
                union(&mut parent, indices[0], indices[i]);
            }
        }

        let root = find(&mut parent, 0);
        for i in 1..n {
            if find(&mut parent, i) != root {
                return false;
            }
        }

        true
    }
}
}