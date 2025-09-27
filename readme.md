# Digital Portfolio
This is my website that includes information about me.
Included is a script I wrote to automatically update changes to this repository.

## Portsync.sh
Portsync.sh is a file copying script written in bash that utilizes *rsync* to mirror a source folder to a destination. The destination folder is then uploaded to a GitHub repository. This effectively allows the creation of a local and a remote backup.

### Applications
When combined with *Cron Jobs*, PortSync.sh can schedule routine backups across drives. For example, syncing a local folder to a shared network drive.

### Prerequisites 
- Linux Operating System
- Read/Write Permissions of desired folders
#### Optional
- Git installed
### Instructions
Using a text editor of your choice, edit the SOURCE and DEST variables with your desired paths. Be sure to use the *full* files paths or the script will fail.

Verify that the destination folder is integrated with Git if using the GitHub automatic backup feature. Otherwise, comment out the GitHub integration.

To routinely schedule backups, run *crontab -e* to edit the Cron Jobs file. Then, add to the bottom of the file:
    * * * * * */full/path/to/sync_script.sh

(The asterisks will be the time to routinely run the script. Research *Cron Jobs* for more information )