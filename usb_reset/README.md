Compile the program:

$ cc usbreset.c -o usbreset
Get the Bus and Device ID of the USB device you want to reset:

$ lsusb  
Bus 002 Device 003: ID 0fe9:9010 DVICO  
Make our compiled program executable:

$ chmod +x usbreset
Execute the program with sudo privilege; make necessary substitution for <Bus> and <Device> ids as found by running the lsusb command:

$ sudo ./usbreset /dev/bus/usb/002/003  


Program by Alan Stern (https://marc.info/?l=linux-usb&m=121459435621262&w=2)
© 2018 GitHub, Inc.
