#!/bin/bash

#******************************************************************************
# * @file           : 5_MPU_RunGGLite.sh
# * @brief          : 
# ******************************************************************************
# * @attention
# *
# * <h2><center>&copy; Copyright (c) 2022 STMicroelectronics.
# * All rights reserved.</center></h2>
# *
# * This software component is licensed by ST under BSD 3-Clause license,
# * the "License"; You may not use this file except in compliance with the
# * License. You may obtain a copy of the License at:
# *                        opensource.org/licenses/BSD-3-Clause
# ******************************************************************************

# Source the configuration file

GG_DIR="/home/root/gg_lite/"

dpkg -i ${GG_DIR}libzip_1.9.2-r0.0_armhf.deb

dpkg -i ${GG_DIR}uriparser_0.9.7-r0.0_armhf.deb

tar xvf ${GG_DIR}bin.gz -C /home/root/

cp -r ${GG_DIR}certs /home/root/certs 

mkdir -p run

cd run
../build/bin/ggconfigd > daemon.log 2>&1 &

daemon_pid=$!

sleep 5

../build/bin/ggl-config-init --config ${GG_DIR}init_config.yml

kill -9 $daemon_pid

../build/bin/run_nucleus