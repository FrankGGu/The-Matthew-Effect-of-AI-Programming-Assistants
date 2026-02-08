struct Solution;

impl Solution {
    pub fn max_students(rooms: Vec<Vec<i32>>) -> i32 {
        let mut result = 0;
        for room in rooms {
            let mut count = 0;
            let mut i = 0;
            while i < room.len() {
                if room[i] == 1 {
                    i += 1;
                    continue;
                }
                let mut j = i;
                while j < room.len() && room[j] == 0 {
                    j += 1;
                }
                let length = j - i;
                let seats = (length + 1) / 2;
                count += seats;
                i = j;
            }
            result += count;
        }
        result
    }
}