#!/bin/bash

#label-studio start my_project ${INIT_COMMAND} --host 0.0.0.0 --input-path=label_studio/static/images/annotation-studio/json --input-format=json-dir
#label-studio start ${PROJECT_NAME:-my_project} --init -b --host 0.0.0.0 --port ${PORT:-8080}

#        label-studio init ${PROJECT_NAME:-annotation_project} --input-path=/cloudstorage/annotation-studio/json --input-format=json-dir --label-config=/cloudstorage/annotation-studio/config.xml
#        label-studio start ${PROJECT_NAME:-annotation_project} ${INIT_COMMAND} -b --host 0.0.0.0 --port ${PORT:-8080}


label-studio init ${PROJECT_NAME:-annotation_project}
label-studio start ${PROJECT_NAME:-annotation_project} ${INIT_COMMAND} -b --host 0.0.0.0 --port ${PORT:-8080}
