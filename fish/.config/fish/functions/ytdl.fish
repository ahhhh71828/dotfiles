function ytdl --description '下載影片或音訊，支援任何 yt-dlp 認得的網站，不限 YouTube'
    if not command -q yt-dlp
        echo "ytdl: 找不到 yt-dlp。先跑 brew install yt-dlp ffmpeg" >&2
        return 1
    end

    if not command -q ffmpeg
        echo "ytdl: 找不到 ffmpeg，合併影音和轉 mp3 都需要它。先跑 brew install ffmpeg" >&2
        return 1
    end

    set dir "$HOME/Downloads/video-downloads"

    set url $argv[1]

    if test -z "$url"
        read -P "貼上影片網址: " url
    end

    if test -z "$url"
        echo "沒有網址，取消。"
        return 1
    end

    set info (yt-dlp --no-playlist -f "bv*+ba/b" \
        --print "%(title)s ｜ %(duration_string)s ｜ 最高 %(height)sp" \
        "$url" 2>/dev/null)

    if test -z "$info"
        echo "抓不到影片資訊。網址可能打錯、影片已下架，或需要登入。" >&2
        return 1
    end

    echo ""
    echo "$info"
    echo ""
    echo "1) 最高畫質 MKV — 本機播放器看"
    echo "2) 相容 MP4 — H.264 最高 1080p，要傳給別人或丟剪輯軟體"
    echo "3) MP3 — 含專輯圖片"
    echo ""

    read -P "請選 1/2/3，直接 Enter = 1: " mode

    read -P "檔名，可空白＝用影片標題: " name

    if test -z "$name"
        set out "%(title)s.%(ext)s"
    else
        set out "$name.%(ext)s"
    end

    switch $mode
        case 2
            set fmt "bv*[vcodec^=avc1][height<=1080][ext=mp4]+ba[ext=m4a]/b[vcodec^=avc1][height<=1080][ext=mp4]/b[ext=mp4]"
            set container mp4
        case 3
            set fmt audio
        case '*'
            set fmt "bv*+ba/b"
            set container mkv
    end

    if test "$fmt" = audio
        yt-dlp --no-playlist -N 4 -P "$dir" -o "$out" \
            -x --audio-format mp3 --embed-thumbnail --embed-metadata \
            "$url"
    else
        yt-dlp --no-playlist -N 4 -P "$dir" -o "$out" \
            -f "$fmt" --merge-output-format $container \
            "$url"
    end
end
