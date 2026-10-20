.class Lcom/androradar/walls6/VideoPlayer;
.super Lcom/androradar/walls6/Renderable;
.source "VideoPlayer.java"

# interfaces
.implements Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/VideoPlayer$VideoHandler;,
        Lcom/androradar/walls6/VideoPlayer$StreamCondition;,
        Lcom/androradar/walls6/VideoPlayer$StreamState;
    }
.end annotation


# static fields
.field private static final DEBUG:Z


# instance fields
.field private final mAssetFile:Ljava/lang/String;

.field private final mAssetManager:Landroid/content/res/AssetManager;

.field private mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

.field private volatile mIsPlaying:Z

.field private final mLogTag:Ljava/lang/String;

.field private volatile mNewFrameAvailable:Z

.field private volatile mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

.field private mSurface:Landroid/view/Surface;

.field private mSurfaceTexture:Landroid/graphics/SurfaceTexture;

.field private mTextureHandle:I

.field private final mUvTransform:[F

.field private mVideoStream:Lcom/androradar/walls6/VideoStream;

.field private final mView:Landroid/opengl/GLSurfaceView;


# direct methods
.method public constructor <init>(Landroid/content/res/AssetManager;Ljava/lang/String;Landroid/opengl/GLSurfaceView;Lcom/androradar/walls6/VideoShader;Lcom/androradar/walls6/IndexedQuad;)V
    .locals 3
    .param p3    # Landroid/opengl/GLSurfaceView;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p4, p5}, Lcom/androradar/walls6/Renderable;-><init>(Lcom/androradar/walls6/Shader;Lcom/androradar/walls6/IndexedQuad;)V

    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iput-object v2, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoPlayer;->mNewFrameAvailable:Z

    const/16 v0, 0x10

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mUvTransform:[F

    iput-object v2, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VideoPlayer("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mLogTag:Ljava/lang/String;

    iput-object p1, p0, Lcom/androradar/walls6/VideoPlayer;->mAssetManager:Landroid/content/res/AssetManager;

    iput-object p2, p0, Lcom/androradar/walls6/VideoPlayer;->mAssetFile:Ljava/lang/String;

    iput-object p3, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    return-void
.end method

.method static synthetic access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    return-object v0
.end method

.method static synthetic access$100(Lcom/androradar/walls6/VideoPlayer;)V
    .locals 0

    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer;->onPlayingComplete()V

    return-void
.end method

.method static synthetic access$200(Lcom/androradar/walls6/VideoPlayer;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/androradar/walls6/VideoPlayer;->onResourcesLost(Z)V

    return-void
.end method

.method private declared-synchronized onPlayingComplete()V
    .locals 1

    monitor-enter p0

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private declared-synchronized onResourcesLost(Z)V
    .locals 1

    monitor-enter p0

    :try_start_0
    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->NEEDS_RESTART:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    invoke-virtual {v0}, Landroid/opengl/GLSurfaceView;->requestRender()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private resetStream()Z
    .locals 1

    iget v0, p0, Lcom/androradar/walls6/VideoPlayer;->mTextureHandle:I

    invoke-virtual {p0, v0}, Lcom/androradar/walls6/VideoPlayer;->init(I)V

    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    invoke-virtual {v0}, Landroid/opengl/GLSurfaceView;->requestRender()V

    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method public declared-synchronized bind([F)V
    .locals 3

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mShader:Lcom/androradar/walls6/Shader;

    check-cast v0, Lcom/androradar/walls6/VideoShader;

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer;->mUvTransform:[F

    invoke-virtual {v0, v1}, Lcom/androradar/walls6/VideoShader;->setUvTransform([F)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mShader:Lcom/androradar/walls6/Shader;

    check-cast v0, Lcom/androradar/walls6/VideoShader;

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    sget-object v2, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    if-eq v1, v2, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {v0, v1}, Lcom/androradar/walls6/VideoShader;->useBackup(Z)V

    invoke-super {p0, p1}, Lcom/androradar/walls6/Renderable;->bind([F)V

    const v0, 0x84c1

    invoke-static {v0}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    const v0, 0x8d65

    iget v1, p0, Lcom/androradar/walls6/VideoPlayer;->mTextureHandle:I

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glBindTexture(II)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getTextureHandle()I
    .locals 1

    iget v0, p0, Lcom/androradar/walls6/VideoPlayer;->mTextureHandle:I

    return v0
.end method

.method public declared-synchronized init(I)V
    .locals 4

    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer;->reset()V

    iput p1, p0, Lcom/androradar/walls6/VideoPlayer;->mTextureHandle:I

    new-instance v0, Landroid/graphics/SurfaceTexture;

    invoke-direct {v0, p1}, Landroid/graphics/SurfaceTexture;-><init>(I)V

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0, p0}, Landroid/graphics/SurfaceTexture;->setOnFrameAvailableListener(Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;)V

    new-instance v0, Landroid/view/Surface;

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-direct {v0, v1}, Landroid/view/Surface;-><init>(Landroid/graphics/SurfaceTexture;)V

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurface:Landroid/view/Surface;

    new-instance v0, Lcom/androradar/walls6/VideoStream;

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer;->mAssetFile:Ljava/lang/String;

    iget-object v2, p0, Lcom/androradar/walls6/VideoPlayer;->mAssetManager:Landroid/content/res/AssetManager;

    iget-object v3, p0, Lcom/androradar/walls6/VideoPlayer;->mSurface:Landroid/view/Surface;

    invoke-direct {v0, v1, v2, v3}, Lcom/androradar/walls6/VideoStream;-><init>(Ljava/lang/String;Landroid/content/res/AssetManager;Landroid/view/Surface;)V

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    new-instance v0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-direct {v0, p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;-><init>(Lcom/androradar/walls6/VideoPlayer;)V

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->rewind()V

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->play()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized onFrameAvailable(Landroid/graphics/SurfaceTexture;)V
    .locals 1

    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mNewFrameAvailable:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    invoke-virtual {v0}, Landroid/opengl/GLSurfaceView;->requestRender()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized play()V
    .locals 2
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    if-eq v0, v1, :cond_1

    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer;->resetStream()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->play()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized playToLock()V
    .locals 4
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    if-eqz v0, :cond_0

    const-wide/32 v2, 0x100590

    invoke-virtual {v0, v2, v3}, Lcom/androradar/walls6/VideoStream;->setPauseTimeUs(J)V

    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer;->play()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized playToHome()V
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

    :cond_1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized prepare()V
    .locals 1
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->rewind()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized reset()V
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->dispose()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0}, Landroid/graphics/SurfaceTexture;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    :cond_1
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurface:Landroid/view/Surface;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurface:Landroid/view/Surface;

    invoke-virtual {v0}, Landroid/view/Surface;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    :cond_2
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoStream;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mVideoStream:Lcom/androradar/walls6/VideoStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_3
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized stop()V
    .locals 2
    .annotation build Landroid/support/annotation/AnyThread;
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mHandler:Lcom/androradar/walls6/VideoPlayer$VideoHandler;

    invoke-virtual {v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->stop()V

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized update()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mNewFrameAvailable:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mNewFrameAvailable:Z

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0}, Landroid/graphics/SurfaceTexture;->updateTexImage()V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mSurfaceTexture:Landroid/graphics/SurfaceTexture;

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer;->mUvTransform:[F

    invoke-virtual {v0, v1}, Landroid/graphics/SurfaceTexture;->getTransformMatrix([F)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mView:Landroid/opengl/GLSurfaceView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/opengl/GLSurfaceView;->setRenderMode(I)V

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer;->mStreamCondition:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamCondition;->FINE:Lcom/androradar/walls6/VideoPlayer$StreamCondition;

    if-eq v0, v1, :cond_1

    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer;->resetStream()Z

    move-result v0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer;->mIsPlaying:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
