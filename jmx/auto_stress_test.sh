#!/usr/bin/env bash

#ѹ��ű�ģ�����趨��ѹ��ʱ��ӦΪ20��
export jmx_template="iInterface"
export suffix=".jmx"
export jmx_template_filename="${jmx_template}${suffix}"
export os_type=`uname`

#��Ҫ��ϵͳ�����ж���jmeter��Ŀ¼λ������
#export jmeter_path="/your jmeter path/"

echo "�Զ���ѹ�⿪ʼ"


#ѹ�Ⲣ�����б�
thread_num_array=(10 20 30)
for num in "${thread_num_array[@]}"
do
    #���ɶ�Ӧѹ���̵߳�jmx�ļ�
    export jmx_filename="${jmx_template}_${num}${suffix}"
    export jtl_filename="test_${num}.jtl"
    export web_report_path_name="web_${num}"

    rm -f ${jmx_filename} ${jtl_filename}
    rm -rf ${web_report_path_name}

    cp ${jmx_template_filename} ${jmx_filename}
    echo "����jmxѹ��ű� ${jmx_filename}"

    if [[ "${os_type}"=="Darwin" ]];then
        sed -i "" "s/thread_num/${num}/g" ${jmx_filename}
    else
        sed -i "s/thread_num/${num}/g" ${jmx_filename}
     fi


     #JMeter��Ĭѹ��
     ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}

     #����Webѹ�ⱨ��
     ${jmeter_path}/bin/jmeter -g ${jtl_filename} -e -o ${web_report_path_name}

     rm -f ${jmx_filename} ${jtl_filename}
done
echo "�Զ���ѹ��ȫ������"