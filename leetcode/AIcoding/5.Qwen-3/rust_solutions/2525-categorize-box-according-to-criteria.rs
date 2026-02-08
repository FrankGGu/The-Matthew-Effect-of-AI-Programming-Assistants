struct Solution;

impl Solution {
    pub fn categorize_box(mut length: i32, mut width: i32, mut height: i32, mut mass: i32) -> String {
        let mut is_heavy = mass >= 100;
        let mut is_bulky = false;

        let mut volume = 1i64;
        for &dim in &[length, width, height] {
            volume *= dim as i64;
        }

        if volume >= 1_000_000_000 {
            is_bulky = true;
        }

        if is_bulky && is_heavy {
            "Both".to_string()
        } else if is_bulky {
            "Bulky".to_string()
        } else if is_heavy {
            "Heavy".to_string()
        } else {
            "Neither".to_string()
        }
    }
}