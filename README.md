pimail
======

  a ruby script to send an email when your pi boots up.


instructions
------------
  1. > cp .env.sample .env
  2. > nano .env  # and input your information
  3. > source .env
  4. > chmod +x pimail.rb
  6. > nano /etc/rc.local  # and call pimail.rb

note: some commands may require sudo.


todo
----
  * load .env info automatically each time pimail.rb is run
  * handle delivery errors


or, the unix way...
-------------------
```
sudo apt-get install sendemail libnet-ssleay-perl libio-socket-ssl-perl
sudo nano /usr/bin/sendemail  # delete ' TLSv1' from line 1907
```

then, call sendemail from /etc/rc.local

