impl Solution {

use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn max_total_weights(n: i32, edges: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph[u].push((v, w));
            graph[v].push((u, w));
        }

        let mut parent = vec![0; n];
        let mut depth = vec![0; n];
        let mut size = vec![1; n];
        let mut heavy = vec![-1; n];
        let mut head = vec![0; n];
        let mut pos = vec![0; n];
        let mut current_pos = 0;

        fn dfs(u: usize, p: usize, graph: &Vec<Vec<(usize, i32)>>, parent: &mut Vec<usize>, depth: &mut Vec<usize>, size: &mut Vec<usize>, heavy: &mut Vec<isize>) {
            for &(v, _) in &graph[u] {
                if v != p {
                    parent[v] = u;
                    depth[v] = depth[u] + 1;
                    dfs(v, u, graph, parent, depth, size, heavy);
                    size[u] += size[v];
                    if heavy[u] == -1 || size[v] > size[heavy[u] as usize] {
                        heavy[u] = v as isize;
                    }
                }
            }
        }

        fn decompose(u: usize, h: usize, graph: &Vec<Vec<(usize, i32)>>, parent: &Vec<usize>, heavy: &Vec<isize>, head: &mut Vec<usize>, pos: &mut Vec<usize>, current_pos: &mut usize) {
            head[u] = h;
            pos[u] = *current_pos;
            *current_pos += 1;
            if heavy[u] != -1 {
                decompose(heavy[u] as usize, h, graph, parent, heavy, head, pos, current_pos);
                for &(v, _) in &graph[u] {
                    if v != parent[u] && v != heavy[u] as usize {
                        decompose(v, v, graph, parent, heavy, head, pos, current_pos);
                    }
                }
            }
        }

        dfs(0, 0, &graph, &mut parent, &mut depth, &mut size, &mut heavy);
        decompose(0, 0, &graph, &parent, &heavy, &mut head, &mut pos, &mut current_pos);

        let mut weight = vec![0; n];
        for i in 0..n {
            weight[i] = graph[i].iter().map(|&(_, w)| w).sum();
        }

        let mut seg_tree = SegmentTree::new(n);
        for i in 0..n {
            seg_tree.update(pos[i], weight[i]);
        }

        let mut result = vec![];
        for q in queries {
            let u = q as usize;
            let h = head[u];
            let res = seg_tree.query_range(pos[h], pos[h]);
            result.push(res);
        }

        result
    }
}

struct SegmentTree {
    size: usize,
    data: Vec<i32>,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        let mut n = 1;
        while n < size {
            n <<= 1;
        }
        Self {
            size: n,
            data: vec![0; 2 * n],
        }
    }

    fn update(&mut self, idx: usize, value: i32) {
        let mut idx = idx + self.size;
        self.data[idx] = value;
        while idx > 1 {
            idx >>= 1;
            self.data[idx] = self.data[2 * idx].max(self.data[2 * idx + 1]);
        }
    }

    fn query_range(&self, l: usize, r: usize) -> i32 {
        let mut res = 0;
        let mut l = l + self.size;
        let mut r = r + self.size;
        while l <= r {
            if l % 2 == 1 {
                res = res.max(self.data[l]);
                l += 1;
            }
            if r % 2 == 0 {
                res = res.max(self.data[r]);
                r -= 1;
            }
            l >>= 1;
            r >>= 1;
        }
        res
    }
}
}