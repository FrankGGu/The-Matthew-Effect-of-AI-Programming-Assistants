impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_damage_dealt_to_bob(attacks: Vec<Vec<i32>>, health: i32, damage: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for attack in attacks {
            let (time, power) = (attack[0], attack[1]);
            heap.push(Reverse((time, power)));
        }

        let mut total_damage = 0;
        let mut current_health = health;

        while current_health > 0 && !heap.is_empty() {
            let Reverse((time, power)) = heap.pop().unwrap();
            let hits = (current_health + power - 1) / power;
            total_damage += hits * time;
            current_health -= hits * power;
        }

        total_damage
    }
}
}