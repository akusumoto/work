fn main() {
    let x = 10;
    let y = if x > 0 { "positive" } else { "negative" };
    let z = {
        if x > 0 {
            "positive"
        } else {
            "negative"
        }
    };

    println!("x={} y={} z={}", x, y, z);
}
