# Function to check if a command exists
function Test-Command {
    param (
        [string]$command
    )
    $result = $null
    try {
        $result = Get-Command $command -ErrorAction Stop
    } catch {
        $result = $null
    }
    return $result
}

# Check if Git is installed
if (-not (Test-Command "git")) {
    Write-Output "Git is not installed."
    Write-Output "Download Git:"
    Write-Output "- https://git-scm.com/downloads"
    Write-Output "OR"
    Write-Output "- `winget install -e --id Git.Git` "
} else {
    Write-Output "Git is installed."
}

# Check if Docker is installed
if (-not (Test-Command "docker")) {
    Write-Output "Docker is not installed."
    Write-Output "You need to download Docker."
    Write-Output "You can try: `winget install -e --id Docker.DockerDesktop` or use your browser."
    Write-Output "- https://www.docker.com/"
    Write-Output "OR"
    Write-Output "- `winget install -e --id Docker.DockerDesktop` "
} else {
    Write-Output "Docker is installed."
}

# Set repository name
$name = "BackCap"

# Clone the repository
if (Test-Command "git") {
    Write-Output "Cloning the repository..."
    git clone "https://github.com/Edems-DEV/$name.git"

    # Navigate into the repository
    Set-Location -Path $name

    # Run docker compose up
    if (Test-Command "docker") {
        Write-Output "Running docker compose up..."
        docker compose up -d
    } else {
        Write-Output "Docker command not found. Please ensure Docker is installed."
    }
} else {
    Write-Output "Git command not found. Please install Git to proceed."
}


# Open browser to localhost:4200
Start-Process "http://localhost:4200"
Write-Output "LOGIN: admin:admin"

Write-Output "Setup script execution completed."
