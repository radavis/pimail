#!/usr/bin/env ruby
require 'net/smtp'
require 'logger'
#require 'pry'
require 'dotenv'
Dotenv.load

@log = Logger.new(File.expand_path('../pi_mail.log', __FILE__))
@log.debug "pimail started"

def send_email(opts={})
  msg = <<END_OF_MESSAGE
From: #{opts[:from]}
To: #{opts[:to]}
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE
  begin
    email = Net::SMTP.new(opts[:server], opts[:port])
    email.enable_starttls
    email.start(opts[:from_domain], opts[:from], opts[:password], :login) do |smtp|
      smtp.send_message(msg, opts[:from], opts[:to])
    end
    @log.debug "email delivery to #{opts[:to].inspect}: successful"
  rescue => e
    @log.error "email delivery to #{opts[:to].inspect}: failed"
    @log.error "error: #{e}"
    #@log.debug "opts: #{opts}"
  end
end

if __FILE__ == $0
  ifconfig_output = `ifconfig`

  opts = {
    server: ENV['PIMAIL_SERVER'],
    port: ENV['PIMAIL_PORT'],
    to: ENV['PIMAIL_TO'],
    from: ENV['PIMAIL_FROM'],
    from_domain: ENV['PIMAIL_FROM_DOMAIN'],
    from_alias: ENV['PIMAIL_FROM_ALIAS'],
    subject: ENV['PIMAIL_SUBJECT'],
    password: ENV['PIMAIL_PASSWORD'],
    body: ifconfig_output
  }

  send_email(opts)
end

@log.debug "pimail exiting"
