artifact_url=$1
echo $2

resource_endpoint=$artifact_url
output="test-file.date"
echo "$(date) | Start fetch $resource_endpoint"
curl -v --no-tcp-nodelay -o $output -X GET "${resource_endpoint}"
echo "$(date) | End fetch $resource_endpoint"
echo "Artifact: ${group}.${artifact}\nVersion: ${version}\nRetireved At: $(date)" >> artifact-metadata.txt
retrieved_size=$(echo $(stat --printf="%s" $output))
expected_size=$(echo $(curl -sI $resource_endpoint | grep -i Content-Length | awk '{print $2}'))
if [ $retrieved_size -eq $expected_size ]; then
  echo "Artifact retrieved from ${resource_endpoint} verified to be valid."
else
  echo "A problem has occurred while downloading artifact from ${resource_endpoint}"
  echo "Downloaded artifact size: ${retrieved_size}"
  echo "Expected artifact size: ${expected_size}"
  exit 1
fi