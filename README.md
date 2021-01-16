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

## Command: gtb

`gtb` 提供了以下命令：

* init：用于初始化运行所需的环境，比如创建空的 `students.txt` 文件；
* check：自动批量检查 GitHub username 是否存在；
* show：显示有哪些学员创建了指定 repo，哪些没有创建指定 repo；
* clone：批量下载 repositories；
* build：批量构建已下载到本地的 repositories；
* update：批量更新已下载到本地的 repositories；
* join：批量接受指定 homework/quiz 的 repository invitations；
* test: 对指定 quiz 指定学员的 repo 运行验收测试；
* up: 将指定的 repo 使用 docker 容器启动起来
* down: 停止并删除 `gtb up` 创建的 docker 容器
* comments：自动把留在 code repo 里的 comments 提取并格式化；
* student：用于执行跟学员相关的各种操作，如：查看列表、随机分组、随机排序并一次点名等；
* repo: 查看指定 org 或 team 的 repos，也可以向 team 添加或删除 repos；
* help：显示帮助信息；

### gtb init

#### 用法：

```shell
gtb init
```

如果 `students.txt` 文件已存在，则不会执行任何操作。如果文件不存在，则创建空的 `students.txt` 文件。

### gtb check

自动批量检查 GitHub username 是否存在。

#### 用法：

```shell
gtb check [student names|tag]
```

```shell
GTB_TERM=xxx gtb check [student names|tag]
```

#### 参数说明：

`[student names]`：限制只检查指定学员，而不是 `students.txt` 中的所有学员；

`[tag]`：限制只检查指定 tag 对应的学员，而不是 `students.txt` 中的所有学员；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

检查当前默认 term 的所有学员：
```shell
gtb check
```

检查当前默认 term 的 team1 里的学员：
```shell
gtb check team1
```

指定检查 term04 的所有学员：
```shell
GTB_TERM=term04 gtb check
```

### gtb show

显示学员名单里，哪些学员创建了指定 repo，哪些没有创建指定 repo。

#### 用法：

```shell
gtb show <repo-name> [student names|tag]
```

```shell
GTB_TERM=xxx gtb show <repo-name> [student names|tag]
```

#### 参数说明：

`<repo-name>`：要下载的 homework 或者是 quiz 所对应的 repository 的名字；

`[student names]`：限制只下载指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；
`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

查看默认 term 的所有学员对 repo `B-spring-config-homework`的创建情况：
```shell
gtb show B-spring-config-homework
```

查看指定 term 的所有学员对 repo `B-spring-config-homework`的创建情况：
```shell
GTB_TERM=term04 gtb show B-spring-config-homework
```

查看指定的学员对 repo `B-spring-config-homework`的创建情况：
```shell
gtb show B-spring-config-homework zhang.san li.si
```

查看指定 tag 对应的学员对 repo `B-spring-config-homework`的创建情况：
```shell
gtb show B-spring-config-homework
```

### gtb clone

批量下载所有或指定学员的 repositories，并支持可选的更新或构建操作。

如本地已存在对应的 repositories，且未指定更新选项，则会跳过对应 repository。

#### 用法：

```shell
gtb clone [options] <repo-name> [student names|tag]
```

```shell
GTB_TERM=xxx gtb clone [options] <repo-name> [student names|tag]
```

#### 可选的 options 有：

`-u`：如果 repo 已下载，则更新 repo，否则会输出提示信息并跳过该 repo；

`-b`：下载完所有 repositories 后，自动执行构建操作；

#### 参数说明：

`<repo-name>`：要下载的 homework 或者是 quiz 所对应的 repository 的名字；

`[student names]`：限制只下载指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；
`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

下载所有学员`B-spring-config-homework`的 repositories：
```shell
gtb clone B-spring-config-homework
```

只下载指定学员`B-spring-config-homework`的 repositories：
```shell
gtb clone B-spring-config-homework zhang.san li.si
```

下载或更新 repositories：
```shell
gtb clone -u B-spring-config-homework
```

下载 repositories 并执行构建操作：
```shell
gtb clone -b B-spring-config-homework
```

### gtb build

批量构建所有或指定学员的 repositories。

#### 用法：

```shell
gtb build <repo-name> [student names|tag]
```

```shell
GTB_TERM=xxx gtb build <repo-name> [student names|tag]
```

#### 参数说明：

`<repo-name>`：要构建的 homework/quiz 所对应的 repository 的名字；

`[student names]`：限制只构建指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；

