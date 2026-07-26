Write-Host
Write-Host "Download and convert a video to MP3"
Write-Host

$youtube_video_url = Read-Host "Video URL"
$title            = Read-Host "Track title"
$artist           = Read-Host "Lead artist"
$album_artist     = Read-Host "Album-level artist"
$album            = Read-Host "Album name"
$date             = Read-Host "Release date or year"
$track            = Read-Host "Track number"
$genre            = Read-Host "Genre"

$title  = $title  -replace '[<>:"/\\|?*]', ''
$artist = $artist -replace '[<>:"/\\|?*]', ''
$album_artist = $album_artist -replace '[<>:"/\\|?*]', ''
$album = $album -replace '[<>:"/\\|?*]', ''
$genre = $genre -replace '[<>:"/\\|?*]', ''

$musicFolder = [Environment]::GetFolderPath('MyMusic')
$fileName = Join-Path $musicFolder "$artist - $title"

Write-Host
Write-Host "Downloading and converting. Please wait..."
Write-Host

yt-dlp `
    --quiet `
    --force-overwrites `
    --extract-audio `
    --format bestaudio `
    --audio-format mp3 `
    --output "$fileName.tmp.%(ext)s" `
    $youtube_video_url `

ffmpeg `
    -loglevel error `
    -y `
    -i "$fileName.tmp.mp3" `
    -metadata title="$title" `
    -metadata artist="$artist" `
    -metadata album_artist="$album_artist" `
    -metadata album="$album" `
    -metadata date="$date" `
    -metadata track="$track" `
    -metadata genre="$genre" `
    "$fileName.mp3"

Remove-Item "$fileName.tmp.mp3"

Write-Host
Write-Host "Download and conversion complete!"
Write-Host
Write-Host "Your music file is here:"
Write-Host "$fileName.mp3"