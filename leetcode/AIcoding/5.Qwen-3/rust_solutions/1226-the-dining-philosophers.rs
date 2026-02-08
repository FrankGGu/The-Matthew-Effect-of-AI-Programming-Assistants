impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

struct DiningPhilosophers {}

impl DiningPhilosophers {
    fn new() -> Self {
        DiningPhilosophers {}
    }

    fn wants_to_eat(
        &self,
        philosopher: i32,
        pick_left_fork: &dyn Fn(i32) -> (),
        pick_right_fork: &dyn Fn(i32) -> (),
        eat: &dyn Fn() -> (),
        put_left_fork: &dyn Fn(i32) -> (),
        put_right_fork: &dyn Fn(i32) -> (),
    ) {
        let forks = Arc::new(Mutex::new(vec![true; 5]));
        let fork1 = philosopher;
        let fork2 = (philosopher + 1) % 5;

        let mut forks = forks.lock().unwrap();
        while !forks[fork1 as usize] || !forks[fork2 as usize] {
            drop(forks);
            thread::sleep(Duration::from_millis(1));
            forks = forks.lock().unwrap();
        }
        forks[fork1 as usize] = false;
        forks[fork2 as usize] = false;
        drop(forks);

        pick_left_fork(fork1);
        pick_right_fork(fork2);
        eat();
        put_left_fork(fork1);
        put_right_fork(fork2);
    }
}
}