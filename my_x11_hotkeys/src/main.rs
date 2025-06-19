use clap::Parser;
use enigo::{Direction, Enigo, Key, Keyboard, Settings};
use std::process::Command;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    // Key binding that will be used to trigger the action
    #[arg(short, long)]
    binding: Option<String>,
    // The daemon modifies the .xbindkeysrc file based on the active program
    #[arg(short, long)]
    daemon: bool,
}

fn main() {
    let args = Args::parse();
    let mut enigo = Enigo::new(&Settings::default()).unwrap();
    if args.daemon {
        run_daemon();
        return;
    }
    if args.binding.is_none() {
        eprintln!("No binding provided. Use --binding to specify a key binding.");
        return;
    }
    let binding = args.binding.unwrap();
    match binding.as_str() {
        "alt+down" => handle_alt_down(&mut enigo),
        "enter" => handle_enter(&mut enigo),
        _ => panic!("Unknown binding: {}", binding),
    }
}

fn run_daemon() {
    let mut state;
    let mut last_state = String::from("None");
    loop {
        let active_window_class = get_active_window_class(None).to_lowercase();
        if active_window_class.contains("nautilus") {
            state = String::from("Nautilus");
            // Here you can add more actions or checks as needed
        } else {
            state = active_window_class;
        }

        if state != last_state {
            println!("Active window class changed: {}", state);
        }

        last_state = state;
        // Check 4 times per second
        std::thread::sleep(std::time::Duration::from_millis(250));
    }
}

fn handle_alt_down(enigo: &mut Enigo) {
    let active_window_class = get_active_window_class(None).to_lowercase();
    if active_window_class.contains("nautilus") {
        enigo.key(Key::Alt, Direction::Release).unwrap();
        enigo.key(Key::DownArrow, Direction::Release).unwrap();
        enigo.key(Key::Return, Direction::Click).unwrap();
    }
}

fn handle_enter(enigo: &mut Enigo) {
    let active_window_class = get_active_window_class(None).to_lowercase();
    if active_window_class.contains("nautilus") {
        enigo.key(Key::F2, Direction::Click).unwrap();
    }
}

fn get_active_window() -> String {
    let output = Command::new("xdotool")
        .arg("getactivewindow")
        .output()
        .expect("Failed to execute xdotool command");
    String::from_utf8(output.stdout).expect("Invalid UTF-8 output")
}

fn get_active_window_class(window_id: Option<String>) -> String {
    let window_id = window_id.unwrap_or_else(get_active_window);
    let output = Command::new("xprop")
        .arg("-id")
        .arg(window_id)
        .arg("WM_CLASS")
        .output()
        .expect("Failed to execute xprop command");
    let output_str = String::from_utf8(output.stdout).expect("Invalid UTF-8 output");
    // Extract the class name from the output
    let window_id = output_str.split('\"').nth(1).unwrap_or("").to_string();
    window_id
}

fn notify(message: &str) {
    let output = Command::new("notify-send")
        .arg(message)
        .output()
        .expect("Failed to execute notify-send command");
    if !output.status.success() {
        eprintln!(
            "Error sending notification: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
}

fn reload_xbindkeys() {
    let output = Command::new("killall")
        .arg("xbindkeys")
        .output()
        .expect("Failed to execute killall command");
    if !output.status.success() {
        eprintln!(
            "Error killing xbindkeys: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
    let output = Command::new("xbindkeys")
        .arg("-n")
        .output()
        .expect("Failed to execute xbindkeys command");
    if !output.status.success() {
        eprintln!(
            "Error reloading xbindkeys: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
}
