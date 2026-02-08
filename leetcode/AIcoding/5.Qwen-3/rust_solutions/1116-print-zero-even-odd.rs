impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

struct ZeroEvenOdd {
    n: i32,
    zero: Arc<Mutex<bool>>,
    even: Arc<Mutex<bool>>,
    odd: Arc<Mutex<bool>>,
}

impl ZeroEvenOdd {
    fn new(n: i32) -> Self {
        ZeroEvenOdd {
            n,
            zero: Arc::new(Mutex::new(true)),
            even: Arc::new(Mutex::new(false)),
            odd: Arc::new(Mutex::new(false)),
        }
    }

    fn zero<F>(&self, print_number: F)
    where
        F: Fn(i32),
    {
        for i in 0..self.n {
            let mut z = self.zero.lock().unwrap();
            while !*z {
                thread::sleep(Duration::from_millis(1));
            }
            print_number(0);
            *z = false;
            if i % 2 == 0 {
                let mut o = self.odd.lock().unwrap();
                *o = true;
            } else {
                let mut e = self.even.lock().unwrap();
                *e = true;
            }
        }
    }

    fn even<F>(&self, print_number: F)
    where
        F: Fn(i32),
    {
        for i in 1..=self.n {
            if i % 2 == 0 {
                let mut e = self.even.lock().unwrap();
                while !*e {
                    thread::sleep(Duration::from_millis(1));
                }
                print_number(i);
                *e = false;
                let mut z = self.zero.lock().unwrap();
                *z = true;
            }
        }
    }

    fn odd<F>(&self, print_number: F)
    where
        F: Fn(i32),
    {
        for i in 1..=self.n {
            if i % 2 == 1 {
                let mut o = self.odd.lock().unwrap();
                while !*o {
                    thread::sleep(Duration::from_millis(1));
                }
                print_number(i);
                *o = false;
                let mut z = self.zero.lock().unwrap();
                *z = true;
            }
        }
    }
}

fn main() {
    let z = ZeroEvenOdd::new(5);
    let z_clone = Arc::clone(&z.zero);
    let e_clone = Arc::clone(&z.even);
    let o_clone = Arc::clone(&z.odd);

    let t1 = thread::spawn(move || {
        z.zero(move |n| {
            print!("{}", n);
        });
    });

    let t2 = thread::spawn(move || {
        z.even(move |n| {
            print!("{}", n);
        });
    });

    let t3 = thread::spawn(move || {
        z.odd(move |n| {
            print!("{}", n);
        });
    });

    t1.join().unwrap();
    t2.join().unwrap();
    t3.join().unwrap();
}
}