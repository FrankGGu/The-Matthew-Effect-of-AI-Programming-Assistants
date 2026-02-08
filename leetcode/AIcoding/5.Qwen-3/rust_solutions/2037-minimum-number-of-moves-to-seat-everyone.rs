impl Solution {
    pub fn min_moves_to_seat_everyone(seats: Vec<i32>, students: Vec<i32>) -> i32 {
        let mut seats = seats;
        let mut students = students;
        seats.sort();
        students.sort();
        let mut moves = 0;
        for i in 0..seats.len() {
            moves += (seats[i] - students[i]).abs();
        }
        moves
    }
}