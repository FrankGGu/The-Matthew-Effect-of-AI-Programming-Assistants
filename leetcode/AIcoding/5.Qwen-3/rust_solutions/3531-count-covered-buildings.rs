struct Solution;

impl Solution {
    pub fn count_covered_buildings(positions: Vec<Vec<i32>>) -> i32 {
        use std::cmp::Ordering;
        use std::collections::BTreeSet;

        let mut buildings = Vec::new();
        for pos in positions {
            buildings.push((pos[0], pos[1]));
        }

        buildings.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                b.1.cmp(&a.1)
            }
        });

        let mut covered = 0;
        let mut heights = BTreeSet::new();

        for (x, h) in buildings {
            let mut found = false;
            let mut iter = heights.range(..h);
            if let Some(&height) = iter.next_back() {
                if height < h {
                    found = true;
                }
            }

            if found {
                covered += 1;
            } else {
                heights.insert(h);
            }
        }

        covered
    }
}