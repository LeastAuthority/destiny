# FAQ

##  **General:**

**What is Destiny?**
Destiny is a secure file transfer application that allows people to transfer files without needing to reveal their identity to each other or the service provider. All files are end-to-end encrypted, meaning we cannot see their contents. Users can select a file on their device, and share the generated code with the intended recipient for safe delivery. No sign-up needed.  

Destiny is available on Android, Mac, Windows, and Linux. 

**What does Destiny cost?**

You can download and use Destiny for free.

**How does Destiny work?** 

Destiny uses the ["Magic Wormhole"](https://github.com/magic-wormhole/magic-wormhole) protocol. Magic Wormhole is designed to be the easiest possible way to get a file or directory safely from one device to another.  

Destiny generates a short "invitation code", consisting of a few simple words. The sender sends this single-use code to the recipient, for example verbally or by using a secure channel (e.g. Signal), who enters it into their own device. This gives the two devices enough information to connect with each other. 

Destiny attempts to send the encrypted file through a direct connection between the two devices. But this is not always possible, for example when a device is behind a firewall. In that case, the file is streamed through our servers to the recipient instead. To be clear, the file is encrypted and we cannot view or modify it.

**Where can I learn more about Magic Wormhole?**  

You can learn more about it here: 
https://github.com/magic-wormhole/magic-wormhole and https://magic-wormhole.readthedocs.io/

**Is Destiny open source?**

Yes. The code used for Destiny is available in the following repositories:

- Flutter app/front-end: https://github.com/LeastAuthority/destiny 
- Client Library: https://github.com/LeastAuthority/wormhole-william
- Native extension library: https://github.com/LeastAuthority/dart_wormhole_william
- Mailbox (rendezvous) server: https://github.com/magic-wormhole/magic-wormhole-mailbox-server
- Transit relay: https://github.com/magic-wormhole/magic-wormhole-transit-relay


**Who is Least Authority?**

Least Authority is a technology company supporting people’s right to privacy through security consulting and building secure solutions. Least Authority developed Destiny with the goal of developing user-friendly applications of Magic Wormhole that would be suitable for human rights defenders and other vulnerable communities. 

## **Getting Started:**

**Can you walk me through the process from beginning to end?**

Download the application via Github for [Android](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_android.apk), [Linux](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_linux_amd64.AppImage), [Windows](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_windows.msix), or [Mac](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_macos.dmg), or [Google Play Store](https://play.google.com/store/apps/details?id=com.leastauthority.destiny) and [F-Droid](https://f-droid.org/en/packages/com.leastauthority.destiny/). Both the sender and the receiver must have the application downloaded. 

Quick onboarding: Walk through the onboarding process (this will only appear once, when you first download the application).

Send a file: Click on the + sign or drag and drop a file into the dotted zone to select a file to send. 

Pass on the code: The application will automatically generate a one-time code. Pass on the code to the intended recipient verbally, digitally, or by any other means that you deem safe. For ease of use you can copy the code using the Copy button. Note that anyone with access to the code can receive your file.

Receive: the recipient can navigate to the Receive tab and enter the code in the “Enter Code Here” field and click the Next button. 

Download the file: Press Download to begin downloading the file to your device. If there are no interruptions or cancellations the file will be delivered successfully and you will see a screen that says “File download successful”. The page will also include information about where your file has been downloaded to.  

Done: the code is now no longer usable. No one else can receive the file with this code.

**How can I securely share the code with someone?** 
We advise you to speak or use secure communication tools such as Signal for sharing the code. 

**How do I receive a file?** 
See step 5 and 6 above. 

**Where are the files I received being saved?** 
The files are by default downloaded to the Download folder of your operating system. However, in the Desktop application you can change the download location by navigating to the Settings tab, and choosing the Select Folder button to choose a new destination for your files. 

## **Privacy/Security:** 

**What makes Destiny secure?** 
Identity-less: no need to disclose identity information (such as name, email address or phone number) to be able to transfer files.

End-to-end encryption: files are end-to-end encrypted and only the sender and recipient can read them.

Peer-to-peer file sharing: Destiny attempts to make a direct network connection to the other party. If both parties are on the same local network they should connect without any traffic leaving that network, for example. When this isn’t possible (e.g. if neither party has a public IP address) then our relay server is used (however, that server sees only encrypted packets).

Full-strength keys: although our codes are short and human-memorable, they are part of an online “Password Authenticated Key Exchange” (PAKE) which only allows a single guess – and yields a 256-bit full-strength symmetric key.

In more technical detail:

Password authenticated key exchange: A strong encryption key is derived from a short human pronounceable password using Diffie–Hellman key exchange algorithm to establish a shared "mailbox" between two parties. 
 
Encryption via relay servers use Salsa20 stream cipher and Poly1305 MAC algorithm via the NaCl Secretbox abstraction.

**Are my files being stored somewhere?**  
No, your files are not being stored anywhere. Files are either transferred directly or sent via a relay in real-time, which is why the two devices who wish to transfer files need to be online at the same time. The relay does not store the file, it only passes encrypted chunks of the file from one side to the other.

**What data do you collect?**
Destiny is a security tool that is designed for privacy. As such, we are actively focused on minimizing personal data that we collect. Specifically, we are not asking for and therefore do not know contact information (name, email address, phone number) about people who send/receive files.We do not store and cannot open files that are sent using Destiny. 

Nevertheless, third parties such as Google Play app store and the OVHcloud hosting provider might collect some user access information like users’ IP address and user-agent. We have no control of that and seek no access to such information.

Also note that if a file is sent to another device directly, the two parties could learn each others’ IP address.

For more details, see our [privacy policy](https://github.com/LeastAuthority/destiny/blob/main/PRIVACY-POLICY.md). 

**Has Destiny undergone a security audit?**

Destiny has been audited by an independent security audit company, Radically Open Security. You can find their findings and our remediation [here]. 

## **More help:** 

**Why does the app need to stay open for both the sender and the receiver for the transfer to be completed?**
 
Destiny is meant for synchronous file transfers. Files are sent from a sender’s device to a recipient’s device. Unlike some other services, they are not uploaded to and stored on a central server. This means that if the sender is no longer connected, they can no longer offer the file for the receiver to get. 

**How can a simple code like 7-guitarist-revenge be secure? And why can a code only be used once?**
 
There are 65,536 different combinations of the current wordlist used by Destiny. Anyone who tries to guess the right word combination has a 1 in 65,536 chance to guess right, which is a very small chance. If they guess wrong, the transfer is invalidated. This is tough luck for the sender, but also a safety feature: It prevents people from being able to keep guessing until they hit the right word combination. 

This also explains why codes are single use. Once a code is used ‘successfully’ (sender and recipient connect) or ‘unsuccessfully’ (a wrong code combination is guessed), the code is cleared for new usage. If the code would stay ‘alive’ for other recipients, it would lose the security of being hard to guess.

**Can I send multiple files at the same time?**
  
If you would like to send multiple files at the same time, you can compress them, for example, as a single ZIP file. But you cannot upload an unzipped folder or select multiple files to upload at once. You will need to send them separately and provide the receiver with a new code each time. 


**At what point can I retract a file that I am sending?** 

As a sender you can first cancel a transfer before sharing the code by pressing the Cancel button. After sharing the code you can still press Cancel if the other party has not yet started downloading the file. If you press Cancel while the transfer is ongoing, it is possible for the receiver to already have a portion of the file.

**Can I use Destiny to send/receive files to/from other Magic Wormhole applications?**  

Yes. Make sure to configure the other Magic Wormhole application to use the same environment settings set in Destiny. These are currently:

- Mailbox URL: wss://mailbox.mw.leastauthority.com/v1
- Transit relay URL: tcp://relay.mw.leastauthority.com:4001
- AppID: lothar.com/wormhole/text-or-file-xfer

**What are the known issues or limitations of Destiny?** 

Error messages: we are not always able to determine the exact reason for an error occurring and therefore not able to provide the exact troubleshooting steps. For example, it is difficult to know whether an error occurred due to a network interruption or due to a cancellation.

Cancellation: Canceling a transfer may lead to the application getting stuck during the transfer. And as previously mentioned, if the sender presses Cancel while the transfer is ongoing, it is possible for the receiver to already have a portion of the file.

Inability to change wormhole settings: a user is not able to change certain wormhole-william settings such as the mailbox server, relay server, and/or the passphrase component length. 

No iOS support: we currently do not offer an iOS version of the application. 

Unable to set default file destination for Android: a user is not able to change the default directory in Android, so files are all automatically saved to the default Downloads folder. 

Interoperability challenges: While we are striving to ensure interoperability between Destiny and other applications using the Magic Wormhole protocol, this has not fully been tested. As such, we cannot at this stage guarantee full interoperability.  

We will work on addressing these issues in V2 of the application. We welcome external contributions to the code and improvements. In the meantime, please report any other bugs and suggestions to destiny@leastauthority.com. 


# CONTACT
I have another question
If your question is not answered here or in the public documentation about Magic Wormhole, feel free to reach out to us on destiny@leastauthority.com.

**I would like to give feedback**

We’d love to hear from you! Please send us a message at destiny@leastauthority.com. 

