# Bookmarks reminder
Small project designed to help me define organised structure of bookmarks that I collect in my day-to-day work and bring myself to read and understand them! 

The solution is simple: for given bookmarks file it samples 7 links (for every day in a week), save selected in order not to be sampled again and send mail with the list of them.

### Usage
To get it working you need to add json file with your mail password (gmail only available) and of course exported bookmarks files (in html format). I keep all files on Azure VM and using crontab get selected bookmarks every week. 

Some pictures of coneptual work are shown below.
