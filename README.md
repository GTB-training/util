# GTB Utilities

该 repo 内含有 GTB 用到的各种公共工具，比如用来批量下载学员 homework repositories 的工具等。

## Install

```shell
brew install GTB-training/gtb/util
```

目前包含如下命令：

1.gtb

参考资料：

[How to Create and Maintain a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)

[Creating Personal Homebrew Tap/Formula (OSX)](https://www.youtube.com/watch?v=fbyrLo6yx8M)

## Set Up

### GITHUB_USERNAME

GitHub 的 username，调用 GitHub API 时用于认证。

### GITHUB_TOKEN

GitHub 的 token，调用 GitHub API 时用于认证。请确保该 token 具备足够的权限。去[生成!](https://github.com/settings/tokens) token。

### GTB_ROOT

所有需要的初始设置和使用中产生的数据都会放到`GTB_ROOT`目录中，默认位置是`$HOME/code/gtb`，如需指定其它位置，请自行设置环境变量`GTB_ROOT`的值即可。

### GTB_TERM

当前默认的学期。此变量无默认值，如未设置，命令将无法正常运行。请在您的 SHELL 初始化文件中加以设置。

### GTB_STUDENTS_FILE

学员的信息通过`students.txt`文件提供，默认位置为`$GTB_ROOT/students.txt`，如需自定义位置，请设置环境变量`GTB_STUDENTS_FILE`的值。

`students.txt`内容示例：

```shell
$ cat students.txt
yuqi.wang Uncontrollablly term01 group1 team1
peng.tian ifeelcold1824 term01 group2 team1
```

每行表示一个学员，有 3+ 列，列之间由空格分隔：

1. 第一列是学员名字的拼音全拼；
1. 第二列是学员 Github username；
1. 第三列是学员所在学期，如：term01、term02 等；
1. 后续列为自定义的 tags，每个 tag 一列，每行的 tags 根据需要设置，数量不必一致；

**名字拼音请勿包含空格！**

## 更多帮助文档

[点这里](https://share.mubu.com/doc/7Apo77luiZP)

## TODO

* 可以在任何位置指定选项，而不用限制于特定位置，比如 gtb stduent --role org check wang.wu
* 增加 repo remote add teacher/student
* 增加 team list 命令；
* 批量创建 comments 分支；
* 集成 gtb_extend 脚本；
* 支持 links 功能；
* ~~支持指定 `--terms`，值为逗号分隔，这样可以把往届的学员都写到一个 students 文件中；~~
* 目前 build project 时前端支持的是 yarn，考虑未来增加更多支持；
* 兼容性问题暂未考虑，使用中遇到时再改；
* 更新 repo 时，如果 repo 有本地修改的话更新会失败。需要商量一个处理方式，并实施；
* 处理错误场景：repo 不存在的情况；
* ~~支持显示 usage；~~
* 下载和更新操作也许可以优化为并行操作，缩短等待时间；
* 增加 `cd` 子命令；
* 改为 source 的方式来使用？这样能改变当前目录，从而使 cd 子命令成为可能；
* 增加 `rm` 子命令；
* 增加 `name` 子命令；
* 增加 `checkout` 子命令用于查看指定时间的作业的版本；
* ~~增加帮助看作业，过滤作业里的 comments，自动按照维度、加减分整理出来最终的 list，可以直接粘贴使用；~~
* ~~增加 `join` 子命令；~~
* 在学员 repo 的目录运行up和down命令时，不需要指定 repo 和学员
* 原来的 SUBCOMMAND 改叫 COMMAND；
* 内部方法统一以 `__gtb_` 开头；

## Contributors

* 王晓峰 xifwang@thoughtworks.com
* 张钊 zhaozhang@thoughtworks.com
* 屈航 hqu@thoughtworks.com

