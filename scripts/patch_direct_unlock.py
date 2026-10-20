import os
import re

handler_path = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoPlayer$VideoHandler.smali"

with open(handler_path, "r", encoding="utf-8") as f:
    content = f.read()

target = """.method public resumeAdvance()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v0, v1, :cond_resume_start

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void

    :cond_resume_start
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->play()V

    return-void
.end method"""

replacement = """.method public resumeAdvance()V
    .locals 5

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v0, v1, :cond_resume_direct

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void

    :cond_resume_direct
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v0}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v0

    if-eqz v0, :cond_resume_play

    const-wide/32 v2, 0x1b7740

    invoke-virtual {v0, v2, v3}, Lcom/androradar/walls6/VideoStream;->seekTo(J)V

    :cond_resume_play
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->play()V

    return-void
.end method"""

norm_c = content.replace("\r\n", "\n")
norm_t = target.replace("\r\n", "\n")
norm_r = replacement.replace("\r\n", "\n")

if norm_t in norm_c:
    new_c = norm_c.replace(norm_t, norm_r, 1)
    if "\r\n" in content:
        new_c = new_c.replace("\n", "\r\n")
    with open(handler_path, "w", encoding="utf-8", newline="") as f:
        f.write(new_c)
    print("SUCCESS: Updated resumeAdvance in VideoPlayer$VideoHandler.smali")
else:
    print("ERROR: Target resumeAdvance not found!")
