# PureCodec Patch

這項專案是用來自動產生可以更新 [PureCodec](http://jm.wmzhe.com) 的解碼器更新包。
此腳本會自動下載解碼器並產生更新包。

某些可執行檔的原始程式碼已經被誤刪，因此只剩下可執行檔。
那些可執行檔是用 `BATCH` 編寫再轉換為可執行檔的。

此專案先前由 小斐@[2D-Gate](http://2d-gate.org) 維護。


# 使用方式

1. 先將專案內的 `bin` 資料夾加入[環境變數](http://openhome.cc/Gossip/JavaEssence/WhatPath.html) `PATH` 中
1. 按下 `Win+R` 以執行 `cmd`
1. 切換到專案的根目錄下 (`cd /d "blahblahblah\PureCodec-Patch"`)
1. 使用 `bash` 執行 `start.sh` 並等待一段時間 (`bash start.sh`)
1. 腳本便會生成類似 `PureCodec-Patch-v150713.exe` 的檔案


# 貢獻程式碼

Fork 專案後修改再 Pull Request 總是是被歡迎的。
