#!/usr/bin/env bash


#压测脚本模板中设定的压测时间应为20秒
export jmx_template="iInterface"
export suffix=".jmx"
export jmx_template_filename="${jmx_template}${suffix}"
export os_type=`uname`

#需要在系统变量中定义jmeter根目录位置如下
#export jmeter_path="/your jmeter path/"
#export jmeter_path="/jmeter/apache-jmeter-5.4.3/apache-jmeter-5.4.3"
echo "auto_stress_test start..."


#压测并发数列表
thread_number_array=(10 20 30)
for num in "${thread_number_array[@]}"
do
    #生成对应压测线程的jmx文件
    export jmx_filename="${jmx_template}_${num}${suffix}"
    export jtl_filename="test_${num}.jtl"
    export web_report_path_name="web_${num}"

    rm -f ${jmx_filename} ${jtl_filename}
    rm -rf ${web_report_path_name}

    cp ${jmx_template_filename} ${jmx_filename}
    echo "create jmx stress test scriptes ${jmx_filename}"

#    if [[ "${os_type}"=="Darwin" ]]; then
#        sed -i "" "s/thread_num/${num}/g" ${jmx_filename}
#
#    else
#        sed -i "s/thread_num/${num}/g" ${jmx_filename}
#     fi

     sed -i "s/thread_num/${num}/g" ${jmx_filename}
     #JMeter静默压测
     echo ${JMETER_HOME}/bin/jmeter
     ${JMETER_HOME}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}

     #生成Web压测报告
     ${JMETER_HOME}/bin/jmeter -g ${jtl_filename} -e -o ${web_report_path_name}

     rm -f ${jmx_filename} ${jtl_filename}
done
echo "auto stress test finish"