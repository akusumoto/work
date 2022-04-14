fn main(){let mut l=vec![1];for i in 0..10000{l.push(l[i]+2);}for k in 1..1000{let a=l[k];for i in(0..l.len()).rev(){if(i+1)%a==0{l.remove(i);}}}for i in 0..1000{println!("{}",l[i])}}
