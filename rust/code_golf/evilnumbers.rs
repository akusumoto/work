fn main(){
    for n in 0..51{
        let mut c=0;
        for b in 0..7{
            c+=n>>b&1;
        }
        if c%2==0{
            println!("{}",n);
        }
    }
}
