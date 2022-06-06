fn main(){for n in 1..1001{let g=|y,s|{if n%y==0{print!("{}",s);1}else{0}};if g(2,"Foo")+g(3,"Fizz")+g(5,"Buzz")+g(7,"Bar")==0{print!("{}",n);}println!("")}}
