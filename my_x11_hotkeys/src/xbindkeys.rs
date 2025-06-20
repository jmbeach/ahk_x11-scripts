use std::env;
use std::process::Command;
pub fn reload_xbindkeys() {
    Command::new("killall")
        .arg("xbindkeys")
        .output()
        .expect("Failed to execute killall command");
    let output = Command::new("xbindkeys")
        .output()
        .expect("Failed to execute xbindkeys command");
    if !output.status.success() {
        eprintln!(
            "Error reloading xbindkeys: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
    println!("xbindkeys reloaded successfully");
}
pub fn set_bindings_for_window(active_class: &str) {
    let home_dir = env::var("HOME").expect("HOME environment variable not set");
    let xbindkeysrc_path = format!("{}/.xbindkeysrc", home_dir);
    let file_content = std::fs::read_to_string(xbindkeysrc_path.clone())
        .expect("Failed to read .xbindkeysrc file");
    let mut new_content: Vec<String> = vec![];
    let mut commenting = 0;
    let mut uncommenting = 0;
    for line in file_content.lines() {
        if line.starts_with("# WINACTIVE") {
            // Preserve the directive line
            new_content.push(line.to_string());
            if uncommenting > 0 || commenting > 0 {
                // If we are already in a WINACTIVE section, we just skip this line
                panic!("Unexpected WINACTIVE line while already processing a WINACTIVE section");
            }
            let class_list = line
                .split(":")
                .last()
                .expect("Could not split the class list on colon");
            let mut all_negative = true;
            let mut any_match = false;
            for class_name in class_list.split(",") {
                let class_name = class_name.trim();
                if !class_name.starts_with("!") {
                    all_negative = false;
                }
                if class_name == active_class {
                    println!("Active class matches: {}", class_name);
                    uncommenting = 2;
                    any_match = true;
                } else if class_name == format!("!{}", active_class) {
                    println!("Negative active class matches: {}", class_name);
                    any_match = true;
                    commenting = 2;
                }
            }
            // If the only things specified are exclusions, then we want to uncomment when
            // the active class is not in the list
            if !any_match && all_negative {
                println!("All classes are negative, uncommenting for non-matching active class");
                uncommenting = 2;
            } else if !any_match {
                println!("No matches found, commenting out the section");
                commenting = 2;
            }
        } else if uncommenting > 0 {
            println!("Uncommenting line: {}", line);
            if line.starts_with("#") {
                new_content.push(line.trim_start_matches('#').to_string());
            } else {
                new_content.push(line.to_string());
            }
            uncommenting -= 1;
        } else if commenting > 0 {
            println!("Commenting line: {}", line);
            commenting -= 1;
            if !line.starts_with("#") {
                new_content.push(format!("#{}", line));
            } else {
                new_content.push(line.to_string());
            }
        } else {
            new_content.push(line.to_string());
        }
    }

    std::fs::write(xbindkeysrc_path, new_content.join("\n"))
        .expect("Unable to write to xbindkeysrc");
}
