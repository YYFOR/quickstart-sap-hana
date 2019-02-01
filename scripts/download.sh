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

DOWNLOADLINK=https://s3-ap-northeast-1.amazonaws.com/${BUILD_BUCKET}
DOWNLOADSTORAGE=https://s3-ap-northeast-1.amazonaws.com/${STORAGE_BUCKET}

# ------------------------------------------------------------------
#          Download all the scripts needed for HANA install
# ------------------------------------------------------------------

wget ${DOWNLOADLINK}/scripts/cluster-watch-engine.sh --output-document=/root/install/cluster-watch-engine.sh
wget ${DOWNLOADLINK}/scripts/install-prereq.sh --output-document=/root/install/install-prereq.sh
wget ${DOWNLOADLINK}/scripts/install-prereq-sles.sh --output-document=/root/install/install-prereq-sles.sh
wget ${DOWNLOADLINK}/scripts/install-prereq-rhel.sh --output-document=/root/install/install-prereq-rhel.sh
wget ${DOWNLOADLINK}/scripts/install-aws.sh --output-document=/root/install/install-aws.sh
wget ${DOWNLOADLINK}/scripts/install-master.sh  --output-document=/root/install/install-master.sh
wget ${DOWNLOADLINK}/scripts/install-hana-master.sh --output-document=/root/install/install-hana-master.sh
wget ${DOWNLOADLINK}/scripts/install-worker.sh --output-document=/root/install/install-worker.sh
wget ${DOWNLOADLINK}/scripts/install-hana-worker.sh --output-document=/root/install/install-hana-worker.sh
wget ${DOWNLOADLINK}/scripts/reconcile-ips.py --output-document=/root/install/reconcile-ips.py
wget ${DOWNLOADLINK}/scripts/reconcile-ips.sh --output-document=/root/install/reconcile-ips.sh
wget ${DOWNLOADLINK}/scripts/wait-for-master.sh --output-document=/root/install/wait-for-master.sh
wget ${DOWNLOADLINK}/scripts/wait-for-workers.sh --output-document=/root/install/wait-for-workers.sh
wget ${DOWNLOADLINK}/scripts/config.sh --output-document=/root/install/config.sh
wget ${DOWNLOADLINK}/scripts/cleanup.sh --output-document=/root/install/cleanup.sh
wget ${DOWNLOADLINK}/scripts/fence-cluster.sh --output-document=/root/install/fence-cluster.sh
wget ${DOWNLOADLINK}/scripts/signal-complete.sh --output-document=/root/install/signal-complete.sh
wget ${DOWNLOADLINK}/scripts/signal-failure.sh --output-document=/root/install/signal-failure.sh
wget ${DOWNLOADLINK}/scripts/interruptq.sh --output-document=/root/install/interruptq.sh
wget ${DOWNLOADLINK}/scripts/os.sh --output-document=/root/install/os.sh
wget ${DOWNLOADLINK}/scripts/validate-install.sh --output-document=/root/install/validate-install.sh
wget ${DOWNLOADLINK}/scripts/signalFinalStatus.sh --output-document=/root/install/signalFinalStatus.sh
wget ${DOWNLOADLINK}/scripts/writeconfig.sh --output-document=/root/install/writeconfig.sh
wget ${DOWNLOADLINK}/scripts/create-attach-volume.sh --output-document=/root/install/create-attach-volume.sh
wget ${DOWNLOADLINK}/scripts/configureVol.sh --output-document=/root/install/configureVol.sh
wget ${DOWNLOADLINK}/scripts/create-attach-single-volume.sh --output-document=/root/install/create-attach-single-volume.sh
wget ${DOWNLOADSTORAGE}/storage.json --output-document=/root/install/storage.json

for f in download_media.py extract.sh get_advancedoptions.py postprocess.py signal-precheck-failure.sh signal-precheck-status.sh signal-precheck-success.sh build_storage.py
do
    wget ${DOWNLOADLINK}/scripts/${f} --output-document=/root/install/${f}
done
