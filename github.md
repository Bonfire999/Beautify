cd ~/my-project

# 1. 初始化（会生成 .git 隐藏文件夹）
git init

# 2.（可选但推荐）加个 .gitignore，避免把 node_modules、.env 这类东西传上去
#    可以手建，也可以参考 github/gitignore 模板

# 3. 把所有文件加入暂存
git add .

# 4. 首次提交
git commit -m "Initial commit"

# 把远程仓库起个别名叫 origin（惯例叫法）
git remote add origin https://github.com/用户名/仓库名.git

# 验证一下
git remote -v

# GitHub 默认分支是 main，本地 git init 出来可能是 master，统一改名
git branch -M main

# 首次推送，-u 把 origin/main 设为上游，以后直接 git push 就行
git push -u origin main

第一次推完，-u已经绑好上游，平时就这三句：
git add .
git commit -m "描述这次改了啥"
git push