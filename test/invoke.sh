
for name in "py312" "py311" "py310" "py39" "py38" "py37"; do
    pkgs=$(aws lambda invoke --function-name "cm-nakamura-lambda-${name}" output.txt >> /dev/null &&
        cat output.txt | jq ".body" | sed 's/"//g')
    echo -e -n ${pkgs} >${name}.txt
done

# https://docs.powertools.aws.dev/lambda/python/latest/
for name in "py312" "py311" "py37"; do
    pkgs=$(aws lambda invoke --function-name "cm-nakamura-lambda-${name}_powertools" output.txt >> /dev/null &&
        cat output.txt | jq ".body" | sed 's/"//g')
    echo -e -n ${pkgs} >${name}_powertools.txt
done

# https://aws-sdk-pandas.readthedocs.io/en/stable/layers.html
for name in "py312" "py311" "py310" "py39" "py38" "py37"; do
    pkgs=$(aws lambda invoke --function-name "cm-nakamura-lambda-${name}_sdkpandas" output.txt >> /dev/null &&
        cat output.txt | jq ".body" | sed 's/"//g')
    echo -e -n ${pkgs} >${name}_sdkpandas.txt
done

# https://aws-sdk-pandas.readthedocs.io/en/stable/layers.html
for name in "py38" "py37"; do
    pkgs=$(aws lambda invoke --function-name "cm-nakamura-lambda-${name}_scipy" output.txt >> /dev/null &&
        cat output.txt | jq ".body" | sed 's/"//g')
    echo -e -n ${pkgs} >${name}_scipy.txt
done