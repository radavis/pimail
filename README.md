pimail
======

  a ruby script to send an email when your pi boots up.


instructions
------------
  1. > cp .env.sample .env
  2. > nano .env  # and input your information
  3. > source .env
  4. > chmod +x pimail.rb
  5. > update-rc.d pimail.rb defaults 100
