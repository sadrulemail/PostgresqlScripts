#!/bin/bash
echo <<EOF
**********************************************
Author:Sadrul
Linkin Profile:https://www.linkedin.com/in/sadrulalom/

**********************************************
EOF

# Location to place backups.
backup_dir="/var/postgres_db_backup"

#String to append to the name of the backup files
backup_date=`date +%Y%m%d_%H%M%S`

# db user
usr_name=opu

# db user pwd
PGPASSWORD=123

# Notification email address 
recipient_email=salom@relisource.com

# Number of days to store the backup 
keep_days=10

#dump all user accounts and roles
pg_dumpall --globals-only --file=$backup_dir/all_roles_users-$backup_date.sql

databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do  if [ "$i" != "postgres" ] && [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "template_postgis" ]; then    
    echo Dumping start for DB: $i  
    pg_dump $i -U $usr_name -F t | gzip> $backup_dir/$i-$backup_date.tar.zip    
  fi
done

echo $backup_dir | mailx -s 'Backup Done successfully' $recipient_email

# Delete old backups 
find $backup_dir -mtime +$keep_days -delete