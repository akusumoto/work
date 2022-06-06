fn main(){
    let mut a:u64 = 0x0;
    let mut n = 100;
    let mut b = 0x1;
    while n > 1 {
        let mut p = true;
        for i in 2..n{
            if n%i==0{
                p = false;
            }
        }
        if p {
            a |= b;
        }

        b <<= 1;
        n -= 2;
    }
    println!("0x{:x}",a)
}
