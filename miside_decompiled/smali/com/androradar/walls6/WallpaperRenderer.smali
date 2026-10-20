.class public Lcom/androradar/walls6/WallpaperRenderer;
.super Ljava/lang/Object;
.source "WallpaperRenderer.java"

# interfaces
.implements Landroid/opengl/GLSurfaceView$Renderer;


# instance fields
.field private mHeight:I

.field private mPortrait:Z

.field private final mQuad:Lcom/androradar/walls6/IndexedQuad;

.field private mRotationChanged:Z

.field private final mSurfaceView:Landroid/opengl/GLSurfaceView;

.field private final mTransform:[F

.field private final mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

.field private final mVideoShader:Lcom/androradar/walls6/VideoShader;

.field private mWidth:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V
    .locals 6
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v1, 0x1

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mWidth:I

    iput v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mHeight:I

    iput-boolean v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mPortrait:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mRotationChanged:Z

    const/16 v0, 0x10

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mTransform:[F

    iput-object p2, p0, Lcom/androradar/walls6/WallpaperRenderer;->mSurfaceView:Landroid/opengl/GLSurfaceView;

    new-instance v0, Lcom/androradar/walls6/IndexedQuad;

    invoke-direct {v0}, Lcom/androradar/walls6/IndexedQuad;-><init>()V

    iput-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    new-instance v0, Lcom/androradar/walls6/VideoShader;

    invoke-direct {v0, p1}, Lcom/androradar/walls6/VideoShader;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mVideoShader:Lcom/androradar/walls6/VideoShader;

    new-instance v0, Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    const v2, 0x7f050001

    invoke-virtual {p1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/androradar/walls6/WallpaperRenderer;->mSurfaceView:Landroid/opengl/GLSurfaceView;

    iget-object v4, p0, Lcom/androradar/walls6/WallpaperRenderer;->mVideoShader:Lcom/androradar/walls6/VideoShader;

    iget-object v5, p0, Lcom/androradar/walls6/WallpaperRenderer;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    invoke-direct/range {v0 .. v5}, Lcom/androradar/walls6/VideoPlayer;-><init>(Landroid/content/res/AssetManager;Ljava/lang/String;Landroid/opengl/GLSurfaceView;Lcom/androradar/walls6/VideoShader;Lcom/androradar/walls6/IndexedQuad;)V

    iput-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    return-void
.end method

.method private setupResources()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v3, 0x0

    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->clean()V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    invoke-virtual {v1}, Lcom/androradar/walls6/IndexedQuad;->init()V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mVideoShader:Lcom/androradar/walls6/VideoShader;

    iget-object v2, p0, Lcom/androradar/walls6/WallpaperRenderer;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    invoke-virtual {v1, v2}, Lcom/androradar/walls6/VideoShader;->init(Lcom/androradar/walls6/IndexedQuad;)V

    const/4 v1, 0x1

    new-array v0, v1, [I

    const/4 v1, -0x1

    aput v1, v0, v3

    array-length v1, v0

    invoke-static {v1, v0, v3}, Landroid/opengl/GLES30;->glGenTextures(I[II)V

    const v1, 0x84c1

    invoke-static {v1}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    aget v2, v0, v3

    invoke-virtual {v1, v2}, Lcom/androradar/walls6/VideoPlayer;->init(I)V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mSurfaceView:Landroid/opengl/GLSurfaceView;

    invoke-virtual {v1, v3}, Landroid/opengl/GLSurfaceView;->setRenderMode(I)V

    return-void
.end method


# virtual methods
.method public clean()V
    .locals 3

    const/4 v2, 0x0

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mQuad:Lcom/androradar/walls6/IndexedQuad;

    invoke-virtual {v1}, Lcom/androradar/walls6/IndexedQuad;->clean()V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mVideoShader:Lcom/androradar/walls6/VideoShader;

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoShader;->clean()V

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoPlayer;->reset()V

    const/4 v1, 0x1

    new-array v0, v1, [I

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoPlayer;->getTextureHandle()I

    move-result v1

    aput v1, v0, v2

    array-length v1, v0

    invoke-static {v1, v0, v2}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    :cond_0
    return-void
.end method

.method public onDrawFrame(Ljavax/microedition/khronos/opengles/GL10;)V
    .locals 4

    const/4 v3, 0x0

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->update()V

    const/16 v0, 0x4000

    invoke-static {v0}, Landroid/opengl/GLES30;->glClear(I)V

    const/16 v0, 0xb44

    invoke-static {v0}, Landroid/opengl/GLES30;->glDisable(I)V

    const/16 v0, 0xb71

    invoke-static {v0}, Landroid/opengl/GLES30;->glDisable(I)V

    const/16 v0, 0xbe2

    invoke-static {v0}, Landroid/opengl/GLES30;->glDisable(I)V

    iget v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mWidth:I

    iget v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mHeight:I

    invoke-static {v2, v2, v0, v1}, Landroid/opengl/GLES30;->glViewport(IIII)V

    iget-boolean v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mRotationChanged:Z

    if-eqz v0, :cond_0

    iput-boolean v2, p0, Lcom/androradar/walls6/WallpaperRenderer;->mRotationChanged:Z

    iget-boolean v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mPortrait:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mTransform:[F

    invoke-static {v0, v2}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mTransform:[F

    invoke-virtual {v0, v1}, Lcom/androradar/walls6/VideoPlayer;->render([F)V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mTransform:[F

    const/high16 v1, -0x3d4c0000    # -90.0f

    invoke-static {v0, v2, v3, v3, v1}, Landroid/opengl/Matrix;->setRotateEulerM([FIFFF)V

    goto :goto_0
.end method

.method public onLocked(Z)V
    .locals 1
    if-eqz p1, :visible_home
    invoke-virtual {p0}, Lcom/androradar/walls6/WallpaperRenderer;->onScreenOn()V
    return-void
    :visible_home
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;
    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->playToHome()V
    return-void
.end method

.method public onScreenOn()V
    .locals 1
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->playToLock()V

    return-void
.end method

.method public onUnlocked()V
    .locals 1
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;
    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->restartHome()V
    return-void
.end method

.method public onScreenOff()V
    .locals 1
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->stop()V

    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->prepare()V

    return-void
.end method

.method public onSurfaceChanged(Ljavax/microedition/khronos/opengles/GL10;II)V
    .locals 3

    const/4 v1, 0x1

    iput p2, p0, Lcom/androradar/walls6/WallpaperRenderer;->mWidth:I

    iput p3, p0, Lcom/androradar/walls6/WallpaperRenderer;->mHeight:I

    if-ge p2, p3, :cond_1

    move v0, v1

    :goto_0
    iget-boolean v2, p0, Lcom/androradar/walls6/WallpaperRenderer;->mPortrait:Z

    if-eq v2, v0, :cond_0

    iput-boolean v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mPortrait:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mRotationChanged:Z

    iget-object v1, p0, Lcom/androradar/walls6/WallpaperRenderer;->mSurfaceView:Landroid/opengl/GLSurfaceView;

    invoke-virtual {v1}, Landroid/opengl/GLSurfaceView;->requestRender()V

    :cond_0
    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onSurfaceCreated(Ljavax/microedition/khronos/opengles/GL10;Ljavax/microedition/khronos/egl/EGLConfig;)V
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lcom/androradar/walls6/WallpaperRenderer;->setupResources()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public releasePlayer()V
    .locals 1
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;
    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->reset()V
    return-void
.end method

.method public onHidden()V
    .locals 1
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;
    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->onHidden()V
    return-void
.end method

.method public onVisible()V
    .locals 1
    iget-object v0, p0, Lcom/androradar/walls6/WallpaperRenderer;->mUnlockVideo:Lcom/androradar/walls6/VideoPlayer;
    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer;->onVisible()V
    return-void
.end method
