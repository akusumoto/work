use std::io;
use std::io::Write;

fn main() {
    print!("input number: ");
    io::stdout().flush().unwrap();

    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();

    let n: i32 = s.trim().parse().unwrap();

    for _ in 0..n {
        println!("hello world");
    }
}
