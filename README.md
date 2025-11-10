# **The "I Don't Trust Myself" Site Blocker**

A productivity tool by [Patrick Coombe](https://patrickcoombe.com/about-patrick/)

This is a simple set of scripts for when you *know* you need to get work done, but you also *know* that "future you" has zero self-control and will just go edit /etc/hosts to get back on Reddit.

This system is just a "speed bump." It doesn't *really* stop you, but it makes it *just* annoying enough to undo that your impulsive brain might give up and go back to work.

Also note some sites are weird and will use www and non www as well as many different domains, cdns, etc.

VPNs can def effect this.

Don't spend your time hacking this the point is to block yourself! 

## **How It Works**

1. **block\_sites.sh**: This script just adds domains to your /etc/hosts file and points them at 127.0.0.1 (aka, nowhere / localhost). Most ppl can just add sites to their /etc/hosts file but I made this just for fun.
2. **lock\_hosts.sh**: This is the magic "speed bump." It uses chattr \+i to set the "immutable" flag on your /etc/hosts file. When this is set, *not even root can edit or delete the file*.  
3. **unlock\_hosts.sh**: This just removes the immutable flag (chattr \-i) so you can make changes again.

## **Requirements**

* **A linux system, tested on pop os
* I dont think this will work on mac, obv not windows etc 
* You need sudo access.

## **How to Use**

### **First-Time Setup**

1. Put all three scripts into a new folder in your home dir or somewhere 
2. Make them executable:  
   chmod +x all the .sh files

### **Step 1: Block Your Distractions**

Run the block\_sites.sh script with all the domains you want to block. You *must* use sudo. Make sure to include the www. versions, too.

sudo ./block\_sites.sh reddit.com twitter.com youtube.com

### **Step 2: Engage the Lock**

Now, run the lock script. This is the part that stops you from easily undoing Step 1\.

sudo ./lock\_hosts.sh

**That's it\!** Try to edit the file now: sudo nano /etc/hosts. You'll get an "File is unwritable" error. Ha\! Take that, future self.

### **How to Unblock Sites (or Add More)**

Okay, so you *really* need to make a change. You can't just edit the file. You have to follow the procedure.

1. **Unlock the file first:**  
   sudo ./unlock\_hosts.sh

2. **Make your changes:**  
   * You can now run sudo ./block\_sites.sh again to add more sites.  
   * Or, you can manually edit the file with sudo nano /etc/hosts to remove sites.  
3. \!\! IMPORTANT: RE-LOCK THE FILE \!\!  
   Don't forget this, or the whole system is pointless.  
   sudo ./lock\_hosts.sh

### **Disclaimer**

**This is just for fun. You're running scripts with sudo, which is always serious business. Read the scripts so you know what they do. I'm not responsible if you lock yourself out of something you actually needed.**


![image](https://i.imgur.com/DfVzFbQ.png)

