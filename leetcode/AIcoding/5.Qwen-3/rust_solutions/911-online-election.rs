impl Solution {

use std::collections::HashMap;

struct TopVotedCandidate {
    times: Vec<i32>,
    leaders: Vec<i32>,
}

impl TopVotedCandidate {
    fn new(players: Vec<i32>, times: Vec<i32>) -> Self {
        let mut count = HashMap::new();
        let mut leader = players[0];
        let mut leaders = Vec::new();
        for (t, &p) in times.iter().zip(&players) {
            *count.entry(p).or_insert(0) += 1;
            if count[&p] >= count[&leader] {
                leader = p;
            }
            leaders.push(leader);
        }
        TopVotedCandidate { times, leaders }
    }

    fn q(&self, t: i32) -> i32 {
        let mut left = 0;
        let mut right = self.times.len() - 1;
        while left < right {
            let mid = (left + right + 1) / 2;
            if self.times[mid] <= t {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        self.leaders[left]
    }
}
}