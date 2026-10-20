.class public Lcom/androradar/walls6/VideoStream;
.super Ljava/lang/Object;
.source "VideoStream.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;,
        Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;,
        Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;
    }
.end annotation


# static fields
.field private static final DEBUG:Z


# instance fields
.field private final mAssetFile:Ljava/lang/String;

.field private final mAssetManager:Landroid/content/res/AssetManager;

.field private mConfigured:Z

.field private mInEos:Z

.field private final mLogTag:Ljava/lang/String;

.field private mMediaCodec:Landroid/media/MediaCodec;

.field private mMediaExtractor:Landroid/media/MediaExtractor;

.field private mMediaFormat:Landroid/media/MediaFormat;

.field private mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;

.field private mOutEos:Z

.field private mStartTimeNanos:J

.field private mRenderFromUs:J

.field private mPauseTimeUs:J

.field private mTargetReached:Z

.field private final mSurface:Landroid/view/Surface;


# direct methods
.method public constructor <init>(Ljava/lang/String;Landroid/content/res/AssetManager;Landroid/view/Surface;)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoStream;->mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    iput-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mPauseTimeUs:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VideoStream("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/androradar/walls6/VideoStream;->mLogTag:Ljava/lang/String;

    iput-object p2, p0, Lcom/androradar/walls6/VideoStream;->mAssetManager:Landroid/content/res/AssetManager;

    iput-object p1, p0, Lcom/androradar/walls6/VideoStream;->mAssetFile:Ljava/lang/String;

    iput-object p3, p0, Lcom/androradar/walls6/VideoStream;->mSurface:Landroid/view/Surface;

    return-void
.end method

.method private configure()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;,
            Ljava/io/IOException;,
            Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;
        }
    .end annotation

    iget-boolean v2, p0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z

    if-nez v2, :cond_1

    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mAssetManager:Landroid/content/res/AssetManager;

    iget-object v3, p0, Lcom/androradar/walls6/VideoStream;->mAssetFile:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v1

    new-instance v2, Landroid/media/MediaExtractor;

    invoke-direct {v2}, Landroid/media/MediaExtractor;-><init>()V

    iput-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v2, v1}, Landroid/media/MediaExtractor;->setDataSource(Landroid/content/res/AssetFileDescriptor;)V

    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->close()V

    invoke-direct {p0}, Lcom/androradar/walls6/VideoStream;->createMediaCodec()Landroid/media/MediaCodec;

    move-result-object v2

    iput-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v2}, Landroid/media/MediaExtractor;->release()V

    new-instance v2, Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "File not a video: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mAssetFile:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    iget-object v3, p0, Lcom/androradar/walls6/VideoStream;->mMediaFormat:Landroid/media/MediaFormat;

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mSurface:Landroid/view/Surface;

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    invoke-virtual {v2}, Landroid/media/MediaCodec;->start()V

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Landroid/media/MediaCodec$CryptoException; {:try_start_0 .. :try_end_0} :catch_1

    :cond_1
    return-void

    :catch_0
    move-exception v0

    :goto_0
    iget-object v2, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    invoke-virtual {v2}, Landroid/media/MediaCodec;->release()V

    new-instance v2, Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;

    const-string v3, "Codec could not be configured."

    invoke-direct {v2, v3, v0}, Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0
.end method

.method private createMediaCodec()Landroid/media/MediaCodec;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v4}, Landroid/media/MediaExtractor;->getTrackCount()I

    move-result v2

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v4, v0}, Landroid/media/MediaExtractor;->getTrackFormat(I)Landroid/media/MediaFormat;

    move-result-object v4

    iput-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaFormat:Landroid/media/MediaFormat;

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaFormat:Landroid/media/MediaFormat;

    const-string v5, "mime"

    invoke-virtual {v4, v5}, Landroid/media/MediaFormat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v4}, Landroid/media/MediaExtractor;->release()V

    :cond_0
    :goto_1
    return-object v3

    :cond_1
    const-string v4, "video/"

    invoke-virtual {v1, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v3, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v3, v0}, Landroid/media/MediaExtractor;->selectTrack(I)V

    invoke-static {v1}, Landroid/media/MediaCodec;->createDecoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v3

    goto :goto_1

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method


