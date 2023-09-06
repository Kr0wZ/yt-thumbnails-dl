# yt-thumbnails-dl
This bash script allows you to download thumbnails from Youtube videos given a URL


### Usage

Simply specify the URL as parameter to the script:
```bash
#Give execution permission
chmod +x thumbnail_downloader.sh 

#Call the script with the URL
./thumbnail_downloader.sh -u https://www.youtube.com/watch?v=RVbRm76zLVQ

#Call the script with a file containing a list of Youtube URLs (one per line)
./thumbnail_downloader.sh -f urls.txt
```

