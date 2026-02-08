impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_initial_energy(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| {
            let a_diff = a[1] - a[0];
            let b_diff = b[1] - b[0];
            match a_diff.cmp(&b_diff) {
                Ordering::Equal => b[0].cmp(&a[0]),
                other => other,
            }
        });

        let mut energy = 0;
        let mut min_energy = 0;

        for task in tasks {
            energy += task[0];
            min_energy = std::cmp::max(min_energy, energy);
            energy -= task[1];
        }

        min_energy
    }
}
}