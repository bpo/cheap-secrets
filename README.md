# cheap-secrets #

Store your passwords in Git.

There's nothing novel or exciting here, it's just a technique and some quick
instructions: that's the main feature. The scripts included are in bash, but
trivial enough to reimplement in a minute or two.

A technique like this was used at an old employer of mine years ago. It's an
easy way to securely share secrets amongst a team that groks version control but
would prefer to follow explicit instructions when it comes to security.

Stovepipe Studios is moving away from this method, but it's still dead simple,
dirt cheap, and far more secure than what seems to be normal for a lot of groups 
(i.e. passwords shared by memorization / email).


## Prep ##

You'll need your own GPG keypair and the public keys of anyone you're working
with.

If you don't have a GPG keypair yet, you can generate one using:

    gpg --gen-key

Just follow the menu items. Choose the defaults unless you know what you're
doing.

Have anyone you want to share secrets with generate their own key on their
own machine. We're assuming they're technical enough to run `gpg` on their own
with instructions. If not you might need to find new software and/or coworkers.


## Setup ##

1. Add `decrypt.sh` and `encrypt.sh` to a Git repository you control.
2. Ensure that 'passwords' is ignored (add to .gitignore).
3. Write `passwords`, a plaintext file containing secrets.


## Usage

To add a new user, add the file this creates to version control:

    gpg --export -a bpo@stovepipestudios.com > keys/bpo@stovepipestudios.com

Modify `passwords` to your heart's content, including all of your most dangerous
secrets. When you're ready to share:

    ./encrypt.sh passwords
    git add passwords.asc
    git commit
    rm passwords

Decrypt the passwords to the screen:

    ./decrypt.sh passwords.asc

Decrypt to a file for editing:

    ./decrypt.sh passwords.asc > passwords

To add everyone's keys to your keyring (this is required if you want to make
changes):

    gpg --import keys/*


## Important Security Notes

There are two kinds of cryptography in this world: cryptography that will stop
your kid sister from reading your files, and cryptography that will stop major
governments from reading your files. These scripts are about the former,
assuming you follow instructions well and your kid sister doesn't have root
access to your machine or much of an imagination for social engineering.

That said, this is far superior to its most common alternative, which is
memorized passwords shared via email.
