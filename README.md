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

### GTB_ROOT

所有需要的初始设置和使用中产生的数据都会放到`GTB_ROOT`目录中，默认位置是`$HOME/code/gtb`，如需指定其它位置，请自行设置环境变量`GTB_ROOT`的值即可。

### GTB_STUDENTS_FILE

学员的信息通过`students.txt`文件提供，默认位置为`$GTB_ROOT/students.txt`，如需自定义位置，请设置环境变量`GTB_STUDENTS_FILE`的值。

`students.txt`内容示例：

```shell
$ cat students.txt group1 team1
yuqi.wang Uncontrollablly group1 team2
peng.tian ifeelcold1824 group2 team3
```

每行表示一个学员，有 2+ 列，列之间由空格分隔：

1. 第一列是学员名字的拼音全拼；
1. 第二列是学员 Github username；
1. 后续列为自定义的 tags，每个 tag 一列，每行的 tags 根据需要设置，数量不必一致；

**名字拼音请勿包含空格！**

## Command: gtb

`gtb` 的主要功能有：

* 批量下载 homework repositories；
* 批量更新已下载的 homework repositories；
* 批量执行构建操作；

`gtb` 提供了以下子命令来完成上述功能：

* init：用于初始化运行所需的环境，比如创建空的 `students.txt` 文件；
* clone：批量下载 repositories；
* build：批量构建已下载到本地的 repositories；
* update：批量更新已下载到本地的 repositories；

### gtb init

#### 用法：

```shell
gtb init
```

如果 `students.txt` 文件已存在，则不会执行任何操作。如果文件不存在，则创建空的 `students.txt` 文件。

### gtb clone

批量下载所有或指定学员的 repositories，并支持可选的更新或构建操作。

如本地已存在对应的 repositories，且未指定更新选项，则会跳过对应 repository。

#### 用法：

```shell
gtb clone [options] <repo-name> [student names|tag]
```

#### 可选的 options 有：

`-u`：如果 repo 已下载，则更新 repo，否则会输出提示信息并跳过该 repo；

`-b`：下载完所有 repositories 后，自动执行构建操作；

#### 参数说明：

`<repo-name>`：要下载的 homework 或者是 quiz 所对应的 repository 的名字；

`[student names]`：限制只下载指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；
`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

#### 示例：

下载所有学员`B-spring-config-homework`的 repositories：
```shell
gtb clone B-spring-config-homework
```

只下载指定学员`B-spring-config-homework`的 repositories：
```shell
gtb clone B-spring-config-homework san.zhang si.li
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

#### 参数说明：

`<repo-name>`：要构建的 homework 或者是 quiz 所对应的 repository 的名字；

`[student names]`：限制只构建指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；

`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

#### 示例：

构建所有学员`B-spring-config-homework`的 repositories：
```shell
gtb build B-spring-config-homework
```

只构建指定学员`B-spring-config-homework`的 repositories：
```shell
gtb build B-spring-config-homework san.zhang si.li
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

`<repo-name>`：要更新的 homework 或者是 quiz 所对应的 repository 的名字；

`[student names]`：限制更新指定学员的 repositories，而不是 `students.txt` 中所有学员的 repositories；

`[tag]`：限制只下载指定 tag 的 repositories，而不是 `students.txt` 中所有学员的 repositories，只支持同时指定最多一个 tag；

#### 示例：

更新所有学员`B-spring-config-homework`的 repositories：
```shell
gtb update B-spring-config-homework
```

只更新指定学员`B-spring-config-homework`的 repositories：
```shell
gtb update B-spring-config-homework san.zhang si.li
```

更新并执行构建操作：
```shell
gtb update -b B-spring-config-homework
```

## TODO

* 目前 build project 时前端支持的是 yarn，考虑未来增加更多支持；
* 兼容性问题暂未考虑，使用中遇到时再改；
* 更新 repo 时，如果 repo 有本地修改的话更新会失败。需要商量一个处理方式，并实施；
* 处理错误场景：repo 不存在的情况；
* 支持显示 usage；
* 下载和更新操作也许可以优化为并行操作，缩短等待时间；
* 增加 `cd` 子命令；
* 改为 source 的方式来使用？这样能改变当前目录，从而使 cd 子命令成为可能；

## Contributors

1. 杜娟 jdu@thoughtworks.com
1. 王晓峰 xifwang@thoughtworks.com

