import os

path_stream = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoStream.smali"

with open(path_stream, "r", encoding="utf-8") as f:
    content = f.read()

norm_content = content.replace("\r\n", "\n")

# SeekTo method replacement
# Find from .method public seekTo(J)V to .end method
import re
pattern = r"\.method public seekTo\(J\)V.*?\n\.end method"

new_seekTo = """.method public seekTo(J)V
    .locals 13

    :try_start_seek_cfg
    invoke-direct {p0}, Lcom/androradar/walls6/VideoStream;->configure()V
    :try_end_seek_cfg
    .catch Ljava/lang/Exception; {:try_start_seek_cfg .. :try_end_seek_cfg} :catch_seek

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    if-eqz v0, :cond_seek_flush

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1}, Landroid/media/MediaExtractor;->seekTo(JI)V

    :cond_seek_flush
    iget-object v4, p0, Lcom/androradar/walls6/VideoStream;->mMediaCodec:Landroid/media/MediaCodec;

    if-nez v4, :cond_seek_feed

    goto :cond_seek_reset

    :cond_seek_feed
    :try_start_seek_flush
    invoke-virtual {v4}, Landroid/media/MediaCodec;->flush()V
    :try_end_seek_flush
    .catch Ljava/lang/Exception; {:try_start_seek_flush .. :try_end_seek_flush} :catch_seek

    :try_start_seek_decode
    const-wide/16 v0, 0x2710

    invoke-virtual {v4, v0, v1}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v5

    if-ltz v5, :cond_seek_out_loop

    invoke-virtual {v4, v5}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    if-eqz v11, :cond_seek_out_loop

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    const/4 v6, 0x0

    invoke-virtual {v0, v11, v6}, Landroid/media/MediaExtractor;->readSampleData(Ljava/nio/ByteBuffer;I)I

    move-result v7

    if-lez v7, :cond_seek_out_loop

    invoke-virtual {v0}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v8

    const/4 v6, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v4 .. v10}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    invoke-virtual {v0}, Landroid/media/MediaExtractor;->advance()Z

    :cond_seek_out_loop
    new-instance v12, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v12}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    const/4 v2, 0x0

    :seek_retry_loop
    const/4 v3, 0x5

    if-ge v2, v3, :cond_seek_reset

    const-wide/16 v0, 0x3a98

    invoke-virtual {v4, v12, v0, v1}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v5

    if-ltz v5, :cond_seek_check_neg

    const-wide/16 v0, 0x0

    invoke-virtual {v4, v5, v0, v1}, Landroid/media/MediaCodec;->releaseOutputBuffer(IJ)V

    goto :cond_seek_reset

    :cond_seek_check_neg
    const/4 v0, -0x2

    if-ne v5, v0, :cond_seek_check_again

    add-int/lit8 v2, v2, 0x1

    goto :seek_retry_loop

    :cond_seek_check_again
    const/4 v0, -0x1

    if-ne v5, v0, :cond_seek_reset

    const-wide/16 v0, 0x1388

    invoke-virtual {v4, v0, v1}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v5

    if-ltz v5, :cond_seek_inc_retry

    invoke-virtual {v4, v5}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    if-eqz v11, :cond_seek_inc_retry

    iget-object v0, p0, Lcom/androradar/walls6/VideoStream;->mMediaExtractor:Landroid/media/MediaExtractor;

    const/4 v6, 0x0

    invoke-virtual {v0, v11, v6}, Landroid/media/MediaExtractor;->readSampleData(Ljava/nio/ByteBuffer;I)I

    move-result v7

    if-lez v7, :cond_seek_inc_retry

    invoke-virtual {v0}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v8

    const/4 v6, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v4 .. v10}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    invoke-virtual {v0}, Landroid/media/MediaExtractor;->advance()Z

    :cond_seek_inc_retry
    add-int/lit8 v2, v2, 0x1

    goto :seek_retry_loop
    :try_end_seek_decode
    .catch Ljava/lang/Exception; {:try_start_seek_decode .. :try_end_seek_decode} :catch_seek

    :cond_seek_reset
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/androradar/walls6/VideoStream;->mStartTimeNanos:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mInEos:Z

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mOutEos:Z

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoStream;->mTargetReached:Z

    :catch_seek
    return-void
.end method"""

norm_content, count = re.subn(pattern, new_seekTo, norm_content, count=1, flags=re.DOTALL)
assert count == 1, "seekTo pattern not matched"

if "\r\n" in content:
    norm_content = norm_content.replace("\n", "\r\n")

with open(path_stream, "w", encoding="utf-8", newline="") as f:
    f.write(norm_content)

print("SUCCESS: Updated seekTo in VideoStream.smali with .locals 13")
