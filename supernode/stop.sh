# !/bin/bash
# Author:cryptzoic中国社区技术小组
# UpdateTime:2019-08-11
# 参数处理 - Shell传入参数的处理
# 1. $# 传递到脚本的参数个数
# 2. $ * 以一个单字符串显示所有向脚本传递的参数。与位置变量不同，此选项参数可超过9个
# 3. $?脚本运行的当前进程ID号
# 4. $ ! 后台运行的最后一个进程的进程ID号
# 5. $@ 与$#相同，但是使用时加引号，并在引号中返回每个参数
# 6. $ - 显示shell使用的当前选项，与set命令功能相同
# 7. $?显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
# 变量含义
# $0 脚本名字  $1 位置参数
# $ - 传递到脚本中的标志(使用set)
# $_ 之前命令的最后一个参数
# $ ! 运行在后台的最后一个作业的进程ID(PID)
# 注意根据机器IP修改其中的--rpcaddr 以及--rpcvhosts，此处是因为我们启用了两个AWS负载均衡器，所以需要把对应的host一起绑定

sleep 10s
source ${HOME}/.bashrc
# 跳转到脚本所在目录
cd `dirname $0`
chks=`ps -ef|grep "gvc"|grep -v "grep"|awk '{print $2}'`
if [ -n "${chks}" ]; then
    #kill -9 ${chks}
    #sleep 5s
    # Graceful exit, like pressing Control-C on a program
    killall -q --signal SIGINT gvc
    sleep 10s

    # Hard kill, only to stop a process that refuses to terminate
    killall -q gvc
    sleep 5s
fi
echo "服务已经停止"