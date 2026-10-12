.class public Lcom/androradar/walls6/Shader;
.super Ljava/lang/Object;
.source "Shader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/Shader$ShaderCompilationException;
    }
.end annotation


# instance fields
.field private final mFragmentShaderCode:Ljava/lang/String;

.field protected mProgram:I

.field private mTransformLocation:I

.field private mVao:I

.field private final mVertexShaderCode:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation build Landroid/support/annotation/MainThread;
    .end annotation

    const/4 v0, -0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    iput v0, p0, Lcom/androradar/walls6/Shader;->mVao:I

    iput v0, p0, Lcom/androradar/walls6/Shader;->mTransformLocation:I

    iput-object p1, p0, Lcom/androradar/walls6/Shader;->mVertexShaderCode:Ljava/lang/String;

    iput-object p2, p0, Lcom/androradar/walls6/Shader;->mFragmentShaderCode:Ljava/lang/String;

    return-void
.end method

.method private compileShader(ILjava/lang/String;)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/Utils$InvalidHandleException;,
            Lcom/androradar/walls6/Shader$ShaderCompilationException;
        }
    .end annotation

    const/4 v4, 0x0

    invoke-static {p1}, Landroid/opengl/GLES30;->glCreateShader(I)I

    move-result v3

    invoke-static {v3, p2}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v1

    invoke-static {v1, p2}, Landroid/opengl/GLES30;->glShaderSource(ILjava/lang/String;)V

    invoke-static {v1}, Landroid/opengl/GLES30;->glCompileShader(I)V

    const/4 v3, 0x1

    new-array v2, v3, [I

    const/4 v3, -0x1

    aput v3, v2, v4

    const v3, 0x8b81

    invoke-static {v1, v3, v2, v4}, Landroid/opengl/GLES30;->glGetShaderiv(II[II)V

    aget v3, v2, v4

    if-nez v3, :cond_0

    invoke-static {v1}, Landroid/opengl/GLES30;->glGetShaderInfoLog(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    new-instance v3, Lcom/androradar/walls6/Shader$ShaderCompilationException;

    invoke-direct {v3, v0}, Lcom/androradar/walls6/Shader$ShaderCompilationException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_0
    return v1
.end method


# virtual methods
.method public bind([F)V
    .locals 3

    const/4 v2, 0x0

    iget v0, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glUseProgram(I)V

    iget v0, p0, Lcom/androradar/walls6/Shader;->mVao:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    iget v0, p0, Lcom/androradar/walls6/Shader;->mTransformLocation:I

    const/4 v1, 0x1

    invoke-static {v0, v1, v2, p1, v2}, Landroid/opengl/GLES30;->glUniformMatrix4fv(IIZ[FI)V

    return-void
.end method

.method public clean()V
    .locals 4

    const/4 v3, 0x0

    const/4 v2, -0x1

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    if-lez v1, :cond_0

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    iput v2, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    :cond_0
    iget v1, p0, Lcom/androradar/walls6/Shader;->mVao:I

    if-lez v1, :cond_1

    const/4 v1, 0x1

    new-array v0, v1, [I

    iget v1, p0, Lcom/androradar/walls6/Shader;->mVao:I

    aput v1, v0, v3

    array-length v1, v0

    invoke-static {v1, v0, v3}, Landroid/opengl/GLES30;->glDeleteVertexArrays(I[II)V

    iput v2, p0, Lcom/androradar/walls6/Shader;->mVao:I

    :cond_1
    iput v2, p0, Lcom/androradar/walls6/Shader;->mTransformLocation:I

    return-void
.end method

.method public init(Lcom/androradar/walls6/IndexedQuad;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/Utils$InvalidHandleException;,
            Lcom/androradar/walls6/Shader$ShaderCompilationException;
        }
    .end annotation

    const v9, 0x8892

    const/16 v2, 0x1406

    const/16 v4, 0x14

    const/4 v3, 0x0

    invoke-virtual {p0}, Lcom/androradar/walls6/Shader;->clean()V

    const v1, 0x8b31

    iget-object v5, p0, Lcom/androradar/walls6/Shader;->mVertexShaderCode:Ljava/lang/String;

    invoke-direct {p0, v1, v5}, Lcom/androradar/walls6/Shader;->compileShader(ILjava/lang/String;)I

    move-result v8

    const v1, 0x8b30

    iget-object v5, p0, Lcom/androradar/walls6/Shader;->mFragmentShaderCode:Ljava/lang/String;

    invoke-direct {p0, v1, v5}, Lcom/androradar/walls6/Shader;->compileShader(ILjava/lang/String;)I

    move-result v6

    invoke-static {}, Landroid/opengl/GLES30;->glCreateProgram()I

    move-result v1

    const-string v5, "Program"

    invoke-static {v1, v5}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1, v8}, Landroid/opengl/GLES30;->glAttachShader(II)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1, v6}, Landroid/opengl/GLES30;->glAttachShader(II)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES30;->glLinkProgram(I)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1, v8}, Landroid/opengl/GLES30;->glDetachShader(II)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1, v6}, Landroid/opengl/GLES30;->glDetachShader(II)V

    invoke-static {v8}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    invoke-static {v6}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES30;->glUseProgram(I)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    const-string v5, "uTransform"

    invoke-static {v1, v5}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    const-string v5, "uTransform"

    invoke-static {v1, v5}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/androradar/walls6/Shader;->mTransformLocation:I

    const/4 v1, 0x1

    new-array v7, v1, [I

    const/4 v1, -0x1

    aput v1, v7, v3

    array-length v1, v7

    invoke-static {v1, v7, v3}, Landroid/opengl/GLES30;->glGenVertexArrays(I[II)V

    aget v1, v7, v3

    const-string v5, "VAO"

    invoke-static {v1, v5}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/androradar/walls6/Shader;->mVao:I

    iget v1, p0, Lcom/androradar/walls6/Shader;->mVao:I

    invoke-static {v1}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    invoke-virtual {p1}, Lcom/androradar/walls6/IndexedQuad;->getVertexBufferHandle()I

    move-result v1

    invoke-static {v9, v1}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    const v1, 0x8893

    invoke-virtual {p1}, Lcom/androradar/walls6/IndexedQuad;->getIndexBufferHandle()I

    move-result v5

    invoke-static {v1, v5}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    const-string v5, "inPosition"

    invoke-static {v1, v5}, Landroid/opengl/GLES30;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v1

    const-string v5, "inPosition"

    invoke-static {v1, v5}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    invoke-static {v0}, Landroid/opengl/GLES30;->glEnableVertexAttribArray(I)V

    const/4 v1, 0x3

    move v5, v3

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES30;->glVertexAttribPointer(IIIZII)V

    iget v1, p0, Lcom/androradar/walls6/Shader;->mProgram:I

    const-string v5, "inUV"

    invoke-static {v1, v5}, Landroid/opengl/GLES30;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v1

    const-string v5, "inUV"

    invoke-static {v1, v5}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v0

    invoke-static {v0}, Landroid/opengl/GLES30;->glEnableVertexAttribArray(I)V

    const/4 v1, 0x2

    const/16 v5, 0xc

    invoke-static/range {v0 .. v5}, Landroid/opengl/GLES30;->glVertexAttribPointer(IIIZII)V

    invoke-static {v9, v3}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    invoke-static {v3}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    return-void
.end method

.method public unbind()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Landroid/opengl/GLES30;->glBindVertexArray(I)V

    return-void
.end method
