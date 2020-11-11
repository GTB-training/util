# LTG 

## 简介

LTG(Live Template Generator) 可以用来生成 IntelliJ IDEA 的 Live Template 的 XML 文件。

该 Live Template 集成了常用的 comments，方便讲师看 quiz 时快速的输入 comments。

## Live Template 生成

cd 到 gtl 根目录下，并执行 `glt` 命令
```shell
cd ltg
./ltg
```
**glt 命令必须在 gtl 根目录下执行**

## Live Template 安装

将生成的 `GTB.xml` 文件复制到 IntelliJ IDEA 的相应目录
```shell
cp GTB.xml ~/Library/Application\ Support/JetBrains/IntelliJIdea2020.2/templates/GTB.xml
```
**IntelliJ IDEA版本请使用自己当前使用的版本**

## Live Template 使用

安装完成后会有如下 Live Template 可供使用
* gcs：综合comments
* gcc：完成度维度的comments
* gct：测试维度的comments
* gck：知识点运用维度的comments
* gcp：工程实践维度的comments
