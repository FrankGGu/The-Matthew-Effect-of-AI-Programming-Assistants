impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn connect_two_groups(
        _dist: Vec<Vec<i32>>,
        _target: Vec<i32>,
        _cost: Vec<Vec<i32>>,
    ) -> i32 {
        unimplemented!()
    }
}

pub struct Solution;

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct State {
    mask: usize,
    pos: usize,
}

fn min_cost_connect_two_groups(
    dist: Vec<Vec<i32>>,
    target: Vec<i32>,
    cost: Vec<Vec<i32>>,
) -> i32 {
    let n = dist.len();
    let m = target.len();

    let mut dp = vec![vec![i32::MAX; m]; 1 << n];
    let mut q = VecDeque::new();

    for i in 0..n {
        let mut mask = 1 << i;
        for j in 0..m {
            dp[mask][j] = cost[i][j];
        }
        q.push_back(State { mask, pos: i });
    }

    while let Some(State { mask, pos }) = q.pop_front() {
        for i in 0..n {
            if mask & (1 << i) == 0 {
                let new_mask = mask | (1 << i);
                let new_pos = i;
                let new_cost = dp[mask][pos] + cost[new_pos][pos];

                if new_cost < dp[new_mask][pos] {
                    dp[new_mask][pos] = new_cost;
                    q.push_back(State { mask: new_mask, pos: new_pos });
                }
            }
        }
    }

    let mut result = i32::MAX;
    for mask in 0..(1 << n) {
        let mut total = 0;
        for j in 0..m {
            let mut min_cost = i32::MAX;
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    min_cost = min_cost.min(dp[mask][i] + dist[i][j]);
                }
            }
            if min_cost == i32::MAX {
                return -1;
            }
            total += min_cost;
        }
        result = result.min(total);
    }

    result
}

pub fn connect_two_groups(
    dist: Vec<Vec<i32>>,
    target: Vec<i32>,
    cost: Vec<Vec<i32>>,
) -> i32 {
    min_cost_connect_two_groups(dist, target, cost)
}
}