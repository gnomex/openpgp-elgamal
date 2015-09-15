# openpgp-elgamal
Academic stuff

```bash
gpg --gen-key
gpg (GnuPG) 1.4.18; Copyright (C) 2014 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 2
DSA keys may be between 1024 and 3072 bits long.
What keysize do you want? (2048)
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 7
Key expires at Ter 22 Set 2015 09:56:46 BRT
Is this correct? (y/N) y

You need a user ID to identify your key; the software constructs the user ID
from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

Real name: John D
Email address: john@doe.foo
Comment: Example Elgamal Key
You selected this USER-ID:
    "John D (Example Elgamal Key) <john@doe.foo>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: WARNING: some OpenPGP programs can't handle a DSA key with this digest size
.++++++++++++++++++++....+++++..++++++++++++++++++++....+++++...+++++..+++++++++++++++.++++++++++..+++++++++++++++.++++++++++.+++++.+++++.+++++++++++++++.......+++++>..+++++........>+++++.....................................................................................................................................<.+++++.........>+++++..............................................+++++

Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 204 more bytes)

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
+++++..++++++++++..+++++.+++++++++++++++++++++++++.+++++.+++++++++++++++.+++++++++++++++++++++++++++++++++++..+++++++++++++++++++++++++++++++++++.+++++.+++++>++++++++++....................+++++^^^
gpg: key 37CDBFAC marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2015-09-22
pub   2048D/37CDBFAC 2015-09-15 [expires: 2015-09-22]
      Key fingerprint = C631 7320 65A0 E033 DBB1  0A9B FB92 E802 37CD BFAC
uid                  John D (Example Elgamal Key) <john@doe.foo>
sub   2048g/769AD774 2015-09-15 [expires: 2015-09-22]
```

```bash
#Server
gpg --list-keys
pg --output johnd.37CDBFAC.asc --export -a 37CDBFAC

#Client
gpg --list-sigs
gpg --list-keys
gpg --import johnd.37CDBFAC.asc
gpg --sign-key 37CDBFAC
gpg --list-keys
gpg --list-sigs
```
