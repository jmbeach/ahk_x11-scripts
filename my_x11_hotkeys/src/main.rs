use clap::Parser;
use enigo::{Direction, Enigo, Key, Keyboard, Settings};
mod daemon;
use daemon::run_daemon;
mod window;
mod xbindkeys;
use window::get_active_window_class;
mod notify;

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
        "Alt + Down" => handle_key_alt_down(&mut enigo),
        "Return" => handle_key_return(&mut enigo),
        _ => panic!("Unknown binding: {}", binding),
    }
}

fn handle_key_alt_down(enigo: &mut Enigo) {
    let active_window_class = get_active_window_class(None).to_lowercase();
    if active_window_class.contains("nautilus") {
        enigo.key(Key::Alt, Direction::Release).unwrap();
        enigo.key(Key::DownArrow, Direction::Release).unwrap();
        enigo.key(Key::Control, Direction::Press).unwrap();
        enigo.key(Key::Unicode('o'), Direction::Click).unwrap();
        enigo.key(Key::Control, Direction::Release).unwrap();
    }
}

fn handle_key_return(enigo: &mut Enigo) {
    let active_window_class = get_active_window_class(None).to_lowercase();
    if active_window_class.contains("nautilus") {
        enigo.key(Key::Return, Direction::Release).unwrap();
        enigo.key(Key::F2, Direction::Click).unwrap();
    }
}
