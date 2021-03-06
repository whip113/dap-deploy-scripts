#!/usr/bin/env bash

. config.sh

run_sec_profile="seccomp=unconfined"

if [ "$seccomp_profile_path" != "" ];then
    run_sec_profile="seccomp=$seccomp_profile_path"
fi

docker run --name $container_name \
    -d --restart=unless-stopped \
    --security-opt $run_sec_profile \
    --log-driver="journald" \
    -v $host_audit_log_dir:/var/log/conjur \
    -v $host_backup_dir:/opt/conjur/backup \
    -p "443:443" -p "1999:1999" -p "5432:5432" \
    -p "444:444" \
    $dap_image