# virtual methods
.method public advance()Z
    .locals 24

    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z

    if-nez v4, :cond_0

    const/4 v4, 0x0

    :goto_0
    return v4

    :cond_0
    :try_start_0
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    if-nez v4, :cond_2

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    const-wide/16 v20, 0x7d0

    move-wide/from16 v0, v20

    invoke-virtual {v4, v0, v1}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v5

    if-ltz v5, :cond_2

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    invoke-virtual {v4, v5}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    if-eqz v11, :cond_2

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    const/4 v6, 0x0

    invoke-virtual {v4, v11, v6}, Landroid/media/MediaExtractor;->readSampleData(Ljava/nio/ByteBuffer;I)I

    move-result v7

    if-gez v7, :cond_1

    const/4 v7, 0x0

    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v4}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v8

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    const/4 v6, 0x0

    move-object/from16 v0, p0

    iget-boolean v10, v0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    if-eqz v10, :cond_6

    const/4 v10, 0x4

    :goto_1
    invoke-virtual/range {v4 .. v10}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    invoke-virtual {v4}, Landroid/media/MediaExtractor;->advance()Z

    :cond_2
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    if-nez v4, :cond_8

    new-instance v15, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v15}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    const-wide/16 v20, 0x2710

    move-wide/from16 v0, v20

    invoke-virtual {v4, v15, v0, v1}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v18

    if-ltz v18, :cond_7

    iget v4, v15, Landroid/media/MediaCodec$BufferInfo;->flags:I

    and-int/lit8 v4, v4, 0x4

    const/4 v6, 0x4

    if-ne v4, v6, :cond_3

    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    :cond_3
    move-object/from16 v4, p0
    iget-wide v6, v4, Lcom/androradar/walls6/VideoStream;->mRenderFromUs:J
    iget-wide v8, v15, Landroid/media/MediaCodec$BufferInfo;->presentationTimeUs:J
    cmp-long v6, v8, v6
    if-gez v6, :render_sample
    iget-object v4, v4, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;
    move/from16 v0, v18
    const/4 v1, 0x0
    invoke-virtual {v4, v0, v1}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V
    const/4 v4, 0x0
    goto/16 :goto_0
    :render_sample
    iget-wide v0, v15, Landroid/media/MediaCodec$BufferInfo;->presentationTimeUs:J

    move-wide/from16 v20, v0

    const-wide/16 v22, 0x3e8

    mul-long v16, v20, v22

    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    move-wide/from16 v20, v0

    const-wide/16 v22, 0x0

    cmp-long v4, v20, v22

    if-gez v4, :cond_4

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v20

    sub-long v20, v20, v16

    move-wide/from16 v0, v20

    move-object/from16 v2, p0

    iput-wide v0, v2, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    :cond_4
    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    move-wide/from16 v20, v0

    add-long v20, v20, v16

    invoke-static {}, Ljava/lang/System;->nanoTime()J
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v22

    sub-long v12, v20, v22

    const-wide/16 v20, 0x0

    cmp-long v4, v12, v20

    if-lez v4, :cond_5

    const-wide/32 v20, 0xf4240

    :try_start_1
    div-long v20, v12, v20

    long-to-int v4, v12

    const v6, 0xf4240

    rem-int/2addr v4, v6

    move-wide/from16 v0, v20

    invoke-static {v0, v1, v4}, Ljava/lang/Thread;->sleep(JI)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0

    :cond_5
    :goto_2
    :try_start_2
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    move/from16 v0, v18

    move-wide/from16 v1, v16

    invoke-virtual {v4, v0, v1, v2}, Landroid/media/MediaCodec;->releaseOutputBuffer(IJ)V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0

    move-object/from16 v4, p0

    iget-wide v6, v4, Lcom/androradar/walls6/VideoStream;->mPauseTimeUs:J

    const-wide/16 v8, 0x0

    cmp-long v8, v6, v8

    if-lez v8, :cond_check_target_done

    iget-wide v8, v15, Landroid/media/MediaCodec$BufferInfo;->presentationTimeUs:J

    cmp-long v6, v8, v6

    if-ltz v6, :cond_check_target_done

    const/4 v6, 0x1

    iput-boolean v6, v4, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    :cond_check_target_done
    const/4 v4, 0x1

    goto/16 :goto_0

    :cond_6
    const/4 v10, 0x0

    goto/16 :goto_1

    :cond_7
    const/4 v4, -0x2

    move/from16 v0, v18

    if-ne v0, v4, :cond_9

    :cond_8
    :goto_3
    const/4 v4, 0x0

    goto/16 :goto_0

    :cond_9
    const/4 v4, -0x1

    move/from16 v0, v18

    if-ne v0, v4, :cond_8

    goto :goto_3

    :catch_0
    move-exception v14

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;

    if-eqz v4, :cond_a

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/androradar/walls6/VideoStream;->mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;

    invoke-interface {v4}, Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;->onStreamResourcesLost()V

    :cond_a
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    const-wide/16 v20, -0x1

    move-wide/from16 v0, v20

    move-object/from16 v2, p0

    iput-wide v0, v2, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    goto :goto_3

    :catch_1
    move-exception v4

    goto :goto_2
