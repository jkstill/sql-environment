#!/bin/bash


homeDir='/home/jkstill/oracle/sql-environment'

logFile=still-env-create-zips.log

# always wanted to do it this way - found it on stackoverflow
# https://stackoverflow.com/questions/3173131/redirect-copy-of-stdout-to-log-file-from-within-bash-script-itself
exec >  >(tee -ia $logFile)
exec 2> >(tee -ia $logFile >&2)

function my_cd  {
	typeset newDir=$1

	#echo "newDir before: $newDir"
	
	# if '/' at end of dirname
	if [[ ${newDir: -1 :1} == '/' ]]; then
		#echo "Removing slash"
		length=${#newDir};
		#echo "length: $length"
		(( length = length - 1 ))
		#echo "length: $length"
		newDir=${newDir:0:$length}
	fi

	# only single /
	newDir=$(echo $newDir | sed -re 's#/+#/#g')

	#echo "newDir after: $newDir"

	cd $newDir
	pwd
	if [[ $PWD != $newDir ]]; then
		echo 
		echo Something broken in my_cd\(\)
		echo "                     Tried to cd $newDir"
		echo "However the current directory is $PWD"
		echo
		exit 1
	fi
}

echo homeDir: $homeDir
my_cd  $homeDir

mkdir -p $homeDir/zips
my_cd $homeDir/zips


# get current CPU AAS
wget --header='Host: codeload.github.com' --header='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0.1 Waterfox/46.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-US,en;q=0.5' --header='DNT: 1' --header='Referer: https://github.com/jkstill/cpu-aas' --header='Cookie: logged_in=yes; _ga=GA1.2.1161150083.1380903764; _octo=GH1.1.372413731.1476194421; dotcom_user=jkstill; _gat=1' --header='Connection: keep-alive' 'https://codeload.github.com/jkstill/cpu-aas/zip/master' -O 'cpu-aas-master.zip' -c

# get current ASM Metrics
wget --header='Host: codeload.github.com' --header='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0.1 Waterfox/46.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-US,en;q=0.5' --header='DNT: 1' --header='Referer: https://github.com/jkstill/asm-metrics' --header='Cookie: logged_in=yes; _ga=GA1.2.1161150083.1380903764; _octo=GH1.1.372413731.1476194421; dotcom_user=jkstill; _gat=1' --header='Connection: keep-alive' 'https://codeload.github.com/jkstill/asm-metrics/zip/master' -O 'asm-metrics-master.zip' -c

# get current ASM Space
wget --header='Host: codeload.github.com' --header='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0.1 Waterfox/46.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-US,en;q=0.5' --header='DNT: 1' --header='Referer: https://github.com/jkstill/asm-space' --header='Cookie: logged_in=yes; _ga=GA1.2.1161150083.1380903764; _octo=GH1.1.372413731.1476194421; dotcom_user=jkstill; _gat=1' --header='Connection: keep-alive' 'https://codeload.github.com/jkstill/asm-space/zip/master' -O 'asm-space-master.zip' -c

# get current SAR tools
wget --header='Host: codeload.github.com' --header='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0.1 Waterfox/46.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-US,en;q=0.5' --header='DNT: 1' --header='Referer: https://github.com/jkstill/asm-space' --header='Cookie: logged_in=yes; _ga=GA1.2.1161150083.1380903764; _octo=GH1.1.372413731.1476194421; dotcom_user=jkstill; _gat=1' --header='Connection: keep-alive' 'https://codeload.github.com/jkstill/sar-tools/zip/master' -O 'sar-tools-master.zip' -c

# get current CSV tools
wget --header='Host: codeload.github.com' --header='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0.1 Waterfox/46.0.1' --header='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header='Accept-Language: en-US,en;q=0.5' --header='DNT: 1' --header='Referer: https://github.com/jkstill/asm-space' --header='Cookie: logged_in=yes; _ga=GA1.2.1161150083.1380903764; _octo=GH1.1.372413731.1476194421; dotcom_user=jkstill; _gat=1' --header='Connection: keep-alive' 'https://codeload.github.com/jkstill/csv-tools/zip/master' -O 'csv-tools-master.zip' -c

my_cd  $homeDir

# create a copy of SQL scripts found in ~/oracle/oracle-script-lib/INDEX

indexFiles=~/oracle/oracle-script-lib/INDEX*

FILES=$(grep ^@ $indexFiles| cut -f2 -d@ | cut -f1 -d:)

my_cd ~/oracle/oracle-script-lib/sql

tar cf - $FILES | ( cd ~/oracle/sql-environment/working/still/sql ; tar xvf - )

for indexFile in $indexFiles
do
	cp -fp $indexFile $homeDir/working/still/sql
done

my_cd  $homeDir

# get some SQL Profilers and Strace Profilers

cp -fp $HOME/profilers/perltrace/perltrace.pl working/still/bin
cp -fp $HOME/presentations//free-oracle-performance-tools/10046/optimizing-oracle-performance/profiler-2.pl working/still/bin
cp -fp $HOME/presentations//free-oracle-performance-tools/10046/clive-bostock/10046_events.pl working/still/bin
cp -fp $HOME/profilers/strace/s*.pl working/still/bin


cat << EOF > working/still/sql/login.sql

set timing on time on
set sqlprompt "_USER'@'_CONNECT_IDENTIFIER _PRIVILEGE> "
set serveroutput off


define _editor='/usr/bin/vim -u /home/oracle/working/still/.vimrc'

EOF

rm -f still-env.tgz still-env.zip

tar cvfz still-env.tgz still.env working zips

zip --recurse-paths --symlinks still-env.zip still.env working zips


echo
echo "Tar File: still-env.tgz"
echo 
echo "Zip File: still-env.zip"
echo

cat <<-EOF

  now removing SQL scripts from working/still/sql if they contain DDL

EOF

find working -name \*.sql \
	| xargs grep -HiP "(?<!['\"\w])((insert|merge)\s+into|delete\s+from|(drop|create)\s+(table|index|sequence)|update\s+\w+)" \
	|  grep -viE -- '(--|#)\s*((insert|merge)\s+into|delete\s+from|(drop|create)\s+(table|index|sequence)|update\s+\w+)' \
	| grep -iP  "(?<!['\"\w])((insert|merge)\s+into|delete\s+from|(drop|create)\s+(table|index|sequence)|update\s+\w+)" \
	| cut -f1 -d: | sort -u \
	| xargs rm -f

cat <<-EOF

  adding back in scripts that were false positives
    ash_top_sql.sql
	 snapper.sql

EOF

my_cd $homeDir

for script in ash_top_sql.sql snapper.sql
do
		cp ~/oracle/oracle-script-lib/sql/$script working/still/sql
done

cat <<-EOF

  now creating still-env-no-ddl files

EOF

rm -f still-env-no-ddl.tgz still-env-no-ddl.zip

tar cvfz still-env-no-ddl.tgz still.env working zips

zip --recurse-paths --symlinks still-env-no-ddl.zip still.env working zips


echo
echo copying archives to /mnt/zips/tmp/still-env
echo

for zipFile in *.tgz *.zip
do
	echo "archive: $zipFile"
	cp -pf $zipFile /mnt/zips/tmp/still-env
done


echo
echo "Tar File: still-env-no-ddl.tgz"
echo 
echo "Zip File: still-env-no-ddl.zip"
echo


echo 
echo "Log file: $logFile"
echo 


