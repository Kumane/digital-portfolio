# Digital Portfolio
This is my website that includes information about me.
Included is a script I wrote to automatically update changes to this repository.

## Portsync.sh
Portsync.sh is a file copying script written in bash that utilizes *rsync* to mirror a source folder to a destination. The destination folder is then uploaded to a GitHub repository. This effectively allows the creation of a local and a remote backup.

### Applications
When combined with *Cron Jobs*, PortSync.sh can schedule routine backups across drives. For example, syncing a local folder to a shared network drive.

### Instructions
Using a text editor of your choice, edit 