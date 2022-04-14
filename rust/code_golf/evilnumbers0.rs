fn main()
{
    for n in 0..=50 {
        let mut i = n;
        let mut c = 0;
        while i > 0 {
            if i & 1 == 1 {
                c += 1;
            }
            i >>= 1;
        }
        if c % 2 == 0 {
            println!("{}", n);
        }
    }
}
