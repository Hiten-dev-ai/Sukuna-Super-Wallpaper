import re

def patch_file(path, old_pattern, new_content):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Normalize CRLF/LF for matching
    newline = '\r\n' if '\r\n' in content else '\n'
    normalized_content = content.replace('\r\n', '\n')
    normalized_old = old_pattern.replace('\r\n', '\n')
    normalized_new = new_content.replace('\r\n', '\n')
    
    if normalized_old not in normalized_content:
        raise ValueError(f"Pattern not found in {path}:\n{old_pattern[:100]}...")
    
    patched = normalized_content.replace(normalized_old, normalized_new, 1)
    if newline == '\r\n':
        patched = patched.replace('\n', '\r\n')
        
    with open(path, 'w', encoding='utf-8', newline='') as f:
        f.write(patched)
    print(f"Successfully patched {path}")

# 1. Patch LiveWallpaperService$WallpaperEngine.smali
# Remove forced syncLockedState from onVisibilityChanged
path_engine = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\LiveWallpaperService$WallpaperEngine.smali"
old_vis = """.method public onVisibilityChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onResume()V

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->syncLockedState(Z)V

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->requestRender()V"""

new_vis = """.method public onVisibilityChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onResume()V

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->requestRender()V"""

patch_file(path_engine, old_vis, new_vis)

# 2. Patch WallpaperRenderer.smali
# When locked, show onScreenOn() instead of shutting off via onScreenOff()
path_renderer = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\WallpaperRenderer.smali"
old_locked = """.method public onLocked(Z)V
    .locals 0
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->onScreenOff()V

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->onUnlocked()V

    return-void
.end method"""

new_locked = """.method public onLocked(Z)V
    .locals 0
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->onScreenOn()V

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->onUnlocked()V

    return-void
.end method"""

patch_file(path_renderer, old_locked, new_locked)

# 3. Patch VideoPlayer$VideoHandler.smali
# Clear conflicting messages when play() and stop() are called
path_handler = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoPlayer$VideoHandler.smali"
old_handler_play = """.method public play()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method"""

new_handler_play = """.method public play()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method"""

patch_file(path_handler, old_handler_play, new_handler_play)

old_handler_stop = """.method public stop()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method"""

new_handler_stop = """.method public stop()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method"""

patch_file(path_handler, old_handler_stop, new_handler_stop)

# 4. Patch VideoPlayer.smali
# In playToHome(), ensure play() is called so that if stream was stopped, it starts cleanly
path_player = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoPlayer.smali"
old_home = """.method public declared-synchronized playToHome()V
    .locals 4
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    if-eqz v0, :cond_0

    const-wide/16 v2, -0x1

    invoke-virtual {v0, v2, v3}, Lcom/androradar/walls6/VideoStream;->setPauseTimeUs(J)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoStream;->resetStartTime()V

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->resumeAdvance()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void"""

new_home = """.method public declared-synchronized playToHome()V
    .locals 4
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    if-eqz v0, :cond_0

    const-wide/16 v2, -0x1

    invoke-virtual {v0, v2, v3}, Lcom/androradar/walls6/VideoStream;->setPauseTimeUs(J)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoStream;->resetStartTime()V

    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer;->play()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void"""

patch_file(path_player, old_home, new_home)

print("All patches applied successfully!")
