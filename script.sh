NEXUS_USERNAME="yourNexusUsername"
NEXUS_PASSWORD="yourNexusPassword"
NEXUS_UPLOAD_URL="http://yourNexusUrl/repository/yourRepositoryName"

# Function to upload an artifact to Nexus
upload_artifact() {
    local artifact_path="$1"
    local artifact_name=$(basename "$artifact_path")
    local artifact_upload_path="${artifact_path//\/your\/localrepo\/path\//}"
    local artifact_url="$NEXUS_UPLOAD_URL/$artifact_upload_path"

    echo "Uploading artifact: $artifact_name"
    curl -v -u "$NEXUS_USERNAME:$NEXUS_PASSWORD" --upload-file "$artifact_path" "$artifact_url"
}

for artifact_path in $(find "com" -type f \( -name "*.jar" -o -name "*.pom" \)); do
    upload_artifact "$artifact_path"
done

echo "Bulk upload completed"