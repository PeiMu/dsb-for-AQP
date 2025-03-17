#!/bin/bash

cp -r ../code/tools/1_instance_out/ ../code/tools/1_instance_out_Official/
cp -r ../code/tools/1_instance_out/ ../code/tools/1_instance_out_QuerySplit/

cp edit_query.sh ../code/tools/1_instance_out_QuerySplit/

pushd ../code/tools/1_instance_out_QuerySplit/
bash ./edit_query.sh
popd