`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

构建所有学员`B-spring-config-homework`的 repositories：
```shell
gtb build B-spring-config-homework
```

只构建指定学员`B-spring-config-homework`的 repositories：
```shell
gtb build B-spring-config-homework zhang.san li.si
```

### gtb update

批量更新repositories，如果本地不存在对应的 repository，则执行下载操作。

支持指定构建操作，会在全部 repositories 更新完毕后开始运行构建操作。

#### 用法：

```shell
gtb update [options] <repo-name> [student names|tag]
```

#### 可选的 options 有：

`-b`：下载完所有 repositories 后，自动执行构建操作；

#### 参数说明：

`<repo-name>`：要更新的 homework/quiz 所对应的 repository 的名字；

`[student names]`：限制更新指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；

`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

### gtb join

显示并自动接受所有指定 repo 的 repository invitations。

#### 用法：

```shell
gtb join <repo-name>
```

#### 可选的 options 有：

`-l|--list`：只列出已有的 invitations，并不进行 accept 操作；

#### 参数说明：

`<repo-name>`：要接受 invitation 的 homework/quiz 所对应的 repository 的名字；

#### 示例：

接受所有 `B-spring-config-homework` 的 repository invitations：
```shell
gtb join B-spring-config-homework
```

列出所有 `B-spring-config-homework` 的 repository invitations：
```shell
gtb join -l B-spring-config-homework
```

### gtb test

对学员的 repo 进行验收测试，并输出测试结果到 `gtb-test-results.md`。方便讲师对`完成度`维度进行评价和打分。

#### 用法：

```shell
gtb test <repo-name> <student name>
```

```shell
GTB_TERM=xxx gtb test <repo-name> <student name>
```

#### 参数说明：

`<repo-name>`：要测试的 homework/quiz 所对应的 repository 的名字；

`<student names>`：要测试的学员的名字；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

测试学员 `zhang.san` 的 `B-final-quiz`：

```shell
gtb test B-final-quiz zhang.san
```

### gtb up

将学员 repo 使用 docker 容器启动起来, 方便进行验收测试，目前仅支持后端 repo。

#### 用法：

```shell
gtb up <repo-name> <student name>
```

```shell
GTB_TERM=xxx gtb up <repo-name> <student name>
```

#### 参数说明：

`<repo-name>`：要启动容器的 homework/quiz 所对应的 repository 的名字；

`<student names>`：要启动容器的学员的名字；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

启动学员 `zhang.san` 的 `B-final-quiz`：

```shell
gtb up B-final-quiz zhang.san
```

#### 可选的 options 有：

`-t` 或 `--test`：在启动完成后，自动进行验收测试；

### gtb down

停止并删除 `gtb up` 创建的 docker 容器，目前仅支持后端 repo。

#### 用法：

```shell
gtb down <repo-name> <student name>
```

```shell
GTB_TERM=xxx gtb down <repo-name> <student name>
```

#### 参数说明：

`<repo-name>`：要关闭容器的 homework/quiz 所对应的 repository 的名字；

`<student names>`：要关闭容器的学员的名字；

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### 示例：

关闭学员 `zhang.san` 的 `B-final-quiz`的容器：

```shell
gtb down B-final-quiz zhang.san
```

### gtb comments

自动把留在 code repo 里的 comments 提取并格式化输出到当前目录下的 `comments.md` 文件中。

需 `cd` 到对应的 repo 的目录下后使用。

支持的注释格式如下：

* `// TODO GTB-{category}: xxx`
* `/* TODO GTB-{category}: xxx */`
* `<!-- // TODO GTB-{category}: xxx -->`
* `{/* // TODO GTB-{category}: xxx */}`

`category` 的取值为 5 个作业评价维度：综合、完成度、测试、知识点、工程实践。建议使用 IDEA 的 live template 功能来简化上述注释的编写。

`xxx` 部分的格式为：`{symbol} text`。`symbol` 的取值有：`*`、 `+`、 `-`。含义分别如下：
* `*` 表示针对当前维度的总结性评价；
* `+` 针对某个 WELL 的代码细节的评价；
* `-` 针对某个 LESS WELL 的代码细节的评价；

#### 用法：

```shell
gtb comments
完成度：
=======
* foobar 1
* foobar 2

Details:
+ \+ foo 1
+ \+ foo 2
- \- bar 1
- \- bar 2

测试：
=====
* foobar 1
* foobar 2

Details:
+ \+ foo 1
+ \+ foo 2
- \- bar 1
- \- bar 2

知识点：
=======
* foobar 1
* foobar 2

Details:
+ \+ foo 1
+ \+ foo 2
- \- bar 1
- \- bar 2

工程实践：
=========
* foobar 1
* foobar 2

Details:
+ \+ foo 1
+ \+ foo 2
- \- bar 1
- \- bar 2

综合：
=====
* foobar 1
* foobar 2

Details:
+ \+ foo 1
+ \+ foo 2
- \- bar 1
- \- bar 2
```

### gtb student

用于操作学员相关的命令，有以下子命令：

