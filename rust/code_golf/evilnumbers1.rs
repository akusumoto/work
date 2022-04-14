fn main(){for n in 0..51{let(mut i,mut c)=(n,0);while i>0{c+=i&1;i>>=1;}if c%2==0{println!("{}",n);}}}
