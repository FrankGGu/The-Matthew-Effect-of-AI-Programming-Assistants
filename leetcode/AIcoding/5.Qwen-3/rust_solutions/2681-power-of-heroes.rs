impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn power_of_heroes(mut heroes: Vec<Vec<i32>>, mut attacks: Vec<Vec<i32>>) -> i32 {
        let n = heroes.len();
        let m = attacks.len();

        let mut hero_heap = BinaryHeap::new();

        for i in 0..n {
            hero_heap.push((-heroes[i][0], heroes[i][1]));
        }

        attacks.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut result = 0;

        while let Some((mut health, damage)) = hero_heap.pop() {
            health *= -1;

            while let Some(attacker) = attacks.last() {
                if attacker[0] < health {
                    let attack_damage = attacker[1];
                    health -= attack_damage;
                    attacks.pop();
                } else {
                    break;
                }
            }

            if health > 0 {
                result += damage;
            }
        }

        result
    }
}
}