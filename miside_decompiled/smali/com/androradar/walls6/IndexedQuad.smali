.class public Lcom/androradar/walls6/IndexedQuad;
.super Ljava/lang/Object;
.source "IndexedQuad.java"


# instance fields
.field private mIndexBufferHandle:I

.field private mVertexBufferHandle:I


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, -0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    iput v0, p0, Lcom/androradar/walls6/IndexedQuad;->mIndexBufferHandle:I

    return-void
.end method


# virtual methods
.method public clean()V
    .locals 4

    const/4 v3, 0x0

    iget v1, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    if-lez v1, :cond_0

    const/4 v1, 0x2

    new-array v0, v1, [I

    iget v1, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    aput v1, v0, v3

    const/4 v1, 0x1

    iget v2, p0, Lcom/androradar/walls6/IndexedQuad;->mIndexBufferHandle:I

    aput v2, v0, v1

    array-length v1, v0

    invoke-static {v1, v0, v3}, Landroid/opengl/GLES30;->glDeleteBuffers(I[II)V

    :cond_0
    return-void
.end method

.method public getIndexBufferHandle()I
    .locals 1

    iget v0, p0, Lcom/androradar/walls6/IndexedQuad;->mIndexBufferHandle:I

    return v0
.end method

.method public getVertexBufferHandle()I
    .locals 1

    iget v0, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    return v0
.end method

.method public init()V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/Utils$InvalidHandleException;
        }
    .end annotation

    const v12, 0x88e4

    const/4 v7, 0x2

    const v11, 0x8893

    const v10, 0x8892

    const/4 v9, 0x0

    new-array v0, v7, [I

    fill-array-data v0, :array_0

    invoke-static {v7, v0, v9}, Landroid/opengl/GLES30;->glGenBuffers(I[II)V

    aget v7, v0, v9

    const-string v8, "VertexBuffer"

    invoke-static {v7, v8}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v7

    iput v7, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    const/4 v7, 0x1

    aget v7, v0, v7

    const-string v8, "IndexBuffer"

    invoke-static {v7, v8}, Lcom/androradar/walls6/Utils;->verifyHandle(ILjava/lang/String;)I

    move-result v7

    iput v7, p0, Lcom/androradar/walls6/IndexedQuad;->mIndexBufferHandle:I

    const/16 v7, 0x14

    new-array v5, v7, [F

    fill-array-data v5, :array_1

    iget v7, p0, Lcom/androradar/walls6/IndexedQuad;->mVertexBufferHandle:I

    invoke-static {v10, v7}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    array-length v7, v5

    mul-int/lit8 v4, v7, 0x4

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    invoke-virtual {v6, v9}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {v10, v4, v6, v12}, Landroid/opengl/GLES30;->glBufferData(IILjava/nio/Buffer;I)V

    invoke-static {v10, v9}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    const/4 v7, 0x6

    new-array v2, v7, [S

    fill-array-data v2, :array_2

    iget v7, p0, Lcom/androradar/walls6/IndexedQuad;->mIndexBufferHandle:I

    invoke-static {v11, v7}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    array-length v7, v2

    mul-int/lit8 v1, v7, 0x2

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->asShortBuffer()Ljava/nio/ShortBuffer;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/nio/ShortBuffer;->put([S)Ljava/nio/ShortBuffer;

    invoke-virtual {v3, v9}, Ljava/nio/ShortBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {v11, v1, v3, v12}, Landroid/opengl/GLES30;->glBufferData(IILjava/nio/Buffer;I)V

    invoke-static {v11, v9}, Landroid/opengl/GLES30;->glBindBuffer(II)V

    return-void

    :array_0
    .array-data 4
        -0x1
        -0x1
    .end array-data

    :array_1
    .array-data 4
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        0x0
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        -0x40800000    # -1.0f
        0x0
        0x3f800000    # 1.0f
        0x0
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x0
        0x0
        0x0
    .end array-data

    :array_2
    .array-data 2
        0x0s
        0x1s
        0x2s
        0x0s
        0x2s
        0x3s
    .end array-data
.end method

.method public render()V
    .locals 4

    const/4 v0, 0x4

    const/4 v1, 0x6

    const/16 v2, 0x1403

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/GLES30;->glDrawElements(IIII)V

    return-void
.end method
