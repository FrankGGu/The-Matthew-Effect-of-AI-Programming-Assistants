impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

struct H2O {
    h_count: Mutex<usize>,
    o_count: Mutex<usize>,
    h_mutex: Mutex<()>,
    o_mutex: Mutex<()>,
}

impl H2O {
    fn new() -> Self {
        H2O {
            h_count: Mutex::new(0),
            o_count: Mutex::new(0),
            h_mutex: Mutex::new(()),
            o_mutex: Mutex::new(()),
        }
    }

    fn hydrogen<F>(&self, f: F)
    where
        F: FnOnce(),
    {
        let _h_lock = self.h_mutex.lock().unwrap();
        {
            let mut h_count = self.h_count.lock().unwrap();
            *h_count += 1;
        }
        if *self.h_count.lock().unwrap() == 2 && *self.o_count.lock().unwrap() == 1 {
            f();
            *self.h_count.lock().unwrap() = 0;
            *self.o_count.lock().unwrap() = 0;
        }
    }

    fn oxygen<F>(&self, f: F)
    where
        F: FnOnce(),
    {
        let _o_lock = self.o_mutex.lock().unwrap();
        {
            let mut o_count = self.o_count.lock().unwrap();
            *o_count += 1;
        }
        if *self.h_count.lock().unwrap() == 2 && *self.o_count.lock().unwrap() == 1 {
            f();
            *self.h_count.lock().unwrap() = 0;
            *self.o_count.lock().unwrap() = 0;
        }
    }
}

fn main() {
    let h2o = Arc::new(H2O::new());

    for _ in 0..3 {
        let h2o_clone = Arc::clone(&h2o);
        thread::spawn(move || {
            h2o_clone.hydrogen(|| {
                println!("H");
            });
        });
    }

    for _ in 0..1 {
        let h2o_clone = Arc::clone(&h2o);
        thread::spawn(move || {
            h2o_clone.oxygen(|| {
                println!("O");
            });
        });
    }

    thread::sleep(Duration::from_secs(1));
}
}