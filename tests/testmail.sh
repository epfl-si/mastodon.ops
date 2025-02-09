#!/bin/bash

# Configuration
SMTP_SERVER=$SMTP_SERVER
PORT=$SMTP_PORT
USERNAME=$SMTP_LOGIN
PASSWORD=$SMTP_PASSWORD
FROM=$SMTP_FROM_ADDRESS
TO="nicolas.borboen+pleasenospam@epfl.ch"
SUBJECT="Test Mail ${date}"
BODY="This is a test email sent via script."

# Encode username and password in base64
BASE64_USER=$(echo -n "$USERNAME" | base64)
BASE64_PASS=$(echo -n "$PASSWORD" | base64)

# Start the session with openssl
{
  echo "EHLO epfl.ch"
  echo "STARTTLS"
  echo "EHLO epfl.ch"
  echo "AUTH LOGIN"
  echo "$BASE64_USER"
  echo "$BASE64_PASS"
  echo "MAIL FROM:<$FROM>"
  echo "RCPT TO:<$TO>"
  echo "DATA"
  echo "Subject: $SUBJECT"
  echo "$BODY"
  echo "."
  echo "QUIT"
} | openssl s_client -starttls smtp -connect $SMTP_SERVER:$PORT 2>&1
