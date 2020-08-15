fn main() {
    let mut s11 = String::from("hello");
    let mut s12 = &mut s11;

    let mut s21 = String::from("aaaaa");
    let mut s22 = s21.clone();

    s12.push_str("c");
    s22.push_str("c");

    println!("s11={} s12={}", s11, s12);
    println!("s21={} s22={}", s21, s22);
}
