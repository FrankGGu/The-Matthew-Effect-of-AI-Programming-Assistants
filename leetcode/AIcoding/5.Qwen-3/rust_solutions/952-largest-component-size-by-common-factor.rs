impl Solution {

use std::collections::{HashMap, HashSet};

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            self.parent[root_y] = root_x;
        }
    }
}

impl Solution {
    pub fn largest_component_size(mut nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut uf = UnionFind::new(max_num + 1);

        for &num in &nums {
            let num = num as usize;
            let mut i = 2;
            while i * i <= num {
                if num % i == 0 {
                    uf.union(i, num);
                    uf.union(i, num / i);
                }
                i += 1;
            }
        }

        let mut map = HashMap::new();
        let mut max_size = 0;

        for &num in &nums {
            let num = num as usize;
            let root = uf.find(num);
            *map.entry(root).or_insert(0) += 1;
            max_size = max_size.max(*map.get(&root).unwrap());
        }

        max_size as i32
    }
}
}