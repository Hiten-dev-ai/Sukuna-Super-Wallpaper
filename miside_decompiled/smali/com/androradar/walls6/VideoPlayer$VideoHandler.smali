.class Lcom/androradar/walls6/VideoPlayer$VideoHandler;
.super Ljava/lang/Object;
.source "VideoPlayer.java"

# interfaces
.implements Landroid/os/Handler$Callback;
.implements Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/VideoPlayer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "VideoHandler"
.end annotation


# static fields
.field private static final ADVANCE_MESSAGE:I = 0x2

.field private static final PLAY_MESSAGE:I = 0x0

.field private static final REWINDING_MESSAGE:I = 0x4

.field private static final REWIND_MESSAGE:I = 0x3

.field private static final STOP_MESSAGE:I = 0x1


# instance fields
.field private final mHandler:Landroid/os/Handler;

.field private mResourcesLost:Z

.field private mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

.field final synthetic this$0:Lcom/androradar/walls6/VideoPlayer;


# direct methods
.method public constructor <init>(Lcom/androradar/walls6/VideoPlayer;)V
    .locals 3

    iput-object p1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->STOPPED:Lcom/androradar/walls6/VideoPlayer$StreamState;

    iput-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mResourcesLost:Z

    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "VideoHandlerThread"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2, p0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;Landroid/os/Handler$Callback;)V

    iput-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-static {p1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/androradar/walls6/VideoStream;->setOnStreamResourcesLostListener(Lcom/androradar/walls6/VideoStream$OnStreamResourcesLostListener;)V

    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->rewindStream()V

    return-void
.end method

.method private changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V
    .locals 0

    iput-object p1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    return-void
.end method

.method private rewindStream()V
    .locals 2

    :try_start_0
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->rewind()V
    :try_end_0
    .catch Lcom/androradar/walls6/VideoStream$VideoNotInitializedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    :goto_1
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->onStreamResourcesLost()V

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v0

    goto :goto_1
.end method


# virtual methods
.method public dispose()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)Z
    .locals 6

    const/4 v5, 0x4

    const/4 v4, 0x2

    const/4 v3, 0x1

    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    :cond_0
    :goto_0
    return v3

    :pswitch_0
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v2, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-eq v1, v2, :cond_already_playing

    :try_start_0
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->start()V
    :try_end_0
    .catch Lcom/androradar/walls6/VideoStream$VideoNotInitializedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/androradar/walls6/VideoStream$IncorrectFileTypeException; {:try_start_0 .. :try_end_0} :catch_0

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v1}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    :cond_already_playing
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v4}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0

    :catch_0
    move-exception v0

    :goto_1
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->onStreamResourcesLost()V

    goto :goto_0

    :pswitch_1
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->stop()V

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->STOPPED:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v1}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    goto :goto_0

    :pswitch_2
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v2, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->advance()Z

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->reachedEndOfStream()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->isTargetReached()Z

    move-result v1

    if-eqz v1, :cond_schedule_advance

    goto :goto_0

    :cond_schedule_advance
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v4}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0

    :cond_1
    iget-boolean v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mResourcesLost:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$100(Lcom/androradar/walls6/VideoPlayer;)V

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->STOPPED:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v1}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->stop()V

    goto :goto_0

    :pswitch_3
    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->rewindStream()V

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->REWINDING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v1}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v5}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto :goto_0

    :pswitch_4
    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v2, Lcom/androradar/walls6/VideoPlayer$StreamState;->REWINDING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v1}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v1

    invoke-virtual {v1}, Lcom/androradar/walls6/VideoStream;->advance()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v5}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    goto/16 :goto_0

    :cond_2
    invoke-direct {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->rewindStream()V

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->STOPPED:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v1}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    goto/16 :goto_0

    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v0

    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public onStreamResourcesLost()V
    .locals 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mResourcesLost:Z

    iget-object v1, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    iget-object v2, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v2}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v2

    invoke-virtual {v2}, Lcom/androradar/walls6/VideoStream;->hasRenderedOneFrame()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v3, Lcom/androradar/walls6/VideoPlayer$StreamState;->REWINDING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v2, v3, :cond_1

    :cond_0
    :goto_0
    invoke-static {v1, v0}, Lcom/androradar/walls6/VideoPlayer;->access$200(Lcom/androradar/walls6/VideoPlayer;Z)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    sget-object v0, Lcom/androradar/walls6/VideoPlayer$StreamState;->STOPPED:Lcom/androradar/walls6/VideoPlayer$StreamState;

    invoke-direct {p0, v0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->changeState(Lcom/androradar/walls6/VideoPlayer$StreamState;)V

    return-void

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public play()V
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
.end method

.method public rewind()V
    .locals 2

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public stop()V
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
.end method

.method public resumeAdvance()V
    .locals 5

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mStreamState:Lcom/androradar/walls6/VideoPlayer$StreamState;

    sget-object v1, Lcom/androradar/walls6/VideoPlayer$StreamState;->PLAYING:Lcom/androradar/walls6/VideoPlayer$StreamState;

    if-ne v0, v1, :cond_resume_direct

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    return-void

    :cond_resume_direct
    iget-object v0, p0, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->this$0:Lcom/androradar/walls6/VideoPlayer;

    invoke-static {v0}, Lcom/androradar/walls6/VideoPlayer;->access$000(Lcom/androradar/walls6/VideoPlayer;)Lcom/androradar/walls6/VideoStream;

    move-result-object v0

    if-eqz v0, :cond_resume_play

    const-wide/32 v2, 0x2dc6c0

    invoke-virtual {v0, v2, v3}, Lcom/androradar/walls6/VideoStream;->seekTo(J)V

    :cond_resume_play
    invoke-virtual {p0}, Lcom/androradar/walls6/VideoPlayer$VideoHandler;->play()V

    return-void
.end method

