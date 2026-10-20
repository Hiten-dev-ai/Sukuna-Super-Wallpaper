.class Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;
.super Landroid/opengl/GLSurfaceView;
.source "LiveWallpaperService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "WallpaperGLSurfaceView"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;


# direct methods
.method public constructor <init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;Landroid/content/Context;)V
    .locals 1

    iput-object p1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-direct {p0, p2}, Landroid/opengl/GLSurfaceView;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->setEGLContextClientVersion(I)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->setPreserveEGLContextOnPause(Z)V

    return-void
.end method


# virtual methods
.method public getHolder()Landroid/view/SurfaceHolder;
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->getSurfaceHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    return-object v0
.end method

.method public onDestroy()V
    .locals 0

    invoke-super {p0}, Landroid/opengl/GLSurfaceView;->onDetachedFromWindow()V

    return-void
.end method

.method public onPause()V
    .locals 0
    invoke-super {p0}, Landroid/opengl/GLSurfaceView;->onPause()V
    return-void
.end method

.method public onResume()V
    .locals 0
    invoke-super {p0}, Landroid/opengl/GLSurfaceView;->onResume()V
    return-void
.end method
