# Make the script executable
chmod +x monitor_script.sh

# Create the cronjob to run the script at 6 PM every day
(crontab -l 2>/dev/null; echo "0 18 * * * $(pwd)/monitor_script.sh") | crontab -

echo "Cronjob has been set up successfully."