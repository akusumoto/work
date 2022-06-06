fn main(){
    for n in 1..1001{
        let g=|y,s|{if n%y>0{1}else{print!("{}",s);0}};
        if g(2,"Foo")+g(3,"Fizz")+g(5,"Buzz")+g(7,"Bar")>3{
            print!("{}",n);
        }
        println!("")
    }}
