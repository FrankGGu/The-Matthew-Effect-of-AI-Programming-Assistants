struct Solution;

impl Solution {
    pub fn reduce_oldest_dishes(pantry: Vec<i32>) -> i32 {
        let mut dishes = pantry;
        dishes.sort();
        let n = dishes.len();
        let mut total = 0;
        for i in 0..n {
            total += dishes[i] * (i as i32 + 1);
        }
        total
    }
}