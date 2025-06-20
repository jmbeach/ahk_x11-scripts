use std::process::Command;
pub fn get_active_window() -> String {
    let output = Command::new("xdotool")
        .arg("getactivewindow")
        .output()
        .expect("Failed to execute xdotool command");
    String::from_utf8(output.stdout).expect("Invalid UTF-8 output")
}

pub fn get_active_window_class(window_id: Option<String>) -> String {
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
