impl Solution {

use std::io;
use std::io::Read;

struct Solution {}

impl Solution {
    pub fn pass_the_pillow(n: i32, time: i32) -> i32 {
        let mut current = 0;
        let mut direction = 1;
        for _ in 0..time {
            current = (current as i32 + direction) as i32;
            if current == n - 1 || current == 0 {
                direction *= -1;
            }
        }
        current + 1
    }
}

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).unwrap();
    let mut lines = input.lines();
    let n = lines.next().unwrap().parse::<i32>().unwrap();
    let time = lines.next().unwrap().parse::<i32>().unwrap();
    println!("{}", Solution::pass_the_pillow(n, time));
}
}