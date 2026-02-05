mkdir module1_assignment
cd module1_assignment
pwd
mkdir module1_assignment
mkdir module1_assignment_linux
cd module1_assignment_linux
mkdir q1
cd q1
touch exec_file.sh
chmod +x exec_file.sh
ls -l
cd ..
mkdir q2
cd q2
touch group_nowrite.txt
chmod g-w group_nowrite.txt
ls -l
cd ..
mkdir -p q3/dir1/dir2
touch q3/dir1/dir2/original_file.txt
ln -s dir2/original_file.txt q3/dir1/softlink_file.txt
ls -l q3/dir1
mkdir q4
cd q4
ps -ef
cd ..
mkdir q5
cd q5
touch file1.txt
sleep 1
mkdir Week1_Assignment
cd Week1_Assignment
mkdir Q1_executable_permission
cd Q1_executable_permission
touch file1
chmod a+x file1
ls -l file1
cd ..
mkdir Q2_remove_group_write
cd Q2_remove_group_write
touch file2
chmod g-w file2
ls -l file2
cd ..
mkdir -p Q3_softlink/dir1/dir2
cd Q3_softlink
touch dir1/dir2/file
ln -s dir1/dir2/file dir1/file_link
ls -l dir1
cd ..
mkdir Q4_ps_command
cd Q4_ps_command
ps -ef > all_processes.txt
cat all_processes.txt
cd ..
mkdir Q5_redirect_sorted_output
cd Q5_redirect_sorted_output
mkdir dir1
touch dir1/file1 dir1/file2 dir1/file3
ls -lt dir1 > sorted_output.txt
cat sorted_output.txt
touch dir1/file4
ls -lt dir1 > sorted_output.txt
cat sorted_output.txt
cd ..
mkdir Week2_Assignment
cd Week2_Assignment
mkdir Q1_large_files
cd Q1_large_files
touch small.txt
dd if=/dev/zero of=bigfile bs=1M count=2
find . -type f -size +1M > large_files.txt
cat large_files.txt
cd ..
mkdir Q2_replace_text
cd Q2_replace_text
cat <<EOF > config.txt
server=localhost
db_host=localhost
api_url=http://localhost:8080
EOF

sed 's/localhost/127.0.0.1/g' config.txt > updated_config.txt
cat updated_config.txt
cd ..
mkdir Q3_filter_logs
cd Q3_filter_logs
cat <<EOF > app.log
DEBUG: Starting the application initialization.
ERROR: Unable to connect to the database.
INFO: User 'admin' logged in successfully.
DEBUG: Fetching configuration settings from the server.
ERROR: DEBUG - Configuration settings could not be applied.
INFO: Scheduled job 'backup' completed successfully.
DEBUG: Connection to server timed out. Retrying...
ERROR: Failed to fetch data from API endpoint '/users'.
INFO: Maintenance mode activated.
ERROR: DEBUG - Query execution failed due to a syntax error.
DEBUG: Reloading application modules.
ERROR: Missing required parameter in the request.
INFO: Shutting down the system gracefully.
DEBUG: Closing unused network connections.
ERROR: DEBUG - Unexpected server response received.
EOF

grep "ERROR" app.log | grep -v "DEBUG" > filtered_log.txt
cat filtered_log.txt
cd ..
mkdir Q4_kill_highest_memory
cd Q4_kill_highest_memory
ps aux --sort=-%mem | head -n 2
cd ..
mkdir Q5_gateway_sorted
cd Q5_gateway_sorted
ip route | awk '/default/ {print $3}' | sort > gateways.txt
cat gateways.txt
cd ..
mkdir Week3_Assignment
cd Week3_Assignment
touch backup_manager.sh
chmod +x backup_manager.sh
nano backup_manager.sh
ls
mkdir source_dir backup_dir
echo "file1" > source_dir/a.txt
echo "file2" > source_dir/b.txt
echo "file3" > source_dir/c.log
./backup_manager.sh "source_dir" "backup_dir" ".txt"
cat backup_dir/backup_report.log
cd ..
mkdir Week3_Assignment
mkdir Week4_Assignment
cd Week4_Assignment
nano extract_params.sh
chmod +x extract_params.sh
ls
./extract_params.sh input.txt
cat output.txt
cd ..
mkdir Module5_Assignment
cd Module5_Assignment
nano file_analyzer.sh
chmod +x file_analyzer.sh
./file_analyzer.sh --help
./file_analyzer.sh -d logs -k error
./file_analyzer.sh -f script.sh -k TODO
cat errors.log
ls
