.class public Lcom/androradar/walls6/VideoShader;
.super Lcom/androradar/walls6/Shader;
.source "VideoShader.java"


# static fields
.field private static final BACKUP_BITMAP_NAME:Ljava/lang/String; = "backup.jpg"

.field private static final sBackupTransform:[F


# instance fields
.field private mBackupTextureHandle:I

.field private mBackupTextureLocation:I

.field private final mContext:Landroid/content/Context;

.field private mCrossFadeLocation:I

.field private mTextureLocation:I

.field private mUseBackup:Z

.field private mUvTransformLocation:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    const/4 v2, 0x0

    const/16 v0, 0x10

    new-array v0, v0, [F

    sput-object v0, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    sget-object v0, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    invoke-static {v0, v3}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    sget-object v0, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    const/high16 v1, -0x41000000    # -0.5f

    invoke-static {v0, v3, v2, v1, v2}, Landroid/opengl/Matrix;->translateM([FIFFF)V

    sget-object v0, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    const/high16 v1, -0x40800000    # -1.0f

    invoke-static {v0, v3, v4, v1, v4}, Landroid/opengl/Matrix;->scaleM([FIFFF)V

    sget-object v0, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    const/high16 v1, 0x3f000000    # 0.5f

    invoke-static {v0, v3, v2, v1, v2}, Landroid/opengl/Matrix;->translateM([FIFFF)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const v0, 0x7f040001

    invoke-static {p1, v0}, Lcom/androradar/walls6/Utils;->loadStringFromAssetFile(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    const/high16 v1, 0x7f040000

    invoke-static {p1, v1}, Lcom/androradar/walls6/Utils;->loadStringFromAssetFile(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/androradar/walls6/Shader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, -0x1

    iput v0, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    iput-object p1, p0, Lcom/androradar/walls6/VideoShader;->mContext:Landroid/content/Context;

    return-void
.end method

.method private activateBackup()V
    .locals 2

    invoke-direct {p0}, Lcom/androradar/walls6/VideoShader;->initBackup()V

    const/16 v1, 0x10

    new-array v0, v1, [F

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    invoke-virtual {p0, v0}, Lcom/androradar/walls6/VideoShader;->setUvTransform([F)V

    return-void
.end method

.method private cleanBackup()V
    .locals 5

    const/4 v4, 0x1

    const/4 v3, 0x0

    const/4 v2, -0x1

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    if-le v0, v2, :cond_0

    new-array v0, v4, [I

    iget v1, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    aput v1, v0, v3

    invoke-static {v4, v0, v3}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    iput v2, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    :cond_0
    return-void
.end method

.method private deactivateBackup()V
    .locals 0

    return-void
.end method

.method private initBackup()V
    .locals 9

    const/16 v8, 0x2600

    const/4 v7, -0x1

    const/16 v6, 0xde1

    const/4 v5, 0x0

    iget v3, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    if-le v3, v7, :cond_0

    :goto_0
    return-void

    :cond_0
    :try_start_0
    iget-object v3, p0, Lcom/androradar/walls6/VideoShader;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    const-string v4, "backup.jpg"

    invoke-static {v3, v4}, Lcom/androradar/walls6/Utils;->loadTexture(Landroid/content/res/AssetManager;Ljava/lang/String;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Lcom/androradar/walls6/Utils$BitmapNotLoadedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    const/4 v3, 0x1

    new-array v2, v3, [I

    aput v7, v2, v5

    array-length v3, v2

    invoke-static {v3, v2, v5}, Landroid/opengl/GLES30;->glGenTextures(I[II)V

    aget v3, v2, v5

    iput v3, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    const v3, 0x84c0

    invoke-static {v3}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    iget v3, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    invoke-static {v6, v3}, Landroid/opengl/GLES30;->glBindTexture(II)V

    const/16 v3, 0x2801

    invoke-static {v6, v3, v8}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    const/16 v3, 0x2800

    invoke-static {v6, v3, v8}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    invoke-static {v6, v5, v0, v5}, Landroid/opengl/GLUtils;->texImage2D(IILandroid/graphics/Bitmap;I)V

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_0
.end method


# virtual methods
.method public declared-synchronized bind([F)V
    .locals 5

    monitor-enter p0

    :try_start_0
    invoke-super {p0, p1}, Lcom/androradar/walls6/Shader;->bind([F)V

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mTextureLocation:I

    const/4 v1, 0x1

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glUniform1i(II)V

    iget v1, p0, Lcom/androradar/walls6/VideoShader;->mCrossFadeLocation:I

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoShader;->mUseBackup:Z

    if-eqz v0, :cond_1

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_0
    invoke-static {v1, v0}, Landroid/opengl/GLES30;->glUniform1f(IF)V

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoShader;->mUseBackup:Z

    if-eqz v0, :cond_0

    const v0, 0x84c0

    invoke-static {v0}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    const/16 v0, 0xde1

    iget v1, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureHandle:I

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glBindTexture(II)V

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureLocation:I

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glUniform1i(II)V

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mUvTransformLocation:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    sget-object v3, Lcom/androradar/walls6/VideoShader;->sBackupTransform:[F

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Landroid/opengl/GLES30;->glUniformMatrix4fv(IIZ[FI)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized clean()V
    .locals 1

    monitor-enter p0

    :try_start_0
    invoke-super {p0}, Lcom/androradar/walls6/Shader;->clean()V

    invoke-direct {p0}, Lcom/androradar/walls6/VideoShader;->cleanBackup()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public init(Lcom/androradar/walls6/IndexedQuad;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/Utils$InvalidHandleException;,
            Lcom/androradar/walls6/Shader$ShaderCompilationException;
        }
    .end annotation

    invoke-super {p0, p1}, Lcom/androradar/walls6/Shader;->init(Lcom/androradar/walls6/IndexedQuad;)V

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mProgram:I

    const-string v1, "uTexture"

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    const-string v1, "inTexture"

    invoke-static {v0, v1}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/androradar/walls6/VideoShader;->mTextureLocation:I

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mProgram:I

    const-string v1, "uUvTransform"

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    const-string v1, "uUvTransform"

    invoke-static {v0, v1}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/androradar/walls6/VideoShader;->mUvTransformLocation:I

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mProgram:I

    const-string v1, "uCrossFade"

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    const-string v1, "uCrossFade"

    invoke-static {v0, v1}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/androradar/walls6/VideoShader;->mCrossFadeLocation:I

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mProgram:I

    const-string v1, "uBackupTexture"

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    const-string v1, "uBackupTexture"

    invoke-static {v0, v1}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/androradar/walls6/VideoShader;->mBackupTextureLocation:I

    return-void
.end method

.method public setUvTransform([F)V
    .locals 3

    const/4 v2, 0x0

    iget v0, p0, Lcom/androradar/walls6/VideoShader;->mUvTransformLocation:I

    const/4 v1, 0x1

    invoke-static {v0, v1, v2, p1, v2}, Landroid/opengl/GLES30;->glUniformMatrix4fv(IIZ[FI)V

    return-void
.end method

.method public useBackup(Z)V
    .locals 1

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoShader;->mUseBackup:Z

    if-eq p1, v0, :cond_0

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/androradar/walls6/VideoShader;->activateBackup()V

    :goto_0
    iput-boolean p1, p0, Lcom/androradar/walls6/VideoShader;->mUseBackup:Z

    :cond_0
    return-void

    :cond_1
    invoke-direct {p0}, Lcom/androradar/walls6/VideoShader;->deactivateBackup()V

    goto :goto_0
.end method
