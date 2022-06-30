#!/bin/bash
echo <<EOF
**********************************************
Author:Sadrul
Linkin Profile:https://www.linkedin.com/in/sadrulalom/

**********************************************
EOF
# Database name
db_name=dvdrental

# db user
usr_name=opu

# db user pwd
PGPASSWORD=123

# Backup storage directory 
backup_dir=/var/postgres_db_backup

# Notification email address 
recipient_email=salom@relisource.com

# Number of days to store the backup 
keep_days=30

#sqlfile=$backup_dir/$db_name-$(date +%d-%m-%Y_%H-%M-%S).sql
#zipfile=$backup_dir/$db_name-$(date +%d-%m-%Y_%H-%M-%S).zip

#normal sql file format
#sqlfile=$backup_dir/$db_name-$(date +%Y%m%d_%H%M%S).sql
#zipfile=$backup_dir/$db_name-$(date +%Y%m%d_%H%M%S).zip

#tar file format
sqlfile=$backup_dir/$db_name-$(date +%Y%m%d_%H%M%S).tar
zipfile=$backup_dir/$db_name-$(date +%Y%m%d_%H%M%S).tar.zip


# Create a backup

#if pg_dump $db_name > $sqlfile ; then
# if pg_dump -d $db_name -F t | gzip >$zipfile ; then

#if pg_dump -d $db_name -F t > $sqlfile ; then
if pg_dump -d $db_name -F t -U $usr_name | gzip >$zipfile ; then
   echo 'backup dump created'
else
   echo 'pg_dump return non-zero code' | mailx -s 'No backup was created!' $recipient_email
   exit
fi


#rm $sqlfile 
#echo $zipfile | mailx -s 'Backup Done successfully' $recipient_email

# Delete old backups 
find $backup_dir -mtime +$keep_days -delete