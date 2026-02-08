impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn maximum_points(archery_game: Vec<Vec<i32>>) -> Vec<i32> {
        fn dfs(
            game: &Vec<Vec<i32>>,
            index: usize,
            remaining_arrows: i32,
            path: &mut Vec<i32>,
            result: &mut Vec<i32>,
        ) {
            if index == game.len() {
                if path.iter().sum::<i32>() > result.iter().sum::<i32>() {
                    result.clone_from(path);
                }
                return;
            }

            let max_shots = game[index].iter().max().unwrap();
            let mut best_score = 0;
            let mut best_index = 0;

            for i in 0..game[index].len() {
                if game[index][i] > best_score {
                    best_score = game[index][i];
                    best_index = i;
                }
            }

            for i in 0..game[index].len() {
                if i == best_index && remaining_arrows >= 1 {
                    path.push(1);
                    dfs(game, index + 1, remaining_arrows - 1, path, result);
                    path.pop();
                } else if remaining_arrows >= 0 {
                    path.push(0);
                    dfs(game, index + 1, remaining_arrows, path, result);
                    path.pop();
                }
            }
        }

        let mut result = vec![0; archery_game.len()];
        let mut path = vec![];
        dfs(&archery_game, 0, 100, &mut path, &mut result);
        result
    }
}
}