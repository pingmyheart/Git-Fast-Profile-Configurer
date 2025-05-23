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

# Getting started

## Installation

1. **Make required directories**:

```shell
mkdir -p ~/.kube ~/.git-configurer
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

3. Run the command:

```shell
git-profile-configurer -p personal
```