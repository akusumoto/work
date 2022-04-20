fn main(){
    println!("2");
    for i in 0..50{
        if 0x894d325a65b7 as u64 & 1<<i>0{
            println!("{}",i*2+3)
        }
    }
}
