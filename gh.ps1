
$IMAGE_NAME = "aalmann/gh-cli"

if ("$Env:GH_TOKEN" -eq "") {
    Write-Output "No token GH_TOKEN given. This will not work for the most of the commands."
    $TOKEN_ENV = ""
} else {
    Write-Output "GH_TOKEN found in environment. Will using it."
    $TOKEN_ENV = "-e","GH_TOKEN=$Env:GH_TOKEN"   
}

docker run $TOKEN_ENV -v "$(Get-Location):/gh" "$IMAGE_NAME" $args
