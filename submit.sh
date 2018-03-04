#!/bin/sh
# script to submit python jobs to HPC queue using a conda environment
if (( $# != 1 ))
then
  echo "Supply the path to a python script as the one argument."
  exit 1
fi
job=job.bsub
nm=`basename "$1"`
rm -f  $job
echo "#!/bin/sh" >> $job
echo "#BSUB -q mellanox-ib" >> $job
echo "#BSUB -J $nm" >> $job
echo "#BSUB -oo P-%J.out" >> $job
echo "#BSUB -eo P-%J.err" >> $job
echo ". /etc/profile" >> $job
# need to add the anaconda module
echo "module add python/anaconda/4.2/2.7" >> $job
# activate the environment for this queue
echo "source activate keras-tf" >> $job
echo "python $1" >> $job

echo "Submitting $1 to the queue..."
bsub < $job
