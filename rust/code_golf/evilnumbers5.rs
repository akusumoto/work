fn main(){for n in 0..51{if(0..7).fold(0,|s,b|s+(n>>b&1))%2==0{println!("{}",n);}}}
