fn main(){for n in 1..1001{let mut f=0;if n%2==0{print!("Foo");f=1;}if n%3==0{print!("Fizz");f=1;}if n%5==0{print!("Buzz");f=1;}if n%7==0{print!("Bar");f=1;}if f==0{print!("{}",n);}println!("")}}
