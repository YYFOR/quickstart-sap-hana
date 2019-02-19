#!/bin/bash

usage() {
  cat <<EOF
  Usage: $0 [options]
    -h print usage
    -b Bucket where scripts/templates are stored
EOF
  exit 1
}

while getopts ":b:c:" o; do
    case "${o}" in
        b)
            BUILD_BUCKET=${OPTARG}
            ;;
        c)
            STORAGE_BUCKET=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

shift $((OPTIND-1))
[[ $# -gt 0 ]] && usage;

#DOWNLOADLINK=https://s3-ap-northeast-1.amazonaws.com/${BUILD_BUCKET}
#DOWNLOADSTORAGE=https://s3-ap-northeast-1.amazonaws.com/${STORAGE_BUCKET}
DOWNLOADLINK=s3://${BUILD_BUCKET}
DOWNLOADSTORAGE=s3://${STORAGE_BUCKET}


# ------------------------------------------------------------------
#          Download all the scripts needed for HANA install
# ------------------------------------------------------------------

aws s3 cp ${DOWNLOADLINK}/scripts/cluster-watch-engine.sh /root/install/cluster-watch-engine.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-prereq.sh /root/install/install-prereq.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-prereq-sles.sh /root/install/install-prereq-sles.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-prereq-rhel.sh /root/install/install-prereq-rhel.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-aws.sh /root/install/install-aws.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-master.sh  /root/install/install-master.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-hana-master.sh /root/install/install-hana-master.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-worker.sh /root/install/install-worker.sh
aws s3 cp ${DOWNLOADLINK}/scripts/install-hana-worker.sh /root/install/install-hana-worker.sh
aws s3 cp ${DOWNLOADLINK}/scripts/reconcile-ips.py /root/install/reconcile-ips.py
aws s3 cp ${DOWNLOADLINK}/scripts/reconcile-ips.sh /root/install/reconcile-ips.sh
aws s3 cp ${DOWNLOADLINK}/scripts/wait-for-master.sh /root/install/wait-for-master.sh
aws s3 cp ${DOWNLOADLINK}/scripts/wait-for-workers.sh /root/install/wait-for-workers.sh
aws s3 cp ${DOWNLOADLINK}/scripts/config.sh /root/install/config.sh
aws s3 cp ${DOWNLOADLINK}/scripts/cleanup.sh /root/install/cleanup.sh
aws s3 cp ${DOWNLOADLINK}/scripts/fence-cluster.sh /root/install/fence-cluster.sh
aws s3 cp ${DOWNLOADLINK}/scripts/signal-complete.sh /root/install/signal-complete.sh
aws s3 cp ${DOWNLOADLINK}/scripts/signal-failure.sh /root/install/signal-failure.sh
aws s3 cp ${DOWNLOADLINK}/scripts/interruptq.sh /root/install/interruptq.sh
aws s3 cp ${DOWNLOADLINK}/scripts/os.sh /root/install/os.sh
aws s3 cp ${DOWNLOADLINK}/scripts/validate-install.sh /root/install/validate-install.sh
aws s3 cp ${DOWNLOADLINK}/scripts/signalFinalStatus.sh /root/install/signalFinalStatus.sh
aws s3 cp ${DOWNLOADLINK}/scripts/writeconfig.sh /root/install/writeconfig.sh
aws s3 cp ${DOWNLOADLINK}/scripts/create-attach-volume.sh /root/install/create-attach-volume.sh
aws s3 cp ${DOWNLOADLINK}/scripts/configureVol.sh /root/install/configureVol.sh
aws s3 cp ${DOWNLOADLINK}/scripts/create-attach-single-volume.sh /root/install/create-attach-single-volume.sh
aws s3 cp ${DOWNLOADSTORAGE}/storage.json /root/install/storage.json

for f in download_media.py extract.sh get_advancedoptions.py postprocess.py signal-precheck-failure.sh signal-precheck-status.sh signal-precheck-success.sh build_storage.py
do
    aws s3 cp ${DOWNLOADLINK}/scripts/${f} /root/install/${f}
done
