impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn max_events(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut set = BTreeSet::new();
        let mut res = 0;
        let mut i = 0;
        let n = events.len();

        while i < n {
            let start = events[i][0];
            let end = events[i][1];

            while i < n && events[i][0] == start {
                set.insert(events[i][1]);
                i += 1;
            }

            if let Some(&e) = set.iter().next() {
                res += 1;
                set.remove(&e);
                while i < n && events[i][0] <= e {
                    set.insert(events[i][1]);
                    i += 1;
                }
            } else {
                i += 1;
            }
        }

        res
    }
}
}