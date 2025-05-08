#!/bin/bash

cp -r ../code/tools/1_instance_out_qs/ ../code/tools/1_instance_out_qs_Official/
cp -r ../code/tools/1_instance_out_qs/ ../code/tools/1_instance_out_qs_QuerySplit/

cp edit_query.sh ../code/tools/1_instance_out_qs_Official/
cp edit_QS_query.sh ../code/tools/1_instance_out_qs_QuerySplit/

pushd ../code/tools/1_instance_out_qs_Official/
bash ./edit_query.sh
popd
pushd ../code/tools/1_instance_out_qs_QuerySplit/
bash ./edit_QS_query.sh
popd
