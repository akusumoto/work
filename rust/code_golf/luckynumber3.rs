fn main(){let mut l=vec![1];for i in 1..9999{l.push(i*2+1);}for k in 1..999{let a=l[k];for i in(0..l.len()).rev(){if(i+1)%a==0{l.remove(i);}}}for i in 0..1000{println!("{}",l[i])}}

