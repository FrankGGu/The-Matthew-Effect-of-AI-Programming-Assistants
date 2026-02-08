impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn distribute_candies(mut candies: i32, mut num_people: i32) -> Vec<i32> {
        let mut result = vec![0; num_people as usize];
        let mut count = 1;
        let mut index = 0;

        while candies > 0 {
            let give = std::cmp::min(count, candies);
            result[index as usize] += give;
            candies -= give;
            count += 1;
            index = (index + 1) % num_people;
        }

        result
    }
}
}