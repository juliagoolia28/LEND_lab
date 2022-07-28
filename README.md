# LEND_lab
This is the official repository of the LSU Language, Environment and NeuroDevelopment Lab directed by Dr. Julie M. Schneider (@juliagoolia28)

## Getting started with Git in Terminal
1. Install Homebrew ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```
2. Install git via brew ```brew install git```

## Forking and Cloning
1. Next you will need to Fork the current repo into your own repo
2. In your own forked version, set up your local clone in local terminal (you only need to do this once for the entire 'Lend_lab' repo)
- `cd` into your local directory where you would like to save the lab repo.
- Then type:
```
git clone https://github.com/yourname/LEND_lab.git
```
- Now you will have a local folder called LEND_lab on the computer.
- Then type:
```
cd ./LEND_lab
git remote add upstream https://github.com/juliagoolia28/LEND_lab.git
git remote set-url --push upstream Oops.no.push.to.upstream
git remote -v
```
In the output you will see:
```
origin https://github.com/yourname/LEND_lab.git (fetch)
origin https://github.com/yourname/LEND_lab.git (push)
upstream https://github.com/juliagoolia28/LEND_lab.git (fetch)
upstream	Oops.no.push.to.upstream (push)
```
## Setup Personal Access Token (PAT) to authenticate
To connect Git to Github you have to provide authentication. It will ask for a username and then password, but no longer accepts these credentials. To create a PAT follow these instructions: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

When logging in, enter your PAT link for the username and hit 'enter' for password.

## Before proceeding, remove .DS_Store files created by Macs
In your git folder type:
```
echo .DS_Store >> ~/.gitignore_global

git config --global core.excludesfile ~/.gitignore_global
```
## How to Add things to Github

## 
