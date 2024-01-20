#!/bin/bash

pushd ../../../python >>/dev/null
poetry export --without-hashes --format=requirements.txt > requirements.txt
popd >>/dev/null
rm -rf ./lambda_layer/python >>/dev/null
python3 -m pip install -q --upgrade pip
python3 -m pip install -q -t ./lambda_layer/python -r ../../../python/requirements.txt

echo "{}"
