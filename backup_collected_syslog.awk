#!/usr/bin/awk -f

BEGIN {
    # Define the source and destination directories
    dirA = "/var/log/collected_syslog"  #SOURCE DIRECTORY
    dirB = "/var/log/backup_collected_syslog" #DESTINATION DIRECTORY
    current_datetime = strftime("%d-%m-%Y_%H-%M-%S")
    fileToMove = "test.log" # will be replaced by the actual file names
    newFileName = fileToMove"_"current_datetime    # format for the new file name

    # Construct the move command and execute it
    moveCommand = "mv " dirA "/" fileToMove " " dirB "/" newFileName
    command = "ls " dirA  # untuk ngelist semua file dan folder

    while ((command | getline file) > 0 ) {
	    fileToMove = file
	    newFileName = fileToMove"_"current_datetime
	    current_datetime = strftime("%d-%m-%Y_%H-%M-%S")
	    moveCommand = "mv " dirA "/" fileToMove " " dirB "/" newFileName
    
	    if (system(moveCommand) == 0) {
        	print "File moved successfully."

        	# Construct the touch command to create a new file and execute it
        	touchCommand = "touch " dirA "/" fileToMove
		print "Tanggal:  " current_datetime
        	if (system(touchCommand) == 0) {
            	print "New file created in " dirA "."
        		} else {
            			print "Error creating new file."
        			}
    	   	} else {
        		print "Error moving file."
    			}
	}
	
	#close(command)
}
