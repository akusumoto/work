fn main(){let b="12345678987654321";for s in 1..=9{for n in 1..(s*2){let i=if n>s{2*s-n}else{n};println!("{}{}{}"," ".repeat(10-i),&b[0..i],&b[(18-i)..17])}println!("")}}
