fn main(){let(a,b,c)=("          ","123456789","87654321");for s in 1..=9{for n in 1..(s*2){let i=if n>s{2*s-n}else{n};println!("{}{}{}",&a[0..(10-i)],&b[0..i],&c[(9-i)..8])}println!("")}}
