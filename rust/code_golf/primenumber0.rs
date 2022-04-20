fn main(){
    for n in 2..101 {
        let mut p = true;
        for i in 2..n {
            if n % i == 0 {
                p = false;
            }
        }
        if p {
            println!("{}",n)
        } 
    }
}
