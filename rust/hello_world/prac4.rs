use std::fmt;

struct Position {
    x: i32,
    y: i32,
}
impl Position {
    fn area(&self) -> i32 {
        self.x * self.y
    }
}

impl Copy for Position {}
impl Clone for Position {
    fn clone(&self) -> Position {
        *self
    }
}
impl fmt::Display for Position {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Position (x={}, y={})", self.x, self.y)
    }
}

fn area1(mut p: Position) -> i32 {
    p.x = 1;
    p.x * p.y 
}

fn area2(p: &mut Position) -> i32 {
    p.x = -1;
    p.x * p.y
}

fn main() {
    let mut p = Position {
        x: 10,
        y: 20
    };

    //println!("{:?}", p);
    println!("{}", p); // call std::fmt:Display for Position
    println!("x={} y={}", p.x, p.y);
    println!("area1={}", area1(p)); // コピートレイト Copy Trait 
    println!("x={} y={}", p.x, p.y);
    println!("area2={}", area2(&mut p)); // 借用 Borrowing
    println!("x={} y={}", p.x, p.y);
    println!("Position#area={}", p.area());
}

