struct RecentCounter {
    requests: std::collections::VecDeque<i32>,
}

impl RecentCounter {
    fn new() -> Self {
        RecentCounter {
            requests: std::collections::VecDeque::new(),
        }
    }

    fn ping(&mut self, t: i32) -> i32 {
        self.requests.push_back(t);
        while let Some(&first) = self.requests.front() {
            if t - first > 3000 {
                self.requests.pop_front();
            } else {
                break;
            }
        }
        self.requests.len() as i32
    }
}

fn main() {
    let mut obj = RecentCounter::new();
    println!("{}", obj.ping(1)); // Output: 1
    println!("{}", obj.ping(100)); // Output: 2
    println!("{}", obj.ping(3001)); // Output: 3
    println!("{}", obj.ping(3002)); // Output: 3
}