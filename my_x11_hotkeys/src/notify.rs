use std::process::Command;

pub fn notify(message: &str) {
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
