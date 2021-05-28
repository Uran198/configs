# configs

* Run 'install-script.sh'.
* Setup ssh for Github, use ssh-agent to access keys with password. Keys
  should be passphrase protected.
* To open terminal maximized run `exo-preferred-applications` and change
  TerminalEmulator to `/usr/bin/xfce4-terminal --maximize`

To Make Touchpad toggle work
----------------------------
Add shortcut to the script `touchpad_toggle.sh`

Keyboard->Application Shortcuts

To install Skype
----------------
Download and install from [Skype.com](https://skype.com)

To install Dropbox
------------------
Download and install from [Dropbox.com](https://www.dropbox.com/install-linux)

Improvement ideas
-----------------
Create intent-based configuration. Configuration to include list of PPAs & applications (with versions maybe) to be installed. (Periodic) demon should run, and on each change to configuration apply intent. Software updates should be automatic with an option of simple rollback if new versions don't work properly (all versions should be named and dated). Ideally shouldn't lead to a possible sudo privilage escalation (is it possible to install things sudo-less?).
