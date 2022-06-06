fn main(){for n in 2..101{let mut p=1;for i in 2..n{if n%i==0{p=0;}}if p==1{println!("{}",n)}}}
