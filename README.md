# Hasura tracker

## Infomation

Will track changes of metadata and store it to local file. After metadata will be read, changes will be exported to local backup. After that process will be started over

#### Run app with cron

Set your own path of insalled hasura tracker

```
0 */2 * * * /home/deployer/apps/hasura-tracker/ruby_wrapper_sh >> /home/deployer/apps/hasura-tracker/log/tracker.log 2>&1
```

#### Structure

Files information for current app

- tracker.rb - main file to call command and store result to file hasura_chacnges.txt
- ruby_wrapper_sh - wrapper file for crontab to run ruby script
- hasura_changes.txt - will be generated automatically and store result from hasura metadata diff command
- log/tracker.log - will be generated automatically by crontab command and store output and errors to tracker.log file by running command above in section Run app with cron

#### Configuration

Make sure to udpate and set all file path in the file.
1. tracker.rb require to set filepath and name for storing all result from hasura command. Set variable name `file`, bydefault it set as /home/deployer/apps/hasura-tracker/hasura_changes.txt
2. tracker.rb require to set path of hasura folder. This folder will be available after running `hasura init`. Set variable `hasura_dir` for this, by default it is /home/deployer/apps/hasura
3. Make sure to set correct filepath to crontab, running `crontab -e`, IMPORTANT: point your cron path to ruby_wrapper_sh to run shell script which will run ruby script

#### Contribution

Planning to add sqllite3 to store data, and read with other apps, such as telegram bot to return changes to telegram user

#### Credits

https://github.com/frizbee
https://gitlab.com/frizbee
