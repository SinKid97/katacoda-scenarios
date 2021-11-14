#Start set up attack prevention  
Finally, we are going to set up some plugins for attack prevention.
<br>
Now, the major authentication method is Password. But this is not save enough. Once the password is leaked, attacker can take the information of server easily. So, we need to set up the system be securer.

# Plugin: Wordpress 2-step verification
Go to Plugin and Add New to install the plugin.
![2-step](./assets/2-step.png)

After activating the plugin, go Users and 2-step Verification to set up.
Press GET STARTED to choose your verification method.
![2Setup](./assets/2Setup.png)

There are two ways to set up.
1. Email
![Email](./assets/Email.png)

2. Authenticator app
   ![App](./assets/App.png)
   You can choose Android or iPhone that you have.
   ![Scan](./assets/Scan.png)
   First, get the Authenticator App from the App Store.
   <br>
   Then, In the App select Set up account.
   <br>
   Third, Choose Scan a barcode. Scan the QR code using your phone.
   <br>
   You may see the verification code in the App.

   ![AppCode](./assets/AppCode1.png)

   After insert the code, you may see this message if it is worked. Press TURN ON to turn on the plugin.
   ![Worked](./assets/Worked.png)

   Then, you will see the status change from OFF to ON.
   ![Status](./assets/Status.png)

#Wordpress 2-step verification Setting
You can set up the Attempts Limit by filling in the number.
![Limit](./assets/Limit.png)

#Login with Wordpress 2-step verification
When you login again, you need to enter the 6-digit code to verify your identity.
![Login2](./assets/Login2.png)
   
