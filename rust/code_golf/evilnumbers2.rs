fn c(x:i16)->i16{if x==0{0}else{c(x>>1)+x&1}}
fn main(){for n in(0..51).filter(|x|c(*x)%2==0){println!("{}",n);}}
