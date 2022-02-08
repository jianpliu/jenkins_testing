#!/usr/bin/env bash


#ѹ��ű�ģ�����趨��ѹ��ʱ��ӦΪ20��
export jmx_template="iInterface"
export suffix=".jmx"
export jmx_template_filename="${jmx_template}${suffix}"
export os_type=`uname`

#��Ҫ��ϵͳ�����ж���jmeter��Ŀ¼λ������
#export jmeter_path="/your jmeter path/"
#export jmeter_path="/jmeter/apache-jmeter-5.4.3/apache-jmeter-5.4.3"
echo "auto_stress_test start..."


#ѹ�Ⲣ�����б�
thread_number_array=(10 20 30)
for num in "${thread_number_array[@]}"
do
    #���ɶ�Ӧѹ���̵߳�jmx�ļ�
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
     #JMeter��Ĭѹ��
     echo ${JMETER_HOME}/bin/jmeter
     ${JMETER_HOME}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}

     #����Webѹ�ⱨ��
     ${JMETER_HOME}/bin/jmeter -g ${jtl_filename} -e -o ${web_report_path_name}

     rm -f ${jmx_filename} ${jtl_filename}
done
echo "auto stress test finish"