struct MyCalendarThree {
    events: std::collections::BTreeMap<i32, i32>,
}

impl MyCalendarThree {
    fn new() -> Self {
        MyCalendarThree {
            events: std::collections::BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> i32 {
        *self.events.entry(start).or_insert(0) += 1;
        *self.events.entry(end).or_insert(0) -= 1;

        let mut max = 0;
        let mut current = 0;

        for (&_, &delta) in &self.events {
            current += delta;
            max = std::cmp::max(max, current);
        }

        max
    }
}