struct Solution;

impl Solution {
    pub fn have_conflict(event1: Vec<String>, event2: Vec<String>) -> bool {
        let start1 = event1[0].parse::<i32>().unwrap();
        let end1 = event1[1].parse::<i32>().unwrap();
        let start2 = event2[0].parse::<i32>().unwrap();
        let end2 = event2[1].parse::<i32>().unwrap();

        start1 < end2 && start2 < end1
    }
}