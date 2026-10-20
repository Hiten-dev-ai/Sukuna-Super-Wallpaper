import os

def patch_file(filepath, target, replacement):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    norm_content = content.replace('\r\n', '\n')
    norm_target = target.replace('\r\n', '\n')
    norm_replacement = replacement.replace('\r\n', '\n')
    
    if norm_target in norm_content:
        new_content = norm_content.replace(norm_target, norm_replacement, 1)
        if '\r\n' in content:
            new_content = new_content.replace('\n', '\r\n')
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(new_content)
        print(f'SUCCESS: Patched {os.path.basename(filepath)}')
        return True
    else:
        print(f'ERROR: Target not found in {os.path.basename(filepath)}')
        return False

# 1. Patch LiveWallpaperService$WallpaperEngine.smali
path_engine = r'D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\LiveWallpaperService$WallpaperEngine.smali'

old_isDeviceLocked = """.method private isDeviceLocked()Z
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mKeyGuardManager:Landroid/app/KeyguardManager;

    invoke-virtual {v0}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mPowerManager:Landroid/os/PowerManager;

    invoke-virtual {v0}, Landroid/os/PowerManager;->isInteractive()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method"""

new_isDeviceLocked = """.method private isDeviceLocked()Z
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mKeyGuardManager:Landroid/app/KeyguardManager;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    invoke-virtual {v0}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z

    move-result v0

    return v0
.end method"""

patch_file(path_engine, old_isDeviceLocked, new_isDeviceLocked)

old_onVis = """.method public onVisibilityChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onResume()V

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->requestRender()V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onPause()V

    goto :goto_0
.end method"""

new_onVis = """.method public onVisibilityChanged(Z)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onResume()V

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->syncLockedState(Z)V

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->requestRender()V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onPause()V

    goto :goto_0
.end method"""

patch_file(path_engine, old_onVis, new_onVis)

# 2. Patch VideoStream.smali
path_stream = r'D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoStream.smali'

old_timeout = """    const-wide/16 v20, 0x0

    move-wide/from16 v0, v20

    invoke-virtual {v4, v15, v0, v1}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I"""

new_timeout = """    const-wide/16 v20, 0x2710

    move-wide/from16 v0, v20

    invoke-virtual {v4, v15, v0, v1}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I"""

patch_file(path_stream, old_timeout, new_timeout)
