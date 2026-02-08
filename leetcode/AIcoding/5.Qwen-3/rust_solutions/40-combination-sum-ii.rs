impl Solution {

use std::vec;

fn main() {}

fn combination_sum_ii(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut path = Vec::new();
    let mut candidates = candidates;
    candidates.sort();
    backtrack(&mut result, &mut path, &candidates, target, 0);
    result
}

fn backtrack(
    result: &mut Vec<Vec<i32>>,
    path: &mut Vec<i32>,
    candidates: &[i32],
    target: i32,
    start: usize,
) {
    if target == 0 {
        result.push(path.clone());
        return;
    }
    for i in start..candidates.len() {
        if i > start && candidates[i] == candidates[i - 1] {
            continue;
        }
        if candidates[i] > target {
            break;
        }
        path.push(candidates[i]);
        backtrack(result, path, candidates, target - candidates[i], i + 1);
        path.pop();
    }
}
}