use std::thread;
use std::time;
use std::sync::mpsc;
use std::sync::mpsc::{Sender, Receiver};

fn run(tx: &Sender<String>) {
    loop {
        tx.send(String::from("OK")).unwrap();
        thread::sleep(time::Duration::from_secs(1));
    }
}

fn main() {
    let (tx, rx) = mpsc::channel::<String>();

    thread::spawn(move || run(&tx));

    loop {
        let s = rx.recv().unwrap();
        println!("{}", s);
        thread::sleep(time::Duration::from_secs(1));
    }
}
