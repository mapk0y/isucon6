# isucon5 用の事前準備

[isucon6q メモ](https://gist.github.com/mapk0y/bced808fe8f8f729c7266a8af70d8399)


```shell-session
$ 事前に `.ssh/config` にログインできるように設定しておく
$ cd ansible
$ vi ansible/hosts
$ ansible-playbook -i ./hosts setup_packages.yml
$ ansible-playbook -i ./hosts setup_dotfiles.yml
```
