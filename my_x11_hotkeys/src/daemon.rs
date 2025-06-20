use crate::{
    window::get_active_window_class,
    xbindkeys::{reload_xbindkeys, set_bindings_for_window},
};

/*Monitors the active window and triggers an event when the active window changes.
* When the active window changes, the daemon processes the ~/.xbindkeysrc file and looks
* for lines starting with the comment "# WINACTIVE:...". If it finds those lines, it treats
* everything after the colon as a comma separated list of window class names to include or exclude.
* Ex:
*
* ```
* # WINACTIVE: org.gnome.Nautilus
* "my_x11_hotkeys --binding 'Alt + Down'"
*   Alt + Down
* ```
*
* This means to only apply the binding to nautilus.
*
* You can also do negative matches. Example:
*
* ```
* # WINACTIVE: !brave-browser
* ```
*
* This means only when Brave is not the active application
*/
pub fn run_daemon() {
    let mut previous_class = String::from("None");
    /* Configuration so that this program handles specific bindings
     * only when specific applications are active */
    loop {
        let active_class = get_active_window_class(None).to_lowercase();

        if active_class != previous_class {
            println!("Active window class changed: [{}]", active_class);
            active_window_changed(&active_class);
        }

        previous_class = active_class;
        // Check 4 times per second
        std::thread::sleep(std::time::Duration::from_millis(250));
    }
}

fn active_window_changed(active_window_class: &str) {
    set_bindings_for_window(active_window_class);
    // TODO: I could make this more intelligent based on if the file changed
    // TODO: I could also just read the file once and pass the results along to each modifier
    reload_xbindkeys()
}