.end method

.method public hasRenderedOneFrame()Z
    .locals 4

    iget-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public reachedEndOfStream()Z
    .locals 1

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public release()V
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    :try_start_rel_codec
    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V
    :try_end_rel_codec
    .catch Ljava/lang/Exception; {:try_start_rel_codec .. :try_end_rel_codec} :catch_rel_codec

    :catch_rel_codec
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    if-eqz v0, :cond_1

    :try_start_rel_ext
    invoke-virtual {v0}, Landroid/media/MediaExtractor;->release()V
    :try_end_rel_ext
    .catch Ljava/lang/Exception; {:try_start_rel_ext .. :try_end_rel_ext} :catch_rel_ext

    :catch_rel_ext
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    :cond_1
    return-void
.end method

.method public rewind()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;,
            Ljava/io/IOException;,
            Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;
        }
    .end annotation

    invoke-direct {p0}, Lcom/androradar/walls6/VideoStream;->configure()V

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    const-wide/16 v2, 0x0

    const/4 v1, 0x1

    invoke-virtual {v0, v2, v3, v1}, Landroid/media/MediaExtractor;->seekTo(JI)V

    :try_start_flush
    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    invoke-virtual {v0}, Landroid/media/MediaCodec;->flush()V
    :try_end_flush
    .catch Ljava/lang/Exception; {:try_start_flush .. :try_end_flush} :catch_flush

    :catch_flush
    return-void
.end method

.method public setOnStreamResourcesLostListener(Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;)V
    .locals 0

    iput-object p1, p0, Lcom/androradar/walls6/VideoStream;->mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;

    return-void
.end method

.method public start()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/androradar/walls6/VideoStream$VideoNotInitializedException;,
            Ljava/io/IOException;,
            Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException;
        }
    .end annotation

    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/androradar/walls6/VideoStream;->configure()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    iput-boolean v2, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    iput-boolean v2, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    return-void
.end method

.method public stop()V
    .locals 2

    const/4 v1, 0x0

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_skip_stop

    :try_start_stop
    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V
    :try_end_stop
    .catch Ljava/lang/Exception; {:try_start_stop .. :try_end_stop} :catch_stop

    :catch_stop
    :cond_skip_stop
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoStream;->release()V

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mConfigured:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    :cond_0
    return-void
.end method

.method public setPauseTimeUs(J)V
    .locals 2

    iput-wide p1, p0, Lcom/androradar/walls6/VideoStream;->mPauseTimeUs:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    return-void
.end method

.method public isTargetReached()Z
    .locals 1

    iget-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    return v0
.end method

.method public resetStartTime()V
    .locals 3

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    return-void
.end method

.method public seekTo(J)V
    .locals 4
    :try_start_seek
    invoke-direct {p0}, Lcom/androradar/walls6/VideoStream;->configure()V
    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;
    invoke-virtual {v0}, Landroid/media/MediaCodec;->flush()V
    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;
    const/4 v1, 0x0
    invoke-virtual {v0, p1, p2, v1}, Landroid/media/MediaExtractor;->seekTo(JI)V
    iput-wide p1, p0, Lcom/androradar/walls6/VideoStream;->mRenderFromUs:J
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoStream;->resetStartTime()V
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z
    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z
    :try_end_seek
    .catch Ljava/lang/Exception; {:try_start_seek .. :try_end_seek} :catch_seek
    return-void
    :catch_seek
    move-exception v0
    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mOnStreamResourcesLostListener:Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;
    if-eqz v0, :seek_done
    invoke-interface {v0}, Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;->onStreamResourcesLost()V
    :seek_done
    return-void
.end method

