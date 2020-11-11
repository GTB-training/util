# LTG 

## 简介

LTG(Live Template Generator) 可以用来为 IntelliJ IDEA 生成 Live Template 的 XML 文件。

该 Live Template 集成了常用的 comments，方便讲师看 quiz 时快速的输入 comments。

## Live Template 生成

cd 到 ltg 根目录下，并执行 `ltg` 命令
```shell
cd ltg
./ltg
```
**ltg 命令必须在 ltg 根目录下执行**

## Live Template 安装

将生成的 `GTB.xml` 文件复制到 IntelliJ IDEA 的相应目录, 然后重启 IntelliJ IDEA
```shell
cp GTB.xml ~/Library/Application\ Support/JetBrains/IntelliJIdea2020.2/templates/GTB.xml
```
**IntelliJ IDEA版本请使用自己当前使用的版本**

## Live Template 使用

安装完成后会有如下 Live Template 可供使用
* gcs：(gtb comments for summary) 综合comments
* gcc：(gtb comments for completeness) 完成度维度的comments
* gct：(gtb comments for test) 测试维度的comments
* gck：(gtb comments for knowledge usage) 知识点运用维度的comments
* gcp：(gtb comments for engineering practice) 工程实践维度的comments
