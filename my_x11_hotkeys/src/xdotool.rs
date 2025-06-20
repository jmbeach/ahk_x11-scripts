use crate::notify::notify;
use crate::window::get_active_window;
use std::process::Command;

pub fn send_key(key: &str) {
    let active_window = get_active_window();
    let output = Command::new("xdotool")
        .arg("key")
        .arg("--window")
        .arg(active_window)
        .arg(key)
        .output();
    if output.is_err() {
        notify(&format!(
            "Failed to execute xdotool command: {}",
            output.unwrap_err()
        ));
    }
}
