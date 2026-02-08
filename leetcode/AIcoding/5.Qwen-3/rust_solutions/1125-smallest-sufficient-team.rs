impl Solution {

use std::collections::HashMap;

fn main() {}

struct Solution;

impl Solution {
    pub fn smallest_sufficient_team(
        skills: Vec<String>,
        people: Vec<Vec<String>>,
    ) -> Vec<i32> {
        let mut skill_index = HashMap::new();
        for (i, skill) in skills.iter().enumerate() {
            skill_index.insert(skill, i);
        }

        let n = skills.len();
        let m = people.len();

        let mut person_skills = vec![0; m];
        for (i, person) in people.iter().enumerate() {
            let mut mask = 0;
            for skill in person {
                if let Some(&idx) = skill_index.get(skill) {
                    mask |= 1 << idx;
                }
            }
            person_skills[i] = mask;
        }

        let target = (1 << n) - 1;

        let mut dp = HashMap::new();
        dp.insert(0, vec![]);

        for (i, &mask) in person_skills.iter().enumerate() {
            if mask == 0 {
                continue;
            }

            let mut new_dp = dp.clone();
            for (skill_mask, team) in &dp {
                let new_mask = skill_mask | mask;
                if new_mask != *skill_mask {
                    let mut new_team = team.clone();
                    new_team.push(i as i32);
                    if !new_dp.contains_key(&new_mask) || new_team.len() < new_dp[&new_mask].len() {
                        new_dp.insert(new_mask, new_team);
                    }
                }
            }

            dp = new_dp;
        }

        dp.get(&target).cloned().unwrap_or(vec![])
    }
}
}