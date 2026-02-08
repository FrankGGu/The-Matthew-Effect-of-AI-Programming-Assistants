impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_operations_to_convert(num: i32, target: i32, change_cost: i32, merge_cost: i32) -> i32 {
        if num == target {
            return 0;
        }

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back((num, 0));
        visited.insert(num);

        while let Some((current, steps)) = queue.pop_front() {
            let current_str = current.to_string();

            for i in 0..current_str.len() {
                for j in i + 1..current_str.len() {
                    let mut new_num = String::new();
                    for k in 0..current_str.len() {
                        if k == i {
                            new_num.push(current_str.chars().nth(i).unwrap());
                        } else if k == j {
                            new_num.push(current_str.chars().nth(j).unwrap());
                        }
                    }

                    let merged_digit = current_str.chars().nth(i).unwrap().to_digit(10).unwrap() * 10
                        + current_str.chars().nth(j).unwrap().to_digit(10).unwrap();
                    let merged_num = new_num.parse::<i32>().unwrap();

                    if merged_num == target {
                        return steps + 1;
                    }

                    if !visited.contains(&merged_num) {
                        visited.insert(merged_num);
                        queue.push_back((merged_num, steps + 1));
                    }

                    for d in 0..10 {
                        let changed_digit = current_str.chars().nth(i).unwrap();
                        if d as u8 != changed_digit as u8 {
                            let mut changed_num = current_str.clone();
                            changed_num.replace_range(i..i + 1, &d.to_string());
                            let changed_num = changed_num.parse::<i32>().unwrap();

                            if changed_num == target {
                                return steps + change_cost;
                            }

                            if !visited.contains(&changed_num) {
                                visited.insert(changed_num);
                                queue.push_back((changed_num, steps + change_cost));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}
}