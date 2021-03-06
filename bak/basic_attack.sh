#!/bin/bash

trace="./trace/"
hasher="fs-hasher-0.9.4"
results="results"

hasher_outputs="tmp"
analysis_scripts="."
users=('004' '007' '008' '012' '013' '015' '022' '026'  '028')
months=('01' '02' '03' '04' '05' '06')

#months=('01')
year=2013
dates=('01' '02' '03' '04' '05' '06' '07' '08' '09' '10'
		'11' '12' '13' '14' '15' '16' '17' '18' '19' '20'
		'21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31')
#dates=('22')

for month in ${months[@]}; do
for date in ${dates[@]}; do  
for user in ${users[@]}; do
snapshot="fslhomes-user${user}-${year}-${month}-${date}"
if [ -f ${trace}/${snapshot}.tar.gz ]; then
echo ${snapshot}.tar.gz 
tar zxf ${trace}/${snapshot}.tar.gz 

echo analyze ${snapshot} 
${hasher}/hf-stat -h ${snapshot}/${snapshot}.8kb.hash.anon > ${hasher_outputs}/${snapshot} 
echo "user: ${user}" >> ${results}/${year}-${month}-${date}
${analysis_scripts}/FSL-ANALYSIS ${hasher_outputs}/${snapshot} >> ${results}/${year}-${month}-${date}  

echo ${snapshot} done 
rm -rf ${snapshot}
rm -rf ${hasher_outputs}/${snapshot}
fi
done
done
done