* list：用于查看所有或指定 tag 的学员的列表；
* group：将指定的学员随机分为 N 组；
* random：讲指定的学员随机排序，然后用于点名；

#### gtb student list

查看指定学期的所有学员，或者根据提供的 TAG 进行过滤。

##### 用法：

```shell
gtb student list [tag|student names]
```

```shell
GTB_TERM=XXX gtb student list [tag|student names]
```

##### 参数说明：

`[tag]`：可选参数。用于过滤学员，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`[student names]`：可选参数。用于过滤学员，多个值时以空格分隔，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### gtb student group

把指定的学员随机分为 N 组。默认是对当前学期所以学员进行分组。

##### 用法：

```shell
gtb student group <count> [tag|student names]
```

```shell
GTB_TERM=XXX gtb student group <count> [tag|student names]
```

##### 参数说明：

`<count>`：必填参数。需要划分的组数。

`[tag]`：可选参数。用于过滤学员，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`[student names]`：可选参数。用于过滤学员，多个值时以空格分隔，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

#### gtb student random

对指定的学员进行随机排序，然后可以单个进行点名。

有以下子命令：

* next：用于点名。根据随机排序后的顺序，依次循环显示学员的名字。
* show：显示随机排序后的名单。
* reset：清空名单。
* clear：同 reset。

##### 用法：

对指定的学员进行随机排序，但此时并不会输出排序结果。

排序结果保存在文件 `/tmp/gtb_random_list.txt` 中。

```shell
gtb student random [tag|student names]
```

显示排序结果。如有需要查看完整的排序结果，可以使用 show 子命令。

```shell
gtb student random show
```

根据随机排序结果进行点名，每次显示一个学员的名字。

```shell
gtb student random next
```

情况随机排序结果，在点名结束后可以对随机排序结果进行情况，放置后续被误用。

```shell
gtb student random clear
gtb student random reset
```

##### 参数说明：

`[tag]`：可选参数。用于过滤学员，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`[student names]`：可选参数。用于过滤学员，多个值时以空格分隔，可以查看 `GTB_STUDENTS_FILE` 获取合法的 TAG 取值。

`GTB_TERM`：如需指定跟当前默认 term 不同的 term，可在命令前设置 `GTB_TERM`。

### gtb repo

用于操作 org 下 repos 相关的命令，有以下子命令：

* list：用于查看 org 或 team 下的所有 repos；
* add：用于将指定 repo 添加到指定 team；
* remove：用于将指定 repo 从指定 team 中移除；

#### gtb repo list

显示 org 或 team 下的 repos。当 repo 为 public 时，行尾会有 🟢 标记，以引起使用者的注意，通常我们要求 org 下的 repo 尽量设置为 private。

如果未提供 team 则显示 org 下的 repos，如果提供了 team，则显示 team 下的 repos。

列出的 repos 已经按照名字升序进行了排序。如还需进行计数，请接 `cat -n` 或其它合适的命令。

该命令的输出可直接用于 add 和 remove 等子命令。

由于 GitHub API 的分页最大条数限制为 100，当 repos 数量超过 100 时，该命令则只能显示前 100 个 repos。

##### 用法：

```shell
gtb repo list <organization> [team]
```

##### 参数说明：

`<organization>`：organization 的名字。必填参数；

`[team]`：team 名字，也称 team slug。可选参数，未提供时则返回 org 下的所有 repos；

#### gtb repo add

将一个或多个 repos 加入到指定 org 下的指定 team 中。目前加入时设置的 permission 为 `pull`。

该子命令支持管道输入，以方便使用存储于文本文件中的 repo names 进行批量的添加操作。

##### 用法：

```shell
gtb repo add <organization> <team> [repos]
```

```shell
echo repo1 repo2 | gtb repo add <organization> <team>
```

```shell
cat repos.txt
repo1
repo2

cat repos.txt | gtb repo add <organization> <team>
```

##### 参数说明：

`<organization>`：organization 的名字。必填参数；

`<team>`：team 名字，也称 team slug。必填参数；

`[repos]`：空格分隔的 repo 名称列表；

#### gtb repo remove

将一个或多个 repos 从指定 org 下的指定 team 中移除。

该子命令支持管道输入，以方便使用存储于文本文件中的 repo names 进行批量的移除操作。

##### 用法：

```shell
gtb repo remove <organization> <team> [repos]
```

```shell
echo repo1 repo2 | gtb repo remove <organization> <team>
```

```shell
cat repos.txt
repo1
repo2

cat repos.txt | gtb repo remove <organization> <team>
```

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

* 杜娟 jdu@thoughtworks.com
* 王晓峰 xifwang@thoughtworks.com
* 张钊 zhaozhang@thoughtworks.com

