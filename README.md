# GIT-FAST-PROFILE-CONFIGURER

*Configure Username and Email Effortlessly for git repository*

![Last Commit](https://img.shields.io/github/last-commit/pingmyheart/Git-Fast-Profile-Configurer)
![Repo Size](https://img.shields.io/github/repo-size/pingmyheart/Git-Fast-Profile-Configurer)
![Issues](https://img.shields.io/github/issues/pingmyheart/Git-Fast-Profile-Configurer)
![Pull Requests](https://img.shields.io/github/issues-pr/pingmyheart/Git-Fast-Profile-Configurer)
![License](https://img.shields.io/github/license/pingmyheart/Git-Fast-Profile-Configurer)
![Top Language](https://img.shields.io/github/languages/top/pingmyheart/Git-Fast-Profile-Configurer)
![Language Count](https://img.shields.io/github/languages/count/pingmyheart/Git-Fast-Profile-Configurer)

## Why Git-Fast-Profile-Configurer?

Managing multiple Git identities can be cumbersome, especially when switching between personal, professional, or
collaborative projects. Manually updating `user.name` and `user.email` configurations increases the risk of committing
with incorrect credentials, leading to potential confusion and misattribution.

**Git-Fast-Profile-Configurer** offers a streamlined solution:

* 🚀 **Quick Profile Switching**: Easily toggle between different Git profiles without manual edits.
* 🧩 **User-Friendly Interface**: A straightforward bash script that simplifies the configuration process.
* ⏱️ **Enhanced Productivity**: Reduce context-switching overhead and maintain consistent commit histories across
  projects.

This tool is ideal for developers, freelancers, and anyone juggling multiple Git identities, ensuring that your commits
always reflect the correct profile.

# Getting started

## Installation

1. **Make required directories**:

```shell
mkdir -p ~/.programs ~/.git-configurer
```

2. **Clone the repository**:

```shell
cd ~/.programs
git clone https://github.com/pingmyheart/Git-Fast-Profile-Configurer.git
```

3. **Make the script accessible**:

```shell
sudo ln -s ~/programs/Git-Fast-Profile-Configurer/git-profile-configurer.bash /usr/local/bin/git-profile-configurer
```

## Usage

1. Create `config.yaml` file inside `~/.git-configurer` directory.
2. Add the following content to `config.yaml` file with your customizations:

```yaml
profiles:
  personal:
    username: "my-username"
    email: "my-email@email.it"
  work:
    username: "my-work-username"
    email: "my-work-email@email.it"
```

3. Run the command to list available profiles:

```shell
git-profile-configurer --list
```

4.
5. Run the command to configure a profile:

```shell
git-profile-configurer -p personal
```