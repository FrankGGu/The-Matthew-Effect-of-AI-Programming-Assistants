impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn minimum_score(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut graph = vec![Vec::new(); n];
        for e in edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut subtree_sum = vec![0; n];
        let mut visited = vec![false; n];

        fn dfs(node: usize, parent: usize, graph: &Vec<Vec<usize>>, nums: &Vec<i32>, subtree_sum: &mut Vec<i32>) -> i32 {
            let mut sum = nums[node];
            for &child in &graph[node] {
                if child != parent {
                    sum += dfs(child, node, graph, nums, subtree_sum);
                }
            }
            subtree_sum[node] = sum;
            sum
        }

        dfs(0, usize::MAX, &graph, &nums, &mut subtree_sum);

        let total = subtree_sum[0];

        let mut min_score = i32::MAX;

        for i in 0..n {
            for j in (i + 1)..n {
                let a = subtree_sum[i];
                let b = subtree_sum[j];
                let c = total - a - b;
                let score = (a - b).abs().max((b - c).abs()).max((c - a).abs());
                min_score = min_score.min(score);
            }
        }

        min_score
    }
}
}