impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn intersection_sizeAtLeastTwo(mut intervals: Vec<Vec<i32>>) -> i32 {
        intervals.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut result = 0;
        let mut last = -1;
        let mut second_last = -1;

        for interval in intervals {
            let start = interval[0];
            let end = interval[1];

            if start > second_last {
                result += 2;
                second_last = end;
                last = end;
            } else if start > last {
                result += 1;
                last = end;
            }
        }

        result
    }
}
}