import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import base64

# Configuration
SMTP_SERVER = 'mail.epfl.ch'
PORT = 587
USERNAME = 'noreply-mastodon'
PASSWORD = 'A-very-sercure-password'
FROM = 'noreply-mastodon@epfl.ch'
TO = 'nicolas.borboen+pleasenospam@epfl.ch'
SUBJECT = 'Test Mail'
BODY = 'This is a test email sent via Python script.'

def send_email():
    try:
        # Create message container
        msg = MIMEMultipart()
        msg['From'] = FROM
        msg['To'] = TO
        msg['Subject'] = SUBJECT

        # Attach the body with the msg instance
        msg.attach(MIMEText(BODY, 'plain'))

        # Establish a secure session with the server
        with smtplib.SMTP(SMTP_SERVER, PORT) as server:
            server.starttls()  # Upgrade the connection to secure
            server.login(USERNAME, PASSWORD)  # Log in to the server
            server.send_message(msg)  # Send the email

        print('Email sent successfully.')

    except Exception as e:
        print(f'Failed to send email: {e}')

if __name__ == '__main__':
    send_email()
