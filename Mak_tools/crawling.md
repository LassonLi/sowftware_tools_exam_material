# Wget

#### wget www.baidu.com 会下载该网页的html源码，文件名为index.html

#### wget -p  www.baidu.com 

wget命令中的`-p`选项表示下载页面所需的所有资源，包括HTML文件、CSS样式表(stylesheet)、JavaScript脚本、图片等。这样可以将整个页面及其相关资源下载到本地。还有一个robots.txt该文件会告诉你什么什么类型的爬虫机器人不能爬什么，该文件储存在所爬网页根目录。

#### wget -r -l N www.google.com

-r表示递归，`-l N`选项用于指定递归下载的最大深度。例如，`-l 2`表示最多递归下载两级深度的链接。

不指定就默认5层

#### wget -m www.baidu.com

wget命令的`-m`选项是`--mirror`的缩写，用于创建指定网站的本地镜像。它递归下载指定网站的所有文件，包括HTML文件、图片、样式表、JavaScript等，并在本地保持网站的目录结构。该选项通常用于备份整个网站或创建离线副本。

#### Wget -l N www.baidu.com

-l表示每一次爬取等待N秒，常用于递归爬取



