impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_players_with_zero_or_one_loss(competitors: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut losses = std::collections::HashMap::new();
        let mut players = HashSet::new();

        for pair in competitors {
            let player1 = pair[0];
            let player2 = pair[1];
            players.insert(player1);
            players.insert(player2);

            *losses.entry(player1).or_insert(0) += 1;
            *losses.entry(player2).or_insert(0) += 0;
        }

        let mut zero_loss = Vec::new();
        let mut one_loss = Vec::new();

        for player in players {
            let loss_count = *losses.get(&player).unwrap();
            if loss_count == 0 {
                zero_loss.push(player);
            } else if loss_count == 1 {
                one_loss.push(player);
            }
        }

        zero_loss.sort();
        one_loss.sort();

        vec![zero_loss, one_loss]
    }
}
}