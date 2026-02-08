impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn min_transfers(transactions: Vec<Vec<i32>>) -> i32 {
        let mut balances = HashMap::new();
        for t in transactions {
            let from = t[0];
            let to = t[1];
            let amount = t[2];
            *balances.entry(from).or_insert(0) -= amount;
            *balances.entry(to).or_insert(0) += amount;
        }

        let mut debt = Vec::new();
        for &b in balances.values() {
            if b != 0 {
                debt.push(b);
            }
        }

        debt.sort_by(|a, b| b.cmp(a));

        fn backtrack(debt: &mut Vec<i32>, index: usize, count: i32, result: &mut i32) {
            if index == debt.len() {
                *result = std::cmp::min(*result, count);
                return;
            }

            for i in index + 1..debt.len() {
                if debt[index] + debt[i] == 0 {
                    debt.swap(index + 1, i);
                    backtrack(debt, index + 1, count + 1, result);
                    debt.swap(index + 1, i);
                }
            }

            for i in index + 1..debt.len() {
                if debt[index] + debt[i] != 0 {
                    debt.swap(index + 1, i);
                    backtrack(debt, index + 1, count, result);
                    debt.swap(index + 1, i);
                }
            }
        }

        let mut result = i32::MAX;
        backtrack(&mut debt, 0, 0, &mut result);
        result
    }
}
}