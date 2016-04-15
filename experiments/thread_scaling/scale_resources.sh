THISDIR=`pwd`
TOPDIR=/home/jahausw/projects/djinn
TONICIMG=${TOPDIR}/tonic-suite/img

cd ${TONICIMG}

for app in imc face dig; do
    mkdir -p ${THISDIR}/$app
    rm -rf ${THISDIR}/$app/*
    for THREADS in 1 2 3 4; do
        export OMP_NUM_THREADS=${THREADS} 
        for i in `seq 1 1 10`; do
            ./tonic-img --task $app --network $app.prototxt --weight $app.caffemodel --input $app-list.txt --djinn 0 --fname ${THISDIR}/${app}/cpu_${THREADS}.csv --gpu false
        done
    done
done

for app in imc face dig; do
    mkdir -p ${THISDIR}/$app
    for i in `seq 1 1 10`; do
        ./tonic-img --task $app --network $app.prototxt --weight $app.caffemodel --input $app-list.txt --djinn 0 --fname ${THISDIR}/${app}/gpu.csv --gpu true
    done
done
