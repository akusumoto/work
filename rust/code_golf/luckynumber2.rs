fn main(){
    let mut l=vec![1];
    for i in 1..9999{
        l.push(i*2+1)
    }
    for k in 1..153{
        let(a,n)=(l[k],l.len());
        let mut i=n-n%a-1;
        loop{
            l.remove(i);
            i=if i<a{break}else{i-a};
        }
    }
    for i in 0..1000{println!("{}",l[i])}}

