enum Kind {
    K1,
    K2,
    K3,
}

fn check(k: Kind) {
    match k {
        Kind::K1 => println!("K1"),
        _ => println!(".."),
    }
}

fn main() {
    let a = Kind::K1;
    let b = Kind::K3;

    check(a);
    check(b);
}
