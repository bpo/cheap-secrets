# cheap-secrets #

Store your passwords in Git, encrypted with PGP.

Nothing novel or exciting here. It's just a method and instructions, the
triviality is the feature. The scripts included are in bash, but simple
enough to reimplement in a minute or two.

## Background ##

A technique like this was used at an employer of mine years ago.
I've implemented a version of it at every bootstrapped company I've worked with
since. It's an easy way to securely share secrets across a team that groks
version control but would prefer to follow explicit instructions when it comes
to security.

Stovepipe Studios is moving away from this method, but it remains dead simple,
dirt cheap, and far more secure than what seems to be normal for a lot of groups 


## Prep ##

You'll need your own GPG keypair and the public keys of anyone you're working
with. If you don't have `gpg` installed, consult your local search engine.

If you don't have a GPG keypair yet, you can generate one using:

    gpg --gen-key

Just follow the menu items. Choose the defaults unless you know what you're
doing.

Have anyone you want to share secrets with generate their own key on their
own machine. We're assuming they're technical enough to run `gpg` on their own
with instructions. If not you might need to find new software and/or coworkers.


## Setup ##

1. Add `decrypt.sh` and `encrypt.sh` to a Git repository you control.
2. Ensure that `passwords` is ignored (add to `.gitignore`).
3. Write `passwords`, a plaintext file containing secrets. Do not add it to
   version control, ever (this is why it was ignored in step 2).


## Usage ##

#### adding users ####

To add a new user, add the file this creates to version control:

    gpg --export -a bpo@stovepipestudios.com > keys/bpo@stovepipestudios.com

#### adding passwords ####

Modify `passwords` to your heart's content, including all of your most dangerous
secrets. When you're ready to share:

    ./encrypt.sh passwords

This will generate `passwords.asc`, an encrypted rendition of your file. You
can share this with your team as you would anything else, using git:

    git add passwords.asc
    git commit
    rm passwords

#### reading passwords ####

Decrypt the passwords to the screen:

    ./decrypt.sh passwords.asc

#### editing passwords ####

Decrypt to a file for editing:

    ./decrypt.sh passwords.asc > passwords

You'll need to remove `passwords` when you're through.

#### making friends ####

To add everyone's keys to your keyring:

    gpg --import keys/*

This is required if you want to share your changes with others. The keysigning
party is optional.


## Important Security Notes

> There are two kinds of cryptography in this world: cryptography that will stop
> your kid sister from reading your files, and cryptography that will stop major
> governments from reading your files. - Bruce Schneier

These scripts are about the former, assuming you follow instructions well and
your kid sister doesn't have root access to your machine or much of an
imagination for social engineering.

Still it remains far superior to its most common alternative, which is
memorized passwords shared via email.
