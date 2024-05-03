#!/bin/bash
cd /data1/prachis/DISPLACE2023/track2_cluster
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
nnet3-train --use-gpu=yes --read-cache=exp/displace_dev_sad_tdnn_stats/cache.50 --print-interval=10 --momentum=0.5 --max-param-change=0.2 --backstitch-training-scale=0.0 --l2-regularize-factor=0.2 --backstitch-training-interval=1 --srand=50 --optimization.min-deriv-time=-34 --optimization.max-deriv-time-relative=56 "nnet3-copy --learning-rate=0.0006447993520623416 --scale=1.0 exp/displace_dev_sad_tdnn_stats/50.raw - |" "ark,bg:nnet3-copy-egs               ark:exp/displace_dev_sad_tdnn_stats/egs/egs.15.ark ark:- |             nnet3-shuffle-egs --buffer-size=5000             --srand=50 ark:- ark:- |              nnet3-merge-egs --minibatch-size=128,64 ark:- ark:- |" exp/displace_dev_sad_tdnn_stats/51.5.raw 
EOF
) >exp/displace_dev_sad_tdnn_stats/log/train.50.5.log
time1=`date +"%s"`
 ( nnet3-train --use-gpu=yes --read-cache=exp/displace_dev_sad_tdnn_stats/cache.50 --print-interval=10 --momentum=0.5 --max-param-change=0.2 --backstitch-training-scale=0.0 --l2-regularize-factor=0.2 --backstitch-training-interval=1 --srand=50 --optimization.min-deriv-time=-34 --optimization.max-deriv-time-relative=56 "nnet3-copy --learning-rate=0.0006447993520623416 --scale=1.0 exp/displace_dev_sad_tdnn_stats/50.raw - |" "ark,bg:nnet3-copy-egs               ark:exp/displace_dev_sad_tdnn_stats/egs/egs.15.ark ark:- |             nnet3-shuffle-egs --buffer-size=5000             --srand=50 ark:- ark:- |              nnet3-merge-egs --minibatch-size=128,64 ark:- ark:- |" exp/displace_dev_sad_tdnn_stats/51.5.raw  ) 2>>exp/displace_dev_sad_tdnn_stats/log/train.50.5.log >>exp/displace_dev_sad_tdnn_stats/log/train.50.5.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/displace_dev_sad_tdnn_stats/log/train.50.5.log
echo '#' Finished at `date` with status $ret >>exp/displace_dev_sad_tdnn_stats/log/train.50.5.log
[ $ret -eq 137 ] && exit 100;
touch exp/displace_dev_sad_tdnn_stats/q/sync/done.90577
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/displace_dev_sad_tdnn_stats/q/train.50.5.log -q gpu.q,longgpu.q -l hostname=compute-0-[0-7] -l gpu=1 -q *.q   /data1/prachis/DISPLACE2023/track2_cluster/exp/displace_dev_sad_tdnn_stats/q/train.50.5.sh >>exp/displace_dev_sad_tdnn_stats/q/train.50.5.log 2>&1
