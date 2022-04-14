fn main(){
    let b="         12345678987654321";
    for s in 1..=9{
        let mut i = 1;
        while i>0 {
            println!("{}{}",&b[i..i+10],&b[26-i..26]);
            i+=1;
            if s<1 {break}
        };
        println!("")}}
