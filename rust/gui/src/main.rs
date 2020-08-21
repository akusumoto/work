extern crate gtk;
extern crate gio;
extern crate glib;

use gio::prelude::*;
use gtk::prelude::*;
use gtk::{Application, ApplicationWindow, ScrolledWindow, TextView, ContainerExt};
use std::env;
use std::thread;
use std::time;

fn main() {
    let app = Application::new(
        Some("com.github.gtk-rs.examples.basic"),
        Default::default(),
    ).expect("Failed to initialize GTK");

    app.connect_activate(|app| {
        let window = ApplicationWindow::new(app);
        window.set_title("テストGUI");
        window.set_default_size(400,300);

        let scroll_win = ScrolledWindow::new(gtk::NONE_ADJUSTMENT, gtk::NONE_ADJUSTMENT);
        let text_view = TextView::new();
        text_view.set_editable(false);
        scroll_win.add(&text_view);
        window.add(&scroll_win);

        window.show_all();

        let (tx, rx) = glib::MainContext::channel::<&str>(glib::PRIORITY_DEFAULT);
        rx.attach(None, move |msg| {
            //println!("{}", msg);
            text_view.get_buffer().unwrap().insert_at_cursor(msg);

            glib::Continue(true)
        });

        thread::spawn(move || {
            loop {
                let s = "AAA\n";
                //println!("{}", s);
                tx.send(s).unwrap();
                thread::sleep(time::Duration::from_secs(1));
            };
        });
    });


    app.run(&env::args().collect::<Vec<_>>());
    
}
