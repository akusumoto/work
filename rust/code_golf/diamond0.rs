fn main() {
    for s in 1..=9 {
        for r in 1..=s {
            for _ in 0..(10-r) {
                print!(" ")
            }
            for c in 1..=r {
                print!("{}",c)
            }
            for c in (1..r).rev() {
                print!("{}",c)
            }
            println!("")
        }
        for r in (1..s).rev() {
            for _ in 0..(10-r) {
                print!(" ")
            }
            for c in 1..=r {
                print!("{}",c)
            }
            for c in (1..r).rev() {
                print!("{}",c)
            }
            println!("")
        }
        println!("")
    }
}
